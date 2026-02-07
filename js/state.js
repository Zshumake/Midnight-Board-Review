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
        durations: {},
        history: [],
        completions: {}, // New: stores count (1-3) per episode
        playbackSpeed: 1.0 // Default speed
    },

    load() {
        const saved = localStorage.getItem(STORAGE_KEY);
        if (saved) {
            const parsed = JSON.parse(saved);
            this.data = { ...this.data, ...parsed };

            // Ensure objects exist
            if (!this.data.durations) this.data.durations = {};
            if (!this.data.positions) this.data.positions = {};
            if (!this.data.history) this.data.history = [];
            if (!this.data.completions) this.data.completions = {};

            // Migration: If in history but not in completions, set to 1
            this.data.history.forEach(title => {
                if (!this.data.completions[title]) {
                    this.data.completions[title] = 1;
                }
            });
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
        const pos = this.getPosition(title);
        const dur = this.getDuration(title);
        if (dur > 0) {
            return Math.min(100, (pos / dur) * 100);
        }
        if (this.isListened(title)) return 100;
        return 0;
    },

    markAsListened(title) {
        // Legacy: keep history array for backward compat if needed, 
        // but main logic moved to incrementCompletion
        if (!this.data.history.includes(title)) {
            this.data.history.push(title);
        }
        // Ensure at least 1 completion if marked listened via legacy path
        if (!this.data.completions[title]) {
            this.data.completions[title] = 1;
        }
        this.save();
    },

    incrementCompletion(title) {
        // Initialize if empty
        if (!this.data.completions[title]) {
            this.data.completions[title] = 0;
        }

        // Max 3 badges
        if (this.data.completions[title] < 3) {
            this.data.completions[title]++;

            // Also ensure legacy history is synced
            if (!this.data.history.includes(title)) {
                this.data.history.push(title);
            }
            this.save();
            return true; // Return true if leveled up
        }
        return false;
    },

    markCategoryAsListened(episodeList) {
        episodeList.forEach(ep => {
            if (!this.data.completions[ep.title]) {
                this.data.completions[ep.title] = 1;
                if (!this.data.history.includes(ep.title)) {
                    this.data.history.push(ep.title);
                }
            }
        });
        this.save();
    },

    getCompletionCount(title) {
        return this.data.completions[title] || 0;
    },

    isListened(title) {
        return (this.data.completions[title] && this.data.completions[title] > 0) || this.data.history.includes(title);
    },

    setSpeed(speed) {
        this.data.playbackSpeed = speed;
        this.save();
    },

    getSpeed() {
        return this.data.playbackSpeed || 1.0;
    }
};
