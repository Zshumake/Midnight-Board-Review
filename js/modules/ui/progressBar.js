/**
 * ProgressBar.js
 * Manages time sliders and progress visualization.
 * - Main Player Progress Bar
 * - Sticky Player Progress Bar
 * - Progress Labels
 */

export const ProgressBar = {
    elements: {
        mainContainer: document.getElementById('progress-container'),
        mainBar: document.getElementById('progress-bar'),
        mainTime: document.getElementById('current-time'),
        mainDuration: document.getElementById('duration'),

        stickyContainer: document.getElementById('sticky-progress-container'),
        stickyBar: document.getElementById('sticky-progress-bar'),
    },

    isDragging: false,

    init(audioEngine) {
        this.audioEngine = audioEngine;
        this._bindEvents();
    },

    _bindEvents() {
        // Main Player Range Input
        if (this.elements.mainBar) {
            this.elements.mainBar.addEventListener('input', (e) => {
                this.isDragging = true;
                this._updateLabels(parseFloat(e.target.value));
            });

            this.elements.mainBar.addEventListener('change', (e) => {
                this.isDragging = false;
                this.audioEngine.seek(parseFloat(e.target.value));
            });
        }
    },

    update(currentTime, duration) {
        // Update Labels
        this._updateLabels(currentTime, duration);

        // Update Main Bar (if not dragging)
        if (!this.isDragging && this.elements.mainBar) {
            this.elements.mainBar.max = duration || 0;
            this.elements.mainBar.value = currentTime || 0;

            // Background fill hack for range input
            const percent = duration > 0 ? (currentTime / duration) * 100 : 0;
            this.elements.mainBar.style.background = `linear-gradient(to right, var(--primary-color) ${percent}%, var(--bg-secondary) ${percent}%)`;
        }

        // Update Sticky Bar (Visual only)
        if (this.elements.stickyBar) {
            const percent = duration > 0 ? (currentTime / duration) * 100 : 0;
            this.elements.stickyBar.style.width = `${percent}%`;
        }
    },

    _updateLabels(current, duration = null) {
        if (this.elements.mainTime) {
            this.elements.mainTime.textContent = this._formatTime(current);
        }
        if (duration !== null && this.elements.mainDuration) {
            this.elements.mainDuration.textContent = this._formatTime(duration);
        }
    },

    _formatTime(seconds) {
        if (!seconds || isNaN(seconds)) return '0:00';
        const m = Math.floor(seconds / 60);
        const s = Math.floor(seconds % 60);
        return `${m}:${s.toString().padStart(2, '0')}`;
    }
};
