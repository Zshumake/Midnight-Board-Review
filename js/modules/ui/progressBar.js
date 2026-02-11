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

        // Sticky Player Touch/Click
        if (this.elements.stickyContainer) {
            const handleSeek = (e) => {
                const rect = this.elements.stickyContainer.getBoundingClientRect();
                // Handle both mouse and touch events
                const clientX = e.touches ? e.touches[0].clientX : e.clientX;
                let offsetX = clientX - rect.left;

                // Clamp
                if (offsetX < 0) offsetX = 0;
                if (offsetX > rect.width) offsetX = rect.width;

                const percent = offsetX / rect.width;
                const duration = this.audioEngine.getDuration();

                if (duration > 0) {
                    const seekTime = duration * percent;
                    // If it's a "move" (drag), just update UI visually to feel responsive
                    // If it's a "end" or "click", actually seek
                    if (e.type === 'click' || e.type === 'touchend') {
                        this.audioEngine.seek(seekTime);
                        this.isDragging = false;
                    } else if (e.type === 'touchmove') {
                        this.isDragging = true;
                        // Optional: Update visual bar immediately for smoothness
                        if (this.elements.stickyBar) this.elements.stickyBar.style.width = `${percent * 100}%`;
                    }
                }
            };

            this.elements.stickyContainer.addEventListener('click', handleSeek);

            // Touch Drag Support
            this.elements.stickyContainer.addEventListener('touchstart', () => { this.isDragging = true; });
            this.elements.stickyContainer.addEventListener('touchmove', (e) => {
                e.preventDefault(); // Prevent scroll while scrubbing
                handleSeek(e);
            });
            this.elements.stickyContainer.addEventListener('touchend', (e) => {
                // For touchend, changedTouches gives the final position
                if (e.changedTouches && e.changedTouches.length > 0) {
                    const rect = this.elements.stickyContainer.getBoundingClientRect();
                    const clientX = e.changedTouches[0].clientX;
                    const percent = Math.max(0, Math.min(1, (clientX - rect.left) / rect.width));
                    const duration = this.audioEngine.getDuration();
                    if (duration > 0) this.audioEngine.seek(duration * percent);
                }
                this.isDragging = false;
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
            this.elements.mainBar.style.background = `linear-gradient(to right, var(--accent-gold) ${percent}%, rgba(255, 255, 255, 0.1) ${percent}%)`;
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
