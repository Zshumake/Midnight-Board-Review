/**
 * SpeedControl.js
 * Manages Playback Speed (1x, 1.25x, 1.5x, 2x)
 * - Syncs Main and Sticky player dropdowns.
 * - Persists preference via State.
 * - Updates AudioEngine.
 */

import { state } from '../../state.js';

export const SpeedControl = {
    elements: {
        mainSelect: document.getElementById('speed-select'),
        stickySelect: document.getElementById('sticky-speed-select')
    },

    init(audioEngine) {
        this.audioEngine = audioEngine;
        this._bindEvents();

        // Restore saved speed on load
        const savedSpeed = state.getSpeed();
        if (savedSpeed) {
            this.setSpeed(savedSpeed);
        }
    },

    _bindEvents() {
        const handleInput = (e) => {
            const speed = parseFloat(e.target.value);
            this.setSpeed(speed);
        };

        if (this.elements.mainSelect) {
            this.elements.mainSelect.addEventListener('change', handleInput);
        }

        if (this.elements.stickySelect) {
            this.elements.stickySelect.addEventListener('change', handleInput);
        }

        // Listen for engine updates (e.g. if set externally or resetting)
        this.audioEngine.on('speed', (rate) => {
            this._updateUI(rate);
            state.setSpeed(rate); // Persist
        });
    },

    setSpeed(speed) {
        this.audioEngine.setSpeed(speed);
        // UI update will happen via event listener to keep it single-source-of-truth
    },

    _updateUI(speed) {
        if (this.elements.mainSelect) this.elements.mainSelect.value = speed;
        if (this.elements.stickySelect) this.elements.stickySelect.value = speed;
    }
};
