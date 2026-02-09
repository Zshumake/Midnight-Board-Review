/**
 * Metadata.js
 * Manages Track Titles, Descriptions, and Sticky Player Info updates.
 */

import { state } from '../../state.js';

export const Metadata = {
    elements: {
        title: document.getElementById('current-track-title'),
        description: document.getElementById('current-track-description'),
        stickyTitle: document.getElementById('sticky-title'),
        stickyPlayer: document.getElementById('sticky-player')
    },

    init() {
        // Listen for completion changes to update the title badge in real-time
        state.on('completionChange', (data) => {
            // We only update if the currently playing title matches the event
            const currentTitleText = this.elements.title ? this.elements.title.innerText : '';
            // Text content might contain the badge text too, so be careful. 
            // Best to rely on player's current episode knowledge or just re-run update if we have reference.
            // Actually, Metadata doesn't know "current episode". 
            // Simplest way: Check if the title string includes the changed title.
            // A better way: Player orchestrates the "Current Episode" update, 
            // Metadata just updates the visual binding.

            // However, for pure decoupling, Metadata should store the "current title" string 
            // so it knows if it needs to re-render the badge.
        });
    },

    update(episode, isListened) {
        if (!episode) return;
        this.currentTitle = episode.title; // Store for event check

        let badgeCount = state.getCompletionCount(episode.title);
        if (badgeCount === 0 && isListened) badgeCount = 1;

        // 1. Update Main Title
        if (this.elements.title) {
            this.elements.title.innerHTML = '';
            this.elements.title.appendChild(document.createTextNode(episode.title + ' '));
            if (badgeCount > 0) {
                this._appendBadge(this.elements.title, badgeCount);
            }
        }


        // Sticky Player visibility handled in update wrapper
    },

    _appendBadge(container, count) {
        const badgeContainer = document.createElement('div');
        badgeContainer.className = 'status-container';
        badgeContainer.style.display = 'inline-flex';
        badgeContainer.style.marginLeft = '12px';
        badgeContainer.style.verticalAlign = 'middle';

        const badgeRow = document.createElement('div');
        badgeRow.className = 'badge-row';

        for (let i = 0; i < count; i++) {
            const badge = document.createElement('span');
            badge.className = 'status-badge';
            badge.innerText = '✓';
            badgeRow.appendChild(badge);
        }
        badgeContainer.appendChild(badgeRow);

        if (count >= 3) {
            const masterLabel = document.createElement('div');
            masterLabel.className = 'master-label';
            masterLabel.innerText = 'MASTER';
            badgeContainer.appendChild(masterLabel);
        }

        container.appendChild(badgeContainer);
    }
};
