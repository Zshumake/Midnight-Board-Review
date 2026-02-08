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

    init(playerControls) {
        if (!this.ui.container) return;

        // 1. Play / Pause
        this.ui.playBtn.addEventListener('click', playerControls.togglePlay);

        // 2. Skips
        this.ui.skipBackBtn.addEventListener('click', () => playerControls.skip(-10));
        this.ui.skipFwdBtn.addEventListener('click', () => playerControls.skip(10));

        // 3. Speed
        this.ui.speedSelect.addEventListener('change', (e) => {
            playerControls.setSpeed(parseFloat(e.target.value));
        });

        // 4. Progress Bar Sync (Passive)
        // The main player loop updates the width style directly
    },

    updateUI(isPlaying, currentTitle) {
        // Update Title
        if (currentTitle) {
            this.ui.title.textContent = currentTitle;
        }

        // Update Play Button Icon
        this.ui.playBtn.innerHTML = isPlaying
            ? '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" width="28" height="28"><path d="M6 19h4V5H6v14zm8-14v14h4V5h-4z"/></svg>'
            : '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" width="28" height="28"><path d="M8 5v14l11-7z"/></svg>';
    },

    updateProgress(percent) {
        if (this.ui.progressBar) {
            this.ui.progressBar.style.width = `${percent}%`;
        }
    },

    syncSpeed(speed) {
        if (this.ui.speedSelect) {
            this.ui.speedSelect.value = speed;
        }
    }
};
