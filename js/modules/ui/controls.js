/**
 * Controls.js
 * Manages all Play/Pause/Skip buttons across the app.
 * - Main Player
 * - Sticky Player
 * - Episode List (Ribbons)
 */

export const Controls = {
    elements: {
        mainPlay: document.getElementById('play'),
        mainPrev: document.getElementById('prev'),
        mainNext: document.getElementById('next'),
        mainSkipBack: document.getElementById('skip-back'),
        mainSkipFwd: document.getElementById('skip-fwd'),

        stickyPlay: document.getElementById('sticky-play'),
        stickySkipBack: document.getElementById('sticky-skip-back'),
        stickySkipFwd: document.getElementById('sticky-skip-fwd'),
    },

    init(audioEngine, callbacks) {
        this.audioEngine = audioEngine;
        this.callbacks = callbacks || {};
        this._bindEvents();
    },

    _bindEvents() {
        const { toggle, skip, prev, next } = this.callbacks;

        // Main Player
        if (this.elements.mainPlay) this.elements.mainPlay.addEventListener('click', toggle);
        if (this.elements.mainPrev) this.elements.mainPrev.addEventListener('click', prev);
        if (this.elements.mainNext) this.elements.mainNext.addEventListener('click', next);
        if (this.elements.mainSkipBack) this.elements.mainSkipBack.addEventListener('click', () => skip(-10));
        if (this.elements.mainSkipFwd) this.elements.mainSkipFwd.addEventListener('click', () => skip(10));

        // Sticky Player
        if (this.elements.stickyPlay) this.elements.stickyPlay.addEventListener('click', toggle);
        if (this.elements.stickySkipBack) this.elements.stickySkipBack.addEventListener('click', () => skip(-10));
        if (this.elements.stickySkipFwd) this.elements.stickySkipFwd.addEventListener('click', () => skip(10));
    },

    setPlaying(isPlaying) {
        // Main Player
        if (this.elements.mainPlay) {
            this.elements.mainPlay.innerHTML = isPlaying
                ? '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" width="48" height="48"><path d="M6 19h4V5H6v14zm8-14v14h4V5h-4z"/></svg>'
                : '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" width="48" height="48"><path d="M8 5v14l11-7z"/></svg>';
            this.elements.mainPlay.setAttribute('aria-label', isPlaying ? 'Pause' : 'Play');
        }

        // Sticky Player
        if (this.elements.stickyPlay) {
            this.elements.stickyPlay.innerHTML = isPlaying
                ? '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" width="28" height="28"><path d="M6 19h4V5H6v14zm8-14v14h4V5h-4z"/></svg>'
                : '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" width="28" height="28"><path d="M8 5v14l11-7z"/></svg>';
            this.elements.stickyPlay.setAttribute('aria-label', isPlaying ? 'Pause' : 'Play');
        }

        // List Rows (handled largely by UI/render logic still, but we can helper here potentially)
        // For now, list row icons are handled by ui.updateListPlayStates
    },

    setLoading(isLoading) {
        if (this.elements.mainPlay) {
            if (isLoading) this.elements.mainPlay.classList.add('loading');
            else this.elements.mainPlay.classList.remove('loading');
        }
    }
};
