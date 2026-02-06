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
        durations: {}, // New: stores total time per episode
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

    setDuration(title, duration) {
        if (duration && duration > 0) {
            this.data.durations[title] = duration;
            this.save();
        }
    },

    getDuration(title) {
        return this.data.durations[title] || 0;
    },

    getProgressPercentage(title) {
        // If we have data, calculate exact percentage
        const pos = this.getPosition(title);
        const dur = this.getDuration(title);
        if (dur > 0) {
            return Math.min(100, (pos / dur) * 100);
        }
        // Fallback: if marked listened but no duration data (legacy), return 100
        if (this.isListened(title)) return 100;
        return 0;
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
