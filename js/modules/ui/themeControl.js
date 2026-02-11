/**
 * ThemeControl.js
 * Manages App Themes and Easter Eggs (Bockenek Mode)
 */

import { FloatingHeads } from './floatingHeads.js';

export const ThemeControl = {
    elements: {
        toggleBtn: document.getElementById('bockenek-toggle'),
        body: document.body
    },

    init() {
        if (!this.elements.toggleBtn) return;

        // Restore State
        if (localStorage.getItem('bockenek_mode') === 'true') {
            this._enable(false); // false = no toggle animation, just set
        }

        this._bindEvents();
    },

    _bindEvents() {
        this.elements.toggleBtn.addEventListener('click', () => {
            this._toggle();
        });
    },

    _toggle() {
        const isActive = this.elements.body.classList.contains('bockenek-mode');
        if (isActive) {
            this._disable();
        } else {
            this._enable(true);
        }
    },

    _enable(animate = true) {
        this.elements.body.classList.add('bockenek-mode');
        this.elements.toggleBtn.classList.add('active');
        localStorage.setItem('bockenek_mode', 'true');

        FloatingHeads.init();
    },

    _disable() {
        this.elements.body.classList.remove('bockenek-mode');
        this.elements.toggleBtn.classList.remove('active');
        localStorage.setItem('bockenek_mode', 'false');

        FloatingHeads.destroy();
    }
};
