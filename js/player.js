import { episodes } from './episodes.js';
import { state } from './state.js';

// Modules
import { Share } from './share.js';
import { Library } from './library.js';
import { Tracking } from './tracking.js';
import { audioEngine } from './modules/audioEngine.js';
import { InfoModal } from './modules/infoModal.js';
import { ReportModal } from './modules/reportModal.js';
import { RssModal } from './modules/rssModal.js';

// UI Modules
import { Controls } from './modules/ui/controls.js';
import { ProgressBar } from './modules/ui/progressBar.js';
import { Feedback } from './modules/ui/feedback.js';
import { Metadata } from './modules/ui/metadata.js';

import { LibraryRenderer } from './modules/ui/libraryRenderer.js';
import { SpeedControl } from './modules/ui/speedControl.js';
import { ThemeControl } from './modules/ui/themeControl.js';
import { Updater } from './modules/updater.js';

// --- State Variables ---
let currentIndex = 0;
let isPreloading = false;
let activeLoadId = 0;       // Safeguard for rapid switching
let lastKnownTime = 0;      // Cache for atomic saves
const preloadAudio = new Audio(); // Helper for hover preloading (independent of Engine)

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
console.log('Player.js: Calling InfoModal.init()...');
InfoModal.init();
document.getElementById('info-btn')?.addEventListener('click', () => {
    InfoModal.show();
});

// Init Report Modal
ReportModal.init(episodes);
Metadata.init(); // Initialize Event Listeners for Metadata
const reportBtn = document.getElementById('report-issue-btn');
if (reportBtn) {
    const showReport = (e) => {
        if (e.type === 'touchstart') e.preventDefault();
        const currentEpisode = episodes[currentIndex];
        ReportModal.show(currentEpisode ? currentEpisode.title : null);
    };
    reportBtn.addEventListener('click', showReport);
    reportBtn.addEventListener('touchstart', showReport, { passive: false });
}

// 2. Library & Category Logic
Library.initCategories(episodes, LibraryRenderer, () => {
    // Search input is handled by LibraryRenderer internally for events, 
    // but we need value for filtering.
    const term = LibraryRenderer.elements.searchInput ? LibraryRenderer.elements.searchInput.value : '';
    renderLibrary(term);
});

// 3. Setup Main Player Event Listeners (UI -> Engine)
// 3. Setup Main Player Event Listeners (UI -> Engine)
setupEventListeners();

audioEngine.on('error', (msg) => {
    Feedback.showError(msg || "Playback Error");
});

// 4. Initial Episode Load (Prep)
loadEpisode(currentIndex, false); // False = Don't Autoplay

// 5. Shared Click Handler for Library
const onEpisodeClick = (idx, action) => {
    const index = Number(idx);
    if (action === 'play') {
        if (Number(currentIndex) === index) {
            audioEngine.toggle();
        } else {
            loadEpisode(index, true); // True = Autoplay
        }
    }
};

// 6. Initial Full Library Render
LibraryRenderer.render(episodes, currentIndex, onEpisodeClick, (url) => preloadEpisode(url));


/**
 * Filtered render of the library using Library Module
 */
function renderLibrary(filter = '') {
    const filtered = Library.filterEpisodes(episodes, filter);

    LibraryRenderer.render(filtered, currentIndex, (idx, action) => {
        const index = Number(idx);
        if (action === 'play') {
            if (currentIndex === index) {
                audioEngine.toggle();
            } else {
                loadEpisode(index, true);
            }
        } else if (action === 'skip-back') {
            audioEngine.seekRelative(-10);
        } else if (action === 'skip-fwd') {
            audioEngine.seekRelative(10);
        } else {
            loadEpisode(index, true);
        }
    }, (url) => preloadEpisode(url), filter);
}

/**
 * Load an episode
 */
async function loadEpisode(index, shouldAutoplay = true) {
    activeLoadId++;
    const currentId = activeLoadId;

    // 1. Save Previous State
    if (lastKnownTime > 5) {
        state.setPosition(episodes[currentIndex].title, lastKnownTime);
    }
    lastKnownTime = 0;

    // 2. Update Index & UI Loading State
    currentIndex = index;
    state.setLastIndex(index);
    LibraryRenderer.updatePlayStates(currentIndex, false);
    Feedback.setLoading(true);
    Tracking.reset(); // RESET TRACKING FOR NEW EPISODE

    const episode = episodes[index];

    // 3. Determine Start Time (Resume or Restart)
    const savedPos = state.getPosition(episode.title);
    const duration = state.getDuration(episode.title) || 0;
    let startTime = savedPos;

    // Resume Logic: If near end (95%), restart.
    if (duration > 0 && savedPos > (duration * 0.95)) {
        startTime = 0;
    }

    // 4. UI Setup
    // 4. UI Setup
    const listened = state.isListened(episode.title);
    Metadata.update(episode, listened);
    ProgressBar.update(startTime, duration);
    Controls.setPlaying(false);

    // 5. Engine Load (Async)
    const metadata = {
        title: episode.title,
        artist: 'Midnight Review',
        artwork: [{ src: 'cover.jpg?v=6', sizes: '512x512', type: 'image/jpeg' }]
    };

    try {
        await audioEngine.load(episode.url, startTime, metadata);

        // Check if load ID changed during await
        if (currentId !== activeLoadId) return;

        Feedback.setLoading(false);
        isPreloading = false;

        isPreloading = false;

        if (shouldAutoplay) {
            audioEngine.play(); // Auto-play on user-initiated load
        }
    } catch (e) {
        console.error("Player Load Error:", e);
        Feedback.setLoading(false);
        Feedback.showError("Failed to load episode.");
    }
}

function saveCurrentPosition() {
    const episode = episodes[currentIndex];
    if (!episode) return;

    // Get state directly from engine
    const { currentTime } = audioEngine.state;

    if (currentTime > 5) {
        lastKnownTime = currentTime;
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

function playNext() {
    loadEpisode((Number(currentIndex) + 1) % episodes.length, true);
}

function playPrev() {
    loadEpisode((Number(currentIndex) - 1 + episodes.length) % episodes.length, true);
}

function preloadNextEpisode() {
    const nextIndex = (currentIndex + 1) % episodes.length;
    const nextEpisode = episodes[nextIndex];
    if (!nextEpisode) return;
    const preload = new Audio(); // Local scope
    preload.src = nextEpisode.url;
    preload.preload = 'auto';
    isPreloading = true;
}

// --- Event Listeners ---

function setupEventListeners() {
    // 1. Init Controls Module
    // Handles Play/Pause/Skip for Main and Sticky Players
    Controls.init(audioEngine, {
        toggle: () => audioEngine.toggle(),
        prev: playPrev,
        next: playNext,
        skip: (amount) => audioEngine.seekRelative(amount)
    });

    // 2. Init ProgressBar
    // Handles Scrubbing and Time Updates
    ProgressBar.init(audioEngine);

    // 3. Init LibraryRenderer (Search)
    LibraryRenderer.init({
        onSearch: (term) => renderLibrary(term)
    });

    // 4. Init SpeedControl
    SpeedControl.init(audioEngine);

    // 5. Init ThemeControl (Bockenek Mode)
    ThemeControl.init();

    // 6. Init Updater (PWA)
    Updater.init();

    // Engine -> UI Listeners
    audioEngine.on('play', () => {
        Controls.setPlaying(true);
        LibraryRenderer.updatePlayStates(currentIndex, true);
    });

    audioEngine.on('pause', () => {
        Controls.setPlaying(false);
        LibraryRenderer.updatePlayStates(currentIndex, false);
        saveCurrentPosition();
    });

    audioEngine.on('timeupdate', (data) => {
        const { currentTime, duration } = data;

        // 1. Update Tracking (Anti-Skip)
        Tracking.update(currentTime, audioEngine.state.paused, ProgressBar.isDragging);

        // 2. Check for Badge
        Tracking.checkCompletion(duration, episodes[currentIndex], state, Feedback);

        // 3. Visual Update
        ProgressBar.update(currentTime, duration);

        // 4. Preload Next
        const timeLeft = duration - currentTime;
        if (timeLeft <= 10 && timeLeft > 0 && !isPreloading) {
            preloadNextEpisode();
        }

        // 5. Save State (Throttled)
        if (Math.floor(currentTime) !== Math.floor(lastKnownTime)) {
            saveCurrentPosition();
        }
        lastKnownTime = currentTime;
    });

    audioEngine.on('ended', () => {
        playNext();
    });

    audioEngine.on('durationchange', (duration) => {
        state.setDuration(episodes[currentIndex].title, duration);
    });

    // MediaSession Remote Commands (Lock Screen -> Engine -> Here)
    audioEngine.on('next', playNext);
    audioEngine.on('prev', playPrev);

    // Save on unload
    window.addEventListener('beforeunload', saveCurrentPosition);
    window.addEventListener('pagehide', saveCurrentPosition);

    // Search (Handled by LibraryRenderer init, but let's keep specific binding if needed or remove validly)
    // LibraryRenderer init handles the input event now.

    // Context Menu Events
    document.addEventListener('manual-mastery', (e) => {
        const title = e.detail.title;
        if (title) {
            state.incrementCompletion(title);
            Feedback.showToast(`Marked "${title}" as Listened`);
        }
    });

    document.addEventListener('manual-reset', (e) => {
        const title = e.detail.title;
        if (title) {
            state.resetCompletion(title);
            Feedback.showToast(`Reset progress for "${title}"`);
        }
    });
}
