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

    const listened = state.isListened(episode.title);
    ui.updateTrack(episode, listened);

    // Reset Play State (Pause)
    ui.setPlaying(false);
    ui.updateListPlayStates(episode.title, false, state);

    // Define resume logic (Metadata Handler)
    const handleMetadata = () => {
        const savedSpeed = state.getSpeed();
        currentAudio.playbackRate = savedSpeed;

        if (ui.speedSelect) ui.speedSelect.value = savedSpeed;
        if (ui.stickySpeedSelect) ui.stickySpeedSelect.value = savedSpeed;

        state.setDuration(episode.title, currentAudio.duration);

        const startTime = determineStartTime(state, episode.title, currentAudio.duration, isFirstLoad);
        console.log(`Loaded ${episode.title}. StartTime: ${startTime}`);

        if (startTime > 0) {
            currentAudio.currentTime = startTime;
        } else {
            currentAudio.currentTime = 0;
        }

        ui.updateProgress(currentAudio.currentTime, currentAudio.duration);

        // Store active 'isFirstLoad' state for this execution context
        const wasFirstLoad = isFirstLoad;

        if (isFirstLoad) {
            isFirstLoad = false;
        }

        isPreloading = false;

        updateMediaSession(episode);

        // Auto-play ONLY if NOT initial load
        if (!wasFirstLoad) {
            playAudio();
        }
    };

    currentAudio.addEventListener('loadedmetadata', handleMetadata, { once: true });
    currentAudio.src = episode.url;
}

function determineStartTime(state, title, duration, isFirstLoad) {
    const savedPos = state.getPosition(title);

    // 1. Initial Load (Page Refresh): Always trust saved state
    if (isFirstLoad) return savedPos;

    // 2. Navigation Load (Clicking item):
    // Only restart if the *saved position* is at the very end.
    // We IGNORE 'isListened' here, because if the user is re-playing a completed episode
    // and is currently at 10:00, we want to resume at 10:00, not 0:00.
    const isAtEnd = duration > 0 && savedPos > (duration * 0.95);

    if (isAtEnd) {
        return 0; // Restart if we left off at the end
    }

    return savedPos; // Otherwise resume (even if previously 'completed')
}

function saveCurrentPosition() {
    const episode = episodes[currentIndex];
    const currentTime = currentAudio.currentTime;

    if (currentTime > 0) {
        state.setPosition(episode.title, currentTime);
    }
}

// ...

// In setupEventListeners:
// Save on unload & visibility change (Mobile Safari friendly)
window.addEventListener('beforeunload', saveCurrentPosition);
document.addEventListener('visibilitychange', () => {
    if (document.visibilityState === 'hidden') {
        saveCurrentPosition();
    }
});

// Search
ui.searchInput.addEventListener('input', (e) => renderLibrary(e.target.value));

// Time Update & Tracking
currentAudio.addEventListener('timeupdate', () => {
    const currentTime = currentAudio.currentTime;
    const duration = currentAudio.duration;

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
