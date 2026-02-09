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
import { audioEngine } from './modules/audioEngine.js'; // NEW: Import Engine

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
Library.initCategories(episodes, ui, () => {
    renderLibrary(ui.searchInput.value);
});

// 3. Setup Main Player Event Listeners (UI -> Engine)
setupEventListeners();

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
ui.renderLibrary(episodes, currentIndex, state, onEpisodeClick, (url) => preloadEpisode(url));


/**
 * Filtered render of the library using Library Module
 */
function renderLibrary(filter = '') {
    const filtered = Library.filterEpisodes(episodes, filter);

    ui.renderLibrary(filtered, currentIndex, state, (idx, action) => {
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
    ui.updateListPlayStates(currentIndex, false, state);
    ui.setLoading(true);

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
    const listened = state.isListened(episode.title);
    const nextEpisode = episodes[(index + 1) % episodes.length];
    ui.updateTrack(episode, listened, nextEpisode);
    ui.updateProgress(startTime, duration);
    ui.setPlaying(false);

    // REGRESSION FIX: Update Sticky Player Info
    StickyPlayer.updateTrack(episode.title);
    Controls.setPlaying(false); // Use Controls instead of StickyPlayer

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

        ui.setLoading(false);
        isPreloading = false;

        // Restore Speed
        const savedSpeed = state.getSpeed();
        audioEngine.setSpeed(savedSpeed);
        if (ui.speedSelect) ui.speedSelect.value = savedSpeed;
        StickyPlayer.syncSpeed(savedSpeed);

        if (shouldAutoplay) {
            audioEngine.play(); // Auto-play on user-initiated load
        }
    } catch (e) {
        console.error("Player Load Error:", e);
        ui.setLoading(false);
        ui.showError("Failed to load episode.");
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
    // UI -> Engine Handlers
    ui.playBtn.addEventListener('click', () => audioEngine.toggle());
    ui.prevBtn.addEventListener('click', playPrev);
    ui.nextBtn.addEventListener('click', playNext);
    ui.skipBackBtn.addEventListener('click', () => audioEngine.seekRelative(-10));
    ui.skipFwdBtn.addEventListener('click', () => audioEngine.seekRelative(10));

    ui.stickyPlayBtn.addEventListener('click', () => audioEngine.toggle());

    ui.stickySkipBack.addEventListener('click', () => audioEngine.seekRelative(-10));
    ui.stickySkipFwd.addEventListener('click', () => audioEngine.seekRelative(10));

    // Speed Control
    const handleSpeed = (speed) => {
        audioEngine.setSpeed(speed);
        if (ui.speedSelect) ui.speedSelect.value = speed;
        if (ui.stickySpeedSelect) ui.stickySpeedSelect.value = speed;
        state.setSpeed(speed);
    };
    ui.speedSelect.addEventListener('change', () => handleSpeed(parseFloat(ui.speedSelect.value)));
    if (ui.stickySpeedSelect) {
        ui.stickySpeedSelect.addEventListener('change', () => handleSpeed(parseFloat(ui.stickySpeedSelect.value)));
    }

    // Scrubbing
    // ui.isDragging is handled by UI, but we need to update engine on release
    // (This part depends on how ui.js handles the progress bar events. 
    // Assuming standard input listener on range)
    const progressBar = document.getElementById('progress-bar');
    if (progressBar) {
        progressBar.addEventListener('change', (e) => {
            const time = parseFloat(e.target.value);
            audioEngine.seek(time);
        });
    }

    // Engine -> UI Listeners
    audioEngine.on('play', () => {
        ui.setPlaying(true);
        ui.updateListPlayStates(currentIndex, true, state);
    });

    audioEngine.on('pause', () => {
        ui.setPlaying(false);
        ui.updateListPlayStates(currentIndex, false, state);
        saveCurrentPosition();
    });

    audioEngine.on('timeupdate', (data) => {
        const { currentTime, duration } = data;

        // 1. Update Tracking (Anti-Skip)
        // Note: We need to pass 'paused' state. 
        // Engine state is truth.
        Tracking.update(currentTime, audioEngine.state.paused, ui.isDragging);

        // 2. Check for Badge
        Tracking.checkCompletion(duration, episodes[currentIndex], state, ui);

        // 3. Visual Update
        if (!ui.isDragging) {
            ui.updateProgress(currentTime, duration);
        }

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

    // Search
    ui.searchInput.addEventListener('input', (e) => renderLibrary(e.target.value));

    // RssModal
    RssModal.init();

    // Context Menu Events
    document.addEventListener('manual-mastery', (e) => {
        const title = e.detail.title;
        if (title) {
            state.incrementCompletion(title);
            Library.updateBadges(episodes, state, ui);
            ui.showToast(`Marked "${title}" as Listened`);
        }
    });

    document.addEventListener('manual-reset', (e) => {
        const title = e.detail.title;
        if (title) {
            state.resetCompletion(title);
            Library.updateBadges(episodes, state, ui);
            ui.showToast(`Reset progress for "${title}"`);
        }
    });
}
