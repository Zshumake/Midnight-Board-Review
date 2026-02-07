import { episodes } from './episodes.js';
import { ui } from './ui.js';
import { state } from './state.js';
import { WelcomeModal } from './welcomeModal.js';
import { Share } from './share.js';
import { Library } from './library.js';
import { Tracking } from './tracking.js';

// --- State Variables ---
let currentIndex = 0;
let isFirstLoad = true;
let playPromise = undefined; // Track valid play request
let isPreloading = false;    // Track auto-preloading state
let isPlayingSilence = false; // Track mobile-safe gap state
let autoplayTimer = null;    // Track 5s delay timer (safety ref)
let needsRestoration = false; // Flag for emergency jump
let targetStartTime = 0;     // Lock for saveCurrentPosition
const preloadAudio = new Audio(); // Singleton for hover preloading
const currentAudio = ui.audio; // Alias

// Load saved state
state.load();

// --- Init & Deep Linking ---
const deepLinkIndex = Share.initDeepLinking(episodes, state);
if (deepLinkIndex !== null) {
    currentIndex = deepLinkIndex;
} else {
    currentIndex = state.data.lastIndex || 0;
}

// --- Library & Category Setup ---
// Initialize Tabs (Pass callback for when filter changes)
Library.initCategories(episodes, ui, () => {
    renderLibrary(ui.searchInput.value);
});

// Initialize Library Render
const onEpisodeClick = (index, action) => {
    if (action === 'play') {
        if (Number(currentIndex) === Number(index)) {
            if (currentAudio.paused) playAudio(); else pauseAudio();
        } else {
            loadEpisode(index);
        }
    }
};

// Initial Render
ui.renderLibrary(episodes, currentIndex, state, onEpisodeClick, (url) => preloadEpisode(url));

// Initialize Modal
WelcomeModal.init();

// Start
loadEpisode(currentIndex);
setupEventListeners();


/**
 * Filtered render of the library using Library Module
 */
function renderLibrary(filter = '') {
    const filtered = Library.filterEpisodes(episodes, filter);

    ui.renderLibrary(filtered, currentIndex, state, (index, action) => {
        if (action === 'play') {
            if (currentIndex === index) {
                if (currentAudio.paused) playAudio(); else pauseAudio();
            } else {
                loadEpisode(index);
            }
        } else if (action === 'skip-back') {
            skip(-10);
        } else if (action === 'skip-fwd') {
            skip(10);
        } else {
            loadEpisode(index);
        }
    }, (url) => preloadEpisode(url));
}

/**
 * Load an episode
 */
function loadEpisode(index) {
    if (autoplayTimer) {
        clearTimeout(autoplayTimer);
        autoplayTimer = null;
    }

    isPlayingSilence = false;
    needsRestoration = false; // Reset for new track

    // Reset Tracking
    Tracking.reset();

    currentIndex = index;
    state.setLastIndex(index);

    const episode = episodes[index];
    const savedPos = state.getPosition(episode.title);

    // Update UI Metadata
    document.getElementById('current-track-title').innerText = episode.title;
    const descEl = document.getElementById('current-track-description');
    if (descEl) descEl.innerText = episode.description || '';
    const startTime = determineStartTime(state, episode.title, state.getDuration(episode.title), isFirstLoad);
    targetStartTime = startTime;
    needsRestoration = startTime > 5;

    // Initial UI Setup
    const listened = state.isListened(episode.title);
    ui.updateTrack(episode, listened);
    ui.updateProgress(startTime, state.getDuration(episode.title));
    ui.setPlaying(false);
    ui.updateListPlayStates(episode.title, false, state);

    const handleMetadata = () => {
        const savedSpeed = state.getSpeed();
        currentAudio.playbackRate = savedSpeed;
        if (ui.speedSelect) ui.speedSelect.value = savedSpeed;
        if (ui.stickySpeedSelect) ui.stickySpeedSelect.value = savedSpeed;
        state.setDuration(episode.title, currentAudio.duration);

        // Even with fragment, we seek again for safety
        const realStartTime = determineStartTime(state, episode.title, currentAudio.duration, isFirstLoad);
        if (realStartTime > 0 && Math.abs(currentAudio.currentTime - realStartTime) > 2) {
            currentAudio.currentTime = realStartTime;
        }

        isPreloading = false;
        updateMediaSession(episode);
    };

    const wasFirstLoad = isFirstLoad;
    if (isFirstLoad) isFirstLoad = false;

    currentAudio.preload = 'auto';
    currentAudio.addEventListener('loadedmetadata', handleMetadata, { once: true });

    // NUCLEAR OPTION: Source Fragment (#t=)
    // This tells Safari to start at X seconds natively.
    currentAudio.src = startTime > 1 ? `${episode.url}#t=${startTime}` : episode.url;
    currentAudio.load();

    if (!wasFirstLoad) {
        playAudio();
    }
}

function determineStartTime(state, title, duration, isFirstLoad) {
    const savedPos = state.getPosition(title);
    // Always load position (resume), but don't auto-play (handled by caller)
    if (isFirstLoad) return savedPos;

    const isNearEnd = duration > 0 && savedPos > (duration * 0.95);
    if (isNearEnd) return 0;
    return savedPos;
}

function saveCurrentPosition() {
    const episode = episodes[currentIndex];
    const currentTime = currentAudio.currentTime;

    // SHIELD: Do not save 0:00 or low numbers if we are expecting a restore.
    // This prevents the "0 overwrites progress" bug.
    if (targetStartTime > 5) {
        // If we haven't crossed/reached the targetStartTime yet, it means the seek is still working.
        // We only unlock saving once we are safely within the restored range.
        if (Math.abs(currentTime - targetStartTime) > 5 && currentTime < 5) {
            return;
        }
    }

    if (currentTime > 0) {
        state.setPosition(episode.title, currentTime);
    }
}

function preloadEpisode(url) {
    if (preloadAudio.src !== url) {
        preloadAudio.src = url;
        preloadAudio.preload = 'auto';
        preloadAudio.load();
    }
}

function playAudio() {
    const currentSpeed = state.getSpeed();
    if (currentAudio.playbackRate !== currentSpeed) {
        currentAudio.playbackRate = currentSpeed;
    }

    // Double-check restoration on play (Crucial for Mobile/Safari)
    if (needsRestoration) {
        const episode = episodes[currentIndex];
        const savedPos = state.getPosition(episode.title);
        // If the fragment and metadata seek failed, do a hard jump
        if (savedPos > 0 && Math.abs(currentAudio.currentTime - savedPos) > 2) {
            console.log("Emergency Restore during Play Gesture");
            currentAudio.currentTime = savedPos;
        }
    }

    saveCurrentPosition(); // Save immediately when play starts

    playPromise = currentAudio.play();
    if (playPromise !== undefined) {
        playPromise.then(_ => {
            ui.setPlaying(true);
            updateMediaSessionState(); // Sync after play starts

            // Final safety check: If after play starts we are still at 0, force the jump
            if (needsRestoration) {
                const ep = episodes[currentIndex];
                const pos = state.getPosition(ep.title);
                if (pos > 5 && currentAudio.currentTime < 2) {
                    console.log("PWA Force-Restoring to:", pos);
                    currentAudio.currentTime = pos;
                }
                needsRestoration = false;
            }
        })
            .catch(error => {
                if (error.name !== 'AbortError') ui.showError(error.message);
                ui.setPlaying(false);
                updateMediaSessionState();
            });
    }

    const episode = episodes[currentIndex];
    ui.updateListPlayStates(episode.title, true, state);
}

function pauseAudio() {
    if (playPromise !== undefined) {
        playPromise.then(_ => {
            currentAudio.pause();
            ui.setPlaying(false);
            updateMediaSessionState();
            saveCurrentPosition(); // Critical for iOS PWA!
        }).catch(() => { });
    } else {
        currentAudio.pause();
        ui.setPlaying(false);
        updateMediaSessionState();
        saveCurrentPosition();
    }
    const episode = episodes[currentIndex];
    ui.updateListPlayStates(episode.title, false, state);
}

function skip(amount) {
    currentAudio.currentTime = Math.max(0, Math.min(currentAudio.duration || 0, currentAudio.currentTime + amount));
    updateMediaSessionState();
    saveCurrentPosition();
}

function playNext() {
    loadEpisode((currentIndex + 1) % episodes.length);
}

function playPrev() {
    loadEpisode((currentIndex - 1 + episodes.length) % episodes.length);
}

function preloadNextEpisode() {
    const nextIndex = (currentIndex + 1) % episodes.length;
    const nextEpisode = episodes[nextIndex];
    if (!nextEpisode) return;
    const preloadAudio = new Audio();
    preloadAudio.src = nextEpisode.url;
    preloadAudio.preload = 'auto';
    isPreloading = true;
}

function updateMediaSession(episode) {
    if ('mediaSession' in navigator) {
        navigator.mediaSession.metadata = new MediaMetadata({
            title: episode.title,
            artist: 'Midnight Review',
            album: 'Board Review Podcast',
            artwork: [{ src: 'cover.jpg?v=6', sizes: '512x512', type: 'image/jpeg' }]
        });
        navigator.mediaSession.setActionHandler('play', playAudio);
        navigator.mediaSession.setActionHandler('pause', pauseAudio);
        navigator.mediaSession.setActionHandler('seekbackward', () => skip(-10));
        navigator.mediaSession.setActionHandler('seekforward', () => skip(10));
        navigator.mediaSession.setActionHandler('previoustrack', playPrev);
        navigator.mediaSession.setActionHandler('nexttrack', playNext);

        // Initial state sync
        updateMediaSessionState();
    }
}

/**
 * Synchronize the lock screen timer and state with the actual audio element
 */
function updateMediaSessionState() {
    if ('mediaSession' in navigator) {
        // Update Playback State
        navigator.mediaSession.playbackState = currentAudio.paused ? 'paused' : 'playing';

        // Update Position State (Lock screen timer accuracy)
        if ('setPositionState' in navigator.mediaSession) {
            try {
                navigator.mediaSession.setPositionState({
                    duration: currentAudio.duration || 0,
                    playbackRate: currentAudio.playbackRate || 1.0,
                    position: currentAudio.currentTime || 0
                });
            } catch (e) {
                // Ignore if audio isn't ready
            }
        }
    }
}

function setupEventListeners() {
    ui.playBtn.addEventListener('click', () => { if (currentAudio.paused) playAudio(); else pauseAudio(); });
    ui.prevBtn.addEventListener('click', playPrev);
    ui.nextBtn.addEventListener('click', playNext);
    ui.skipBackBtn.addEventListener('click', () => skip(-10));
    ui.skipFwdBtn.addEventListener('click', () => skip(10));
    currentAudio.addEventListener('ended', playNext);

    // Speed Control
    const handleSpeed = (speed) => {
        currentAudio.playbackRate = speed;
        if (ui.speedSelect) ui.speedSelect.value = speed;
        if (ui.stickySpeedSelect) ui.stickySpeedSelect.value = speed;
        state.setSpeed(speed);
    };
    ui.speedSelect.addEventListener('change', () => handleSpeed(parseFloat(ui.speedSelect.value)));
    if (ui.stickySpeedSelect) {
        ui.stickySpeedSelect.addEventListener('change', () => handleSpeed(parseFloat(ui.stickySpeedSelect.value)));
    }

    // Save on unload and state changes
    window.addEventListener('beforeunload', saveCurrentPosition);
    document.addEventListener('visibilitychange', () => {
        if (document.hidden) saveCurrentPosition();
    });
    window.addEventListener('pagehide', saveCurrentPosition);

    // Search
    ui.searchInput.addEventListener('input', (e) => renderLibrary(e.target.value));

    // Time Update & Tracking
    currentAudio.addEventListener('timeupdate', () => {
        const currentTime = currentAudio.currentTime;
        const duration = currentAudio.duration;

        // Unlock Persistence Shield if seek succeeded
        if (targetStartTime > 0 && Math.abs(currentTime - targetStartTime) < 2) {
            targetStartTime = 0;
            needsRestoration = false;
        }

        // 1. Update Tracking (Anti-Skip)
        Tracking.update(currentTime, currentAudio.paused, ui.isDragging);

        // 2. Check for Badge
        Tracking.checkCompletion(duration, episodes[currentIndex], state, ui);

        // 3. Visual Update
        if (!ui.isDragging) {
            ui.updateProgress(currentTime, duration);
        }

        // 4. Preload
        const timeLeft = duration - currentTime;
        if (timeLeft <= 10 && timeLeft > 0 && !isPreloading) {
            preloadNextEpisode();
        }

        // 5. Save State Throttled
        if (Math.floor(currentTime) % 5 === 0) {
            saveCurrentPosition();
            updateMediaSessionState(); // Keep lock screen honest
        }
    });

    // Share & Deep Linking Listeners
    Share.setupShareButton(ui, () => currentIndex, () => currentAudio.currentTime);
    Share.setupRssCopy(ui);

    // Context Menu Event (Manual Mastery)
    document.addEventListener('manual-mastery', (e) => {
        const title = e.detail.title;
        if (title) {
            state.incrementCompletion(title);
            renderLibrary(ui.searchInput.value);
            if (episodes[currentIndex].title === title) {
                ui.updateTrack(episodes[currentIndex], true);
            }
        }
    });

    // Sticky Player
    if (ui.stickyPlayBtn) {
        ui.stickyPlayBtn.addEventListener('click', () => { if (currentAudio.paused) playAudio(); else pauseAudio(); });
    }
    if (ui.stickySkipBack) ui.stickySkipBack.addEventListener('click', () => skip(-10));
    if (ui.stickySkipFwd) ui.stickySkipFwd.addEventListener('click', () => skip(10));

    // Drag Scrubbing
    if (ui.progressContainer) setupScrub(ui.progressContainer);
    if (ui.stickyProgressContainer) setupScrub(ui.stickyProgressContainer);

    // Error Handling
    currentAudio.addEventListener('error', () => {
        ui.showError('Error playing audio.');
        ui.setPlaying(false);
    });
}

function setupScrub(container) {
    addScrubbingListeners(container, (percent) => {
        ui.updateProgress(currentAudio.duration * (percent / 100), currentAudio.duration);
    }, (percent) => {
        if (currentAudio.duration) {
            currentAudio.currentTime = (percent / 100) * currentAudio.duration;
            saveCurrentPosition();
        }
    });
}

/**
 * Helper to add Mouse/Touch scrubbing events (retained as helper)
 */
function addScrubbingListeners(container, onDrag, onCommit) {
    const handleMove = (e) => {
        if (!ui.isDragging) return;
        const rect = container.getBoundingClientRect();
        const clientX = e.touches ? e.touches[0].clientX : e.clientX;
        let percent = ((clientX - rect.left) / rect.width) * 100;
        percent = Math.max(0, Math.min(100, percent));
        onDrag(percent);
    };

    const handleEnd = (e) => {
        if (!ui.isDragging) return;
        ui.isDragging = false;
        const rect = container.getBoundingClientRect();
        const clientX = e.changedTouches ? e.changedTouches[0].clientX : e.clientX;
        let percent = ((clientX - rect.left) / rect.width) * 100;
        percent = Math.max(0, Math.min(100, percent));
        onCommit(percent);
        document.removeEventListener('mousemove', handleMove);
        document.removeEventListener('touchmove', handleMove);
        document.removeEventListener('mouseup', handleEnd);
        document.removeEventListener('touchend', handleEnd);
    };

    const handleStart = (e) => {
        ui.isDragging = true;
        handleMove(e);
        document.addEventListener('mousemove', handleMove);
        document.addEventListener('touchmove', handleMove, { passive: false });
        document.addEventListener('mouseup', handleEnd);
        document.addEventListener('touchend', handleEnd);
    };

    container.addEventListener('mousedown', handleStart);
    container.addEventListener('touchstart', handleStart, { passive: false });
}
