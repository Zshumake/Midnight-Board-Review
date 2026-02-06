import { episodes } from './episodes.js';
import { ui } from './ui.js';
import { state } from './state.js';
import { WelcomeModal } from './welcomeModal.js';

// --- State Variables (Defined at top to avoid ReferenceError) ---
let currentIndex = 0;
let isFirstLoad = true;
let playPromise = undefined; // Track valid play request
let isPreloading = false;    // Track auto-preloading state
let isPlayingSilence = false; // Track mobile-safe gap state
let autoplayTimer = null;    // Track 5s delay timer (safety ref)
const preloadAudio = new Audio(); // Singleton for hover preloading

// Load saved state from localStorage
state.load();

// Initialize (Hoisted functions will work, but vars must be ready)
ui.renderLibrary(episodes, currentIndex, state, (index, action) => {
    if (action === 'play') {
        if (Number(currentIndex) === Number(index)) {
            // Toggle Play/Pause
            if (ui.audio.paused) playAudio(); else pauseAudio();
        } else {
            // Load new
            loadEpisode(index);
        }
    } else if (action === 'skip-back') {
        skip(-10);
    } else if (action === 'skip-fwd') {
        skip(10);
    }
}, (url) => preloadEpisode(url)); // Pass preload callback


// Initialize Welcome Modal (Modular)
WelcomeModal.init();

loadEpisode(currentIndex); // Load first episode but don't auto-play
setupEventListeners();

/**
 * Filtered render of the library
 */
function renderLibrary(filter = '') {
    const filtered = episodes
        .map((ep, index) => ({ ...ep, originalIndex: index }))
        .filter(ep =>
            ep.title.toLowerCase().includes(filter.toLowerCase()) ||
            ep.category.toLowerCase().includes(filter.toLowerCase()) ||
            (ep.description && ep.description.toLowerCase().includes(filter.toLowerCase()))
        );

    // We pass the full episodes list to the UI but with filter applied
    ui.renderLibrary(filtered, currentIndex, state, (index, action) => {
        // If action is play, check if it matches current
        if (action === 'play') {
            if (currentIndex === index) {
                // Toggle Play/Pause
                if (ui.audio.paused) playAudio(); else pauseAudio();
            } else {
                // Load new
                loadEpisode(index);
            }
        } else if (action === 'skip-back') {
            skip(-10);
        } else if (action === 'skip-fwd') {
            skip(10);
        } else {
            // Default fallback
            loadEpisode(index);
        }
    }, (url) => preloadEpisode(url));
}

/**
 * Load an episode and its saved position
 */
function loadEpisode(index) {
    // Safety: Cancel any pending autoplay jump if user manually selects a track
    if (autoplayTimer) {
        clearTimeout(autoplayTimer);
        autoplayTimer = null;
    }

    // Reset silence flag so we don't think we are in a gap
    isPlayingSilence = false;

    currentIndex = index;
    state.setLastIndex(index);

    const episode = episodes[index];
    const savedPos = state.getPosition(episode.title);
    document.getElementById('current-track-title').innerText = episode.title;
    // document.getElementById('current-track-artist').innerText = episode.category; // Optional: show category instead of artist? 
    // Keep artist as "Midnight Review" or set to Category? User wanted obscurity. 

    const descEl = document.getElementById('current-track-description');
    if (descEl) {
        descEl.innerText = episode.description || '';
    }

    const listened = state.isListened(episode.title);

    ui.updateTrack(episode, listened);
    ui.audio.src = episode.url;

    // Reset Play State (Pause) when loading new
    ui.setPlaying(false);
    ui.updateListPlayStates(episode.title, false);

    // Resume position after metadata loads
    ui.audio.onloadedmetadata = () => {
        // Restore playback speed
        const currentSpeed = parseFloat(ui.speedSelect.value) || 1.0;
        ui.audio.playbackRate = currentSpeed;

        // Save duration for library progress tracking
        state.setDuration(episode.title, ui.audio.duration);

        // Determine Start Time Logic
        const startTime = determineStartTime(
            state,
            episode.title,
            ui.audio.duration,
            isFirstLoad
        );

        if (startTime > 0) {
            ui.audio.currentTime = startTime;
        } else {
            ui.audio.currentTime = 0;
            saveCurrentPosition(); // Save 0 if restarting
        }

        if (isFirstLoad) {
            isFirstLoad = false;
        }

        // Reset Preload State for new track
        isPreloading = false;

        updateMediaSession(episode);
    };

    if (!isFirstLoad) {
        playAudio();
    }
}

/**
 * Pure helper to determine where playback should start
 * Modularity: Decouples logic from UI/Player side effects
 */
function determineStartTime(state, title, duration, isFirstLoad) {
    const savedPos = state.getPosition(title);

    // Scenario 1: Page Refresh (isFirstLoad)
    // ALWAYS resume. Even if it's 99% done. User might want to hear credits.
    if (isFirstLoad) {
        return savedPos;
    }

    // Scenario 2: Explicit Click (Navigation)
    // If finished or very near end, restart. Otherwise resume.
    const isListened = state.isListened(title);
    const isNearEnd = duration > 0 && savedPos > (duration * 0.95);

    if (isListened || isNearEnd) {
        return 0; // Restart
    }

    return savedPos; // Resume
}



/**
 * Persistence: Save position periodically
 */
function saveCurrentPosition() {
    const episode = episodes[currentIndex];
    const currentTime = ui.audio.currentTime;
    const duration = ui.audio.duration;

    if (currentTime > 0) {
        state.setPosition(episode.title, currentTime);
    }

    // Mark as listened if > 95%
    if (duration && (currentTime / duration) > 0.95) {
        state.markAsListened(episode.title);
        ui.updateTrack(episode, true);
        // We don't change visual to solid yet because it's still active
    }
}

/**
 * Hover-Preload (Instant Manual Start)
 */
function preloadEpisode(url) {
    if (preloadAudio.src !== url) {
        preloadAudio.src = url;
        preloadAudio.preload = 'auto';
        preloadAudio.load();
        console.log(`Hover-Preloading: ${url}`);
    }
}

function playAudio() {
    // Enforce playback speed before playing
    const currentSpeed = parseFloat(ui.speedSelect.value) || 1.0;
    ui.audio.playbackRate = currentSpeed;

    playPromise = ui.audio.play();

    if (playPromise !== undefined) {
        playPromise.then(_ => {
            // Play started successfully
            ui.setPlaying(true);
        })
            .catch(error => {
                // Auto-play was prevented or interrupted
                if (error.name === 'AbortError') {
                    // Ignore aborts (likely panic pause)
                } else {
                    ui.showError("Playback error: " + error.message);
                }
                ui.setPlaying(false);
            });
    }

    const episode = episodes[currentIndex];
    ui.updateListPlayStates(episode.title, true, state);
}

function pauseAudio() {
    if (playPromise !== undefined) {
        playPromise.then(_ => {
            ui.audio.pause();
            ui.setPlaying(false);
        })
            .catch(error => {
                // Play was likely aborted safely
            });
    } else {
        ui.audio.pause();
        ui.setPlaying(false);
    }

    const episode = episodes[currentIndex];
    ui.updateListPlayStates(episode.title, false, state);
}

function skip(amount) {
    ui.audio.currentTime = Math.max(0, Math.min(ui.audio.duration || 0, ui.audio.currentTime + amount));
    saveCurrentPosition();
    saveCurrentPosition();
}

/**
 * Modular Navigation
 */
function playNext() {
    loadEpisode((currentIndex + 1) % episodes.length);
}

function playPrev() {
    loadEpisode((currentIndex - 1 + episodes.length) % episodes.length);
}

function preloadNextEpisode() {
    const nextIndex = (currentIndex + 1) % episodes.length;
    const nextEpisode = episodes[nextIndex];

    // Create audio element to force browser to cache stream
    const preloadAudio = new Audio();
    preloadAudio.src = nextEpisode.url;
    preloadAudio.preload = 'auto'; // Force load

    console.log(`Preloading next episode: ${nextEpisode.title}`);
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
    }
}

function setupEventListeners() {
    ui.playBtn.addEventListener('click', () => {
        if (ui.audio.paused) playAudio(); else pauseAudio();
    });

    ui.prevBtn.addEventListener('click', playPrev);
    ui.nextBtn.addEventListener('click', playNext);
    ui.skipBackBtn.addEventListener('click', () => skip(-10));
    ui.skipFwdBtn.addEventListener('click', () => skip(10));

    // Autoplay: Next track when current ends
    ui.audio.addEventListener('ended', playNext);

    // Speed Control Sync

    // Speed Control Sync
    ui.speedSelect.addEventListener('change', () => {
        const speed = parseFloat(ui.speedSelect.value);
        ui.audio.playbackRate = speed;
        if (ui.stickySpeedSelect) ui.stickySpeedSelect.value = speed;
    });

    // Save on close/refresh
    window.addEventListener('beforeunload', () => {
        saveCurrentPosition();
    });

    if (ui.stickySpeedSelect) {
        ui.stickySpeedSelect.addEventListener('change', () => {
            const speed = parseFloat(ui.stickySpeedSelect.value);
            ui.audio.playbackRate = speed;
            ui.speedSelect.value = speed;
        });
    }

    ui.searchInput.addEventListener('input', (e) => {
        renderLibrary(e.target.value);
    });

    ui.audio.addEventListener('timeupdate', () => {
        // Only update visual if NOT dragging
        if (!ui.isDragging) {
            ui.updateProgress(ui.audio.currentTime, ui.audio.duration);
        }

        // Smart Preloading: 10 seconds before end
        const timeLeft = ui.audio.duration - ui.audio.currentTime;
        if (timeLeft <= 10 && timeLeft > 0 && !isPreloading) {
            preloadNextEpisode();
        }

        // Throttle saving position to every 5 seconds to reduce UI lag
        if (Math.floor(ui.audio.currentTime) % 5 === 0) {
            saveCurrentPosition();
        }
    });

    // Drag-to-Scrub Logic (Main & Sticky)
    addScrubbingListeners(ui.progressContainer, (percent) => {
        ui.updateProgress(ui.audio.duration * (percent / 100), ui.audio.duration);
    }, (percent) => {
        if (ui.audio.duration) {
            ui.audio.currentTime = (percent / 100) * ui.audio.duration;
            saveCurrentPosition();
        }
    });

    ui.copyRssBtn.addEventListener('click', () => {
        navigator.clipboard.writeText(ui.rssUrlText.innerText).then(() => {
            const originalText = ui.copyRssBtn.innerText;
            ui.copyRssBtn.innerText = 'Copied!';
            setTimeout(() => ui.copyRssBtn.innerText = originalText, 2000);
        });
    });

    // Sticky Player Events
    if (ui.stickyPlayBtn) {
        ui.stickyPlayBtn.addEventListener('click', () => {
            if (ui.audio.paused) playAudio(); else pauseAudio();
        });
    }
    if (ui.stickySkipBack) {
        ui.stickySkipBack.addEventListener('click', () => skip(-10));
    }
    if (ui.stickySkipFwd) {
        ui.stickySkipFwd.addEventListener('click', () => skip(10));
    }

    if (ui.stickyProgressContainer) {
        addScrubbingListeners(ui.stickyProgressContainer, (percent) => {
            // Visual Update during drag (handled by ui.updateProgress via generic logic or explicit here)
            // Check: ui.updateProgress calls this.progressBar.style.width... it also updates sticky. 
            // We can manually force width here for smoothness
            ui.stickyProgressBar.style.width = `${percent}%`;
            ui.progressBar.style.width = `${percent}%`;
        }, (percent) => {
            if (ui.audio.duration) {
                ui.audio.currentTime = (percent / 100) * ui.audio.duration;
                saveCurrentPosition();
            }
        });
    }
}

/**
 * Helper to add Mouse/Touch scrubbing events to a progress container
 */
function addScrubbingListeners(container, onDrag, onCommit) {
    const handleMove = (e) => {
        if (!ui.isDragging) return;
        const rect = container.getBoundingClientRect();
        const clientX = e.touches ? e.touches[0].clientX : e.clientX;
        const offsetX = clientX - rect.left;
        let percent = (offsetX / rect.width) * 100;
        percent = Math.max(0, Math.min(100, percent));
        onDrag(percent);
    };

    const handleEnd = (e) => {
        if (!ui.isDragging) return;
        ui.isDragging = false;

        // Calculate final pos
        const rect = container.getBoundingClientRect();
        // Use changedTouches for end event if touch
        const clientX = e.changedTouches ? e.changedTouches[0].clientX : e.clientX;
        const offsetX = clientX - rect.left;
        let percent = (offsetX / rect.width) * 100;
        percent = Math.max(0, Math.min(100, percent));

        onCommit(percent);

        document.removeEventListener('mousemove', handleMove);
        document.removeEventListener('touchmove', handleMove);
        document.removeEventListener('mouseup', handleEnd);
        document.removeEventListener('touchend', handleEnd);
    };

    const handleStart = (e) => {
        ui.isDragging = true;
        // Optionally update immediately on click too
        handleMove(e);

        document.addEventListener('mousemove', handleMove);
        document.addEventListener('touchmove', handleMove, { passive: false });
        document.addEventListener('mouseup', handleEnd);
        document.addEventListener('touchend', handleEnd);
    };

    container.addEventListener('mousedown', handleStart);
    container.addEventListener('touchstart', handleStart, { passive: false });

    // Error Handling
    ui.audio.addEventListener('error', (e) => {
        const error = ui.audio.error;
        let message = 'An error occurred while playing audio.';
        if (error.code === 1) message = 'Playback aborted.';
        if (error.code === 2) message = 'Network error. Please check your connection.';
        if (error.code === 3) message = 'Audio decoding failed.';
        if (error.code === 4) message = 'Audio file not found or unsupported.'; // 404 falls here

        ui.showError(message);
        ui.setPlaying(false);
        const episode = episodes[currentIndex];
        ui.updateListPlayStates(episode.title, false, state);
    });
}

// Start the app
