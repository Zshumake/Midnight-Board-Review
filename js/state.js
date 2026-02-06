const STORAGE_KEY = 'cuccurullo_podcast_state';

/**
 * @typedef {Object} PodcastState
 * @property {number} lastIndex - The index of the last played episode.
 * @property {Object.<string, number>} positions - Timestamps for each episode by title.
 * @property {string[]} history - Titles of episodes completed (>95%).
 */

export const state = {
    data: {
        lastIndex: 0,
        positions: {},
        history: []
    },

    load() {
        const saved = localStorage.getItem(STORAGE_KEY);
        if (saved) {
            this.data = JSON.parse(saved);
        }
        return this.data;
    },

    save() {
        localStorage.setItem(STORAGE_KEY, JSON.stringify(this.data));
    },

    setLastIndex(index) {
        this.data.lastIndex = index;
        this.save();
    },

    setPosition(title, position) {
        this.data.positions[title] = position;
        this.save();
    },

    getPosition(title) {
        return this.data.positions[title] || 0;
    },

    markAsListened(title) {
        if (!this.data.history.includes(title)) {
            this.data.history.push(title);
            this.save();
        }
    },

    isListened(title) {
        return this.data.history.includes(title);
    }
};
