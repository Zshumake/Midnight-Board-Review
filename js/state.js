/**
 * State Module (Event-Driven)
 * Manages application state and emits events when data changes.
 */

const STORAGE_KEY = 'cuccurullo_podcast_state';

class StateManager {
    constructor() {
        this.data = {
            lastIndex: 0,
            positions: {},
            durations: {},
            history: [],
            completions: {},
            playbackSpeed: 1.0
        };
        this.listeners = {};
    }

    // --- Event Emitter ---

    on(event, callback) {
        if (!this.listeners[event]) {
            this.listeners[event] = [];
        }
        this.listeners[event].push(callback);
    }

    off(event, callback) {
        if (!this.listeners[event]) return;
        this.listeners[event] = this.listeners[event].filter(cb => cb !== callback);
    }

    emit(event, payload) {
        if (!this.listeners[event]) return;
        this.listeners[event].forEach(cb => cb(payload));
    }

    // --- Persistence ---

    load() {
        const saved = localStorage.getItem(STORAGE_KEY);
        if (saved) {
            try {
                const parsed = JSON.parse(saved);
                this.data = { ...this.data, ...parsed };

                // Ensure strict types for critical paths
                if (!this.data.durations) this.data.durations = {};
                if (!this.data.positions) this.data.positions = {};
                if (!this.data.history) this.data.history = [];
                if (!this.data.completions) this.data.completions = {};

                // Migration: Sync history to completions
                this.data.history.forEach(title => {
                    if (!this.data.completions[title]) {
                        this.data.completions[title] = 1;
                    }
                });
            } catch (e) {
                console.error("State Load Error:", e);
            }
        }
        return this.data;
    }

    save() {
        localStorage.setItem(STORAGE_KEY, JSON.stringify(this.data));
    }

    // --- Getters & Setters ---

    setLastIndex(index) {
        if (this.data.lastIndex !== index) {
            this.data.lastIndex = index;
            this.save();
            this.emit('indexChanged', index);
        }
    }

    setPosition(title, position) {
        const key = title.trim();
        // Optimization: Don't emit for every second of position change unless needed
        // but definitley save.
        this.data.positions[key] = position;
        this.save();
    }

    getPosition(title) {
        return this.data.positions[title.trim()] || 0;
    }

    setDuration(title, duration) {
        const key = title.trim();
        if (duration && duration > 0) {
            this.data.durations[key] = duration;
            this.save();
        }
    }

    getDuration(title) {
        return this.data.durations[title.trim()] || 0;
    }

    getProgressPercentage(title) {
        const pos = this.getPosition(title);
        const dur = this.getDuration(title);
        if (dur > 0) {
            return Math.min(100, (pos / dur) * 100);
        }
        if (this.isListened(title)) return 100;
        return 0;
    },

    /**
     * Increment badge count (Logic: Max 3)
     * Returns true if a new badge was awarded (level up)
     */
    incrementCompletion(title) {
        const key = title.trim();
        if (!this.data.completions[key]) this.data.completions[key] = 0;

        if (this.data.completions[key] < 3) {
            this.data.completions[key]++;

            // Sync Legacy History
            if (!this.data.history.includes(key)) {
                this.data.history.push(key);
            }

            this.save();
            this.emit('completionChange', { title: key, count: this.data.completions[key] });
            return true;
        }
        return false;
    },

    resetCompletion(title) {
        const key = title.trim();
        if (this.data.completions[key]) {
            delete this.data.completions[key];
            this.data.history = this.data.history.filter(t => t !== key);
            this.save();
            this.emit('completionChange', { title: key, count: 0 });
        }
    },

    // Legacy helper (called from Tracking sometimes directly, though we prefer incrementCompletion)
    recordListen(title) {
        return this.incrementCompletion(title);
    },

    getCompletionCount(title) {
        const key = title.trim();
        const count = this.data.completions[key] || 0;
        if (count === 0 && this.isListened(key)) return 1;
        return count;
    },

    isListened(title) {
        const key = title.trim();
        return (this.data.completions[key] && this.data.completions[key] > 0) || this.data.history.includes(key);
    },

    setSpeed(speed) {
        if (this.data.playbackSpeed !== speed) {
            this.data.playbackSpeed = speed;
            this.save();
            this.emit('speedChange', speed);
        }
    },

    getSpeed() {
        return this.data.playbackSpeed || 1.0;
    }
}

// Export Singleton
export const state = new StateManager();
