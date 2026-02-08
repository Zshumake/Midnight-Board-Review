import { episodes } from './episodes.js';
import { ui } from './ui.js';
import { state } from './state.js';

import { Share } from './share.js';
import { Library } from './library.js';
import { Tracking } from './tracking.js';
import { InfoModal } from './modules/infoModal.js';
import { ReportModal } from './modules/reportModal.js';
import { StickyPlayer } from './modules/stickyPlayer.js';
import { RssModal } from './modules/rssModal.js';

// --- State Variables ---
let currentIndex = 0;
let isFirstLoad = true;
let playPromise = undefined; // Track valid play request
let isPreloading = false;    // Track auto-preloading state
let isPlayingSilence = false; // Track mobile-safe gap state
let autoplayTimer = null;    // Track 5s delay timer (safety ref)
let needsRestoration = false; // Flag for emergency jump
let targetStartTime = 0;     // Lock for saveCurrentPosition
let activeLoadId = 0;       // Safeguard for rapid switching
let lastKnownTime = 0;      // Cache for atomic saves
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

// 1. Setup Local Listeners (Non-Player)
// 1. Setup Local Listeners (Non-Player)
console.log('Player.js: Calling InfoModal.init()...');
InfoModal.init();
document.getElementById('info-btn')?.addEventListener('click', () => {
    console.log('Info button clicked');
    InfoModal.show();
});

// Init Report Modal
ReportModal.init(episodes);
const reportBtn = document.getElementById('report-issue-btn');
if (reportBtn) {
    const showReport = (e) => {
        if (e.type === 'touchstart') e.preventDefault(); // Prevent double-fire on some devices
        const currentEpisode = episodes[currentIndex];
        ReportModal.show(currentEpisode ? currentEpisode.title : null);
    };
    reportBtn.addEventListener('click', showReport);
    reportBtn.addEventListener('touchstart', showReport, { passive: false });
} else {
    console.error('Report Issue Button not found in DOM');
}

// 2. Library & Category Logic
Library.initCategories(episodes, ui, () => {
    renderLibrary(ui.searchInput.value);
});

// 3. Setup Main Player Event Listeners
setupEventListeners();

// 4. Initial Episode Load (Prep)
loadEpisode(currentIndex);

// 5. Shared Click Handler for Library
const onEpisodeClick = (idx, action) => {
    const index = Number(idx);
    if (action === 'play') {
        if (Number(currentIndex) === index) {
            if (currentAudio.paused) playAudio(); else pauseAudio();
        } else {
            loadEpisode(index);
        }
    }
};

// 6. Initial Full Library Render
ui.renderLibrary(episodes, currentIndex, state, onEpisodeClick, (url) => preloadEpisode(url));

// 7. Modals
// Tutorial.init() removed as it was replaced by InfoModal


/**
 * Filtered render of the library using Library Module
 */
function renderLibrary(filter = '') {
    const filtered = Library.filterEpisodes(episodes, filter);

    ui.renderLibrary(filtered, currentIndex, state, (idx, action) => {
        const index = Number(idx);
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
    }, (url) => preloadEpisode(url), filter);
}

/**
 * Load an episode
 */
function loadEpisode(index) {
    activeLoadId++;
    const currentId = activeLoadId;

    if (autoplayTimer) {
        clearTimeout(autoplayTimer);
        autoplayTimer = null;
    }

    // 1. Immediately Save Previous Using Cache
    if (lastKnownTime > 1) {
        state.setPosition(episodes[currentIndex].title, lastKnownTime);
    }
    lastKnownTime = 0; // Reset for new track

    // 2. Halt Previous
    currentAudio.pause();
    currentAudio.src = '';
    // ui.setLoading(true) moved down to ensure it targets the correct new row
    isPlayingSilence = false;
    needsRestoration = false;

    // Reset Tracking
    Tracking.reset();

    currentIndex = index;
    state.setLastIndex(index);

    // Force UI to acknowledge new index immediately so setLoading targets correct row
    ui.updateListPlayStates(currentIndex, false, state);
    ui.setLoading(true); // Now targets the newly active row

    const episode = episodes[index];
    const startTime = determineStartTime(state, episode.title, state.getDuration(episode.title), isFirstLoad);
    targetStartTime = startTime;
    needsRestoration = startTime > 5;

    // Initial UI Setup
    const listened = state.isListened(episode.title);
    const nextEpisode = episodes[(index + 1) % episodes.length];

    ui.updateTrack(episode, listened, nextEpisode);
    ui.updateProgress(startTime, state.getDuration(episode.title));
    ui.setPlaying(false);

    // updateListPlayStates will be called by 'pause' listener above due to .pause()

    const handleMetadata = () => {
        // Guard: If a new load has started, ignore this one
        if (currentId !== activeLoadId) return;

        const savedSpeed = state.getSpeed();
        currentAudio.playbackRate = savedSpeed;
        if (ui.speedSelect) ui.speedSelect.value = savedSpeed;
        StickyPlayer.syncSpeed(savedSpeed);
        state.setDuration(episode.title, currentAudio.duration);

        const realStartTime = determineStartTime(state, episode.title, currentAudio.duration, isFirstLoad);
        if (realStartTime > 0 && Math.abs(currentAudio.currentTime - realStartTime) > 2) {
            currentAudio.currentTime = realStartTime;
        }

        ui.setLoading(false);
        isPreloading = false;
        updateMediaSession(episode);
    };

    const wasFirstLoad = isFirstLoad;
    if (isFirstLoad) isFirstLoad = false;

    currentAudio.addEventListener('loadedmetadata', handleMetadata, { once: true });

    currentAudio.src = startTime > 1 ? `${episode.url}#t=${startTime}` : episode.url;

    // Only auto-play if it's NOT the first load
    currentAudio.autoplay = !wasFirstLoad;

    updateMediaSession(episode); // Immediate update for lock screen continuity

    if (wasFirstLoad) {
        // Just load metadata/buffer, don't play
        currentAudio.load();
        ui.setPlaying(false); // Ensure UI shows paused state
    } else {
        playAudio(currentId);
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
    if (!episode) return;

    const currentTime = currentAudio.currentTime;
    if (currentTime > 0) lastKnownTime = currentTime;

    // SHIELD: Ignore 0 if we are in the middle of a restore
    if (needsRestoration && currentTime < 5) return;

    // TargetStartTime check: if we haven't crossed the target yet, don't save a low number
    if (targetStartTime > 5 && currentTime < 5) return;

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

function playAudio(loadId = null) {
    // 1. Safe Guard: If no src, load current index first
    if (!currentAudio.src || currentAudio.src === window.location.href) {
        ui.showError("DEBUG: Reloading (No Src)"); // Diagnostic
        loadEpisode(currentIndex);
        return;
    }

    // 2. Load ID Guard: If valid play request from a specific load, but we changed load, abort
    // Fix: MediaSession passes an event object, which is not null. Ensure loadId is a number before checking.
    if (typeof loadId === 'number' && loadId !== activeLoadId) return;

    // 3. Prioritize play() promise for Safari trust
    playPromise = currentAudio.play();

    if (playPromise !== undefined) {
        playPromise.then(_ => {
            // Guard: If load changed while we were waiting for the engine
            if (typeof loadId === 'number' && loadId !== activeLoadId) {
                currentAudio.pause();
                return;
            }

            saveCurrentPosition();

            if (needsRestoration) {
                const ep = episodes[currentIndex];
                const pos = state.getPosition(ep.title);
                if (pos > 5 && currentAudio.currentTime < 2) {
                    currentAudio.currentTime = pos;
                }

                needsRestoration = false;
            }
            updateMediaSessionState(); // Force lock screen to know we are playing
            ui.showError(`DEBUG: Success. Paused=${currentAudio.paused}`); // Diagnostic
        }).catch(error => {
            if (error.name !== 'AbortError') {
                console.error("Play rejected:", error);
                // SHOW ERROR ON SCREEN FOR DEBUGGING
                ui.showError(`Play Error: ${error.message || error.name}`);
            }
        });
    }
}

function pauseAudio() {
    if (playPromise !== undefined) {
        playPromise.then(_ => {
            currentAudio.pause();
            saveCurrentPosition();
        }).catch(() => {
            // Even if play failed, try to pause if it somehow started
            currentAudio.pause();
        });
    } else {
        currentAudio.pause();
        saveCurrentPosition();
    }
}

function skip(amount) {
    currentAudio.currentTime = Math.max(0, Math.min(currentAudio.duration || 0, currentAudio.currentTime + amount));
    updateMediaSessionState();
    saveCurrentPosition();
}

function playNext() {
    loadEpisode((Number(currentIndex) + 1) % episodes.length);
}

function playPrev() {
    loadEpisode((Number(currentIndex) - 1 + episodes.length) % episodes.length);
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

        // Handlers moved to setupEventListeners to run ONCE.

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
        if (Math.floor(currentTime) % 5 === 0) {
            saveCurrentPosition();
            updateMediaSessionState(); // Keep lock screen honest
        }
    });

    // --- MediaSession Listeners (Init Once) ---
    if ('mediaSession' in navigator) {
        navigator.mediaSession.setActionHandler('play', () => {
            ui.showError("DEBUG: Lock Screen Play"); // Diagnostic
            playAudio(null);
            navigator.mediaSession.playbackState = 'playing';
        });
        navigator.mediaSession.setActionHandler('pause', () => {
            pauseAudio();
            navigator.mediaSession.playbackState = 'paused';
        });
        navigator.mediaSession.setActionHandler('seekbackward', () => skip(-10));
        navigator.mediaSession.setActionHandler('seekforward', () => skip(10));
        navigator.mediaSession.setActionHandler('previoustrack', playPrev);
        navigator.mediaSession.setActionHandler('nexttrack', playNext);
    }

    // Share & Deep Linking Listeners

    RssModal.init();

    // Context Menu Events
    document.addEventListener('manual-mastery', (e) => {
        const title = e.detail.title;
        if (title) {
            state.incrementCompletion(title);
            renderLibrary(ui.searchInput.value);
            if (episodes[currentIndex].title === title) {
                ui.updateTrack(episodes[currentIndex], true, episodes[(currentIndex + 1) % episodes.length]);
            }
        }
    });

    // Sticky Player (Modular)
    StickyPlayer.init({
        togglePlay: () => { if (currentAudio.paused) playAudio(); else pauseAudio(); },
        skip: (val) => skip(val),
        setSpeed: (speed) => {
            currentAudio.playbackRate = speed;
            state.setSpeed(speed);
            if (ui.speedSelect) ui.speedSelect.value = speed;
        }
    });

    // Drag Scrubbing
    if (ui.progressContainer) setupScrub(ui.progressContainer);
    if (ui.stickyProgressContainer) setupScrub(ui.stickyProgressContainer);

    // --- Audio Engine Core Listeners (Single Source of Truth) ---
    currentAudio.addEventListener('playing', () => {
        ui.setPlaying(true);
        ui.updateListPlayStates(currentIndex, true, state);
        updateMediaSessionState();
    });

    currentAudio.addEventListener('pause', () => {
        ui.setPlaying(false);
        ui.updateListPlayStates(currentIndex, false, state);
        updateMediaSessionState();
    });

    currentAudio.addEventListener('waiting', () => {
        ui.setLoading(true);
    });

    currentAudio.addEventListener('canplay', () => {
        ui.setLoading(false);
    });

    currentAudio.addEventListener('error', () => {
        console.error("Audio Error Code:", currentAudio.error ? currentAudio.error.code : "unknown");
        ui.showError('Error playing audio. Please try again.');
        ui.setPlaying(false);
    });

    currentAudio.addEventListener('ended', playNext);
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
