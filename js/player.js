import { episodes } from './episodes.js';
import { state } from './state.js';
import { ui } from './ui.js';

let currentIndex = 0;
let isFirstLoad = true;

/**
 * Initialize the player
 */
function init() {
    const savedState = state.load();
    currentIndex = savedState.lastIndex || 0;

    loadEpisode(currentIndex);
    renderLibrary();
    setupEventListeners();
}

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
        } else {
            // Default (e.g. from row click if we kept that logic, but we removed it)
            // Wait, we removed the row click play logic.
            // But if we ever need it:
            loadEpisode(index);
        }
    });
}

/**
 * Load an episode and its saved position
 */
function loadEpisode(index) {
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
        // Restore position if available
        const savedPos = state.getPosition(episode.title);
        if (savedPos > 0) {
            ui.audio.currentTime = savedPos;
        }

        if (isFirstLoad) {
            isFirstLoad = false;
        }

        updateMediaSession(episode);
    };

    if (!isFirstLoad) {
        playAudio();
    }
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
    }
}

function playAudio() {
    ui.audio.play();
    ui.setPlaying(true);
    const episode = episodes[currentIndex];
    ui.updateListPlayStates(episode.title, true);
}

function pauseAudio() {
    ui.audio.pause();
    ui.setPlaying(false);
    const episode = episodes[currentIndex];
    ui.updateListPlayStates(episode.title, false);
}

function skip(amount) {
    ui.audio.currentTime = Math.max(0, Math.min(ui.audio.duration || 0, ui.audio.currentTime + amount));
    saveCurrentPosition();
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
        navigator.mediaSession.setActionHandler('previoustrack', () => loadEpisode((currentIndex - 1 + episodes.length) % episodes.length));
        navigator.mediaSession.setActionHandler('nexttrack', () => loadEpisode((currentIndex + 1) % episodes.length));
    }
}

function setupEventListeners() {
    ui.playBtn.addEventListener('click', () => {
        if (ui.audio.paused) playAudio(); else pauseAudio();
    });

    ui.prevBtn.addEventListener('click', () => loadEpisode((currentIndex - 1 + episodes.length) % episodes.length));
    ui.nextBtn.addEventListener('click', () => loadEpisode((currentIndex + 1) % episodes.length));
    ui.skipBackBtn.addEventListener('click', () => skip(-10));
    ui.skipFwdBtn.addEventListener('click', () => skip(10));

    ui.speedSelect.addEventListener('change', () => {
        ui.audio.playbackRate = parseFloat(ui.speedSelect.value);
    });

    ui.searchInput.addEventListener('input', (e) => {
        renderLibrary(e.target.value);
    });

    ui.audio.addEventListener('timeupdate', () => {
        ui.updateProgress(ui.audio.currentTime, ui.audio.duration);
        // Throttle saving position to every 5 seconds to reduce UI lag
        if (Math.floor(ui.audio.currentTime) % 5 === 0) {
            saveCurrentPosition();
        }
    });

    ui.progressContainer.addEventListener('click', (e) => {
        const width = ui.progressContainer.clientWidth;
        const clickX = e.offsetX;
        const duration = ui.audio.duration;
        if (duration) {
            ui.audio.currentTime = (clickX / width) * duration;
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
}

// Start the app
init();
