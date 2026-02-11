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
            // Check if currently displayed title matches the event
            if (this.currentTitle === data.title) {
                this.update({ title: data.title }, true);
            }
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


        // 2. Update Sticky Title
        if (this.elements.stickyTitle) {
            this.elements.stickyTitle.innerText = episode.title;
        }

        // 3. Show Sticky Player
        if (this.elements.stickyPlayer) {
            this.elements.stickyPlayer.classList.add('visible');
        }
    },

    _appendBadge(container, count) {
        const badgeContainer = document.createElement('div');
        badgeContainer.className = 'status-container';

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
