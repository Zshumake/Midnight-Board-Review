/**
 * Sticky Player Module
 * Handles the sticky player UI found at the bottom of the screen.
 */
export const StickyPlayer = {
    ui: {
        container: document.getElementById('sticky-player'),
        title: document.getElementById('sticky-title'),
        progressBar: document.getElementById('sticky-progress-bar'),
        playBtn: document.getElementById('sticky-play'),
        skipBackBtn: document.getElementById('sticky-skip-back'),
        skipFwdBtn: document.getElementById('sticky-skip-fwd'),
        speedSelect: document.getElementById('sticky-speed-select')
    },

    init() {
        // Controls are now handled by Controls.js and ProgressBar.js
        // This module just ensures the container is visible/setup if needed
    },

    updateTrack(title) {
        if (this.ui.title) {
            this.ui.title.textContent = title || 'Select an episode';
        }
    },

    setPlaying(isPlaying) {
        // Handled by Controls.js
    },

    update(currentTime, duration) {
        // Handled by ProgressBar.js
    },

    syncSpeed(speed) {
        if (this.ui.speedSelect) {
            this.ui.speedSelect.value = speed;
        }
    }
};
