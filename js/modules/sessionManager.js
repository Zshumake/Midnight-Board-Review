/**
 * SessionManager Module
 * Handles the logic for saving playback position and determining resume points.
 */
export const SessionManager = {
    /**
     * Calculate where an episode should start playing from.
     * @param {Object} state - The global state object
     * @param {string} title - Episode title
     * @param {number} duration - Total duration of the episode
     * @param {boolean} isFirstLoad - Whether this is the initial page load
     * @returns {number} The time in seconds to start playback
     */
    calculateStartTime(state, title, duration, isFirstLoad) {
        const savedPos = state.getPosition(title);

        // 1. Initial Load (Page Refresh): Always trust saved state
        if (isFirstLoad) return savedPos;

        // 2. Navigation Load (Clicking item):
        // Only restart if the *saved position* is at the very end (>95%).
        // We IGNORE 'isListened' here, because if the user is re-playing a completed episode
        // and is currently at 10:00, we want to resume at 10:00, not 0:00.
        const isAtEnd = duration > 0 && savedPos > (duration * 0.95);

        if (isAtEnd) {
            return 0; // Restart if we left off at the end
        }

        return savedPos; // Otherwise resume (even if previously 'completed')
    },

    /**
     * Save the current playback position if valid.
     * @param {Object} state - The global state object
     * @param {string} title - Episode title
     * @param {number} currentTime - Current playback time
     */
    savePosition(state, title, currentTime) {
        // Only save if we have actually started playing
        if (currentTime > 0) {
            state.setPosition(title, currentTime);
        }
    },

    /**
     * Set up listeners to auto-save state when the user leaves or backgrounds the app.
     * Crucial for mobile (iOS) where 'beforeunload' is unreliable.
     * @param {Function} saveCallback - The function to call to save state (usually calls savePosition)
     */
    setupAutoSave(saveCallback) {
        // Standard unload (Desktop)
        window.addEventListener('beforeunload', saveCallback);

        // Mobile / Tab Switch visibility change (iOS friendly)
        document.addEventListener('visibilitychange', () => {
            if (document.visibilityState === 'hidden') {
                saveCallback();
            }
        });
    }
};
