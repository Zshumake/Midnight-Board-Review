/**
 * Tracking Module
 * Handles Anti-Skip Validation and Badge Awarding logic
 */

export const Tracking = {
    sessionValidTime: 0,
    lastTimeUpdate: 0,
    hasCreditedSession: false,

    /**
     * Reset tracking for a new episode
     */
    reset() {
        this.sessionValidTime = 0;
        this.lastTimeUpdate = 0;
        this.hasCreditedSession = false;
    },

    /**
     * Update tracking on timeupdate event
     * @param {number} currentTime 
     * @param {boolean} isPaused 
     * @param {boolean} isDragging 
     */
    update(currentTime, isPaused, isDragging) {
        if (this.lastTimeUpdate > 0 && !isPaused && !isDragging) {
            const delta = currentTime - this.lastTimeUpdate;
            // Relaxed delta (3s) to account for background throttles on mobile
            if (delta > 0 && delta < 3.0) {
                this.sessionValidTime += delta;
            }
        }
        this.lastTimeUpdate = currentTime;
    },

    /**
     * Check if ready to award badge
     */
    checkCompletion(duration, episode, state, Feedback) {
        if (duration > 0 && !this.hasCreditedSession) {
            // Threshold: 80% of duration
            if (this.sessionValidTime > (duration * 0.8)) {
                console.log(`Validation Passed! Time: ${this.sessionValidTime.toFixed(1)} / Req: ${(duration * 0.8).toFixed(1)}`);

                const leveledUp = state.incrementCompletion(episode.title);
                if (leveledUp) {
                    // UI update handled by event 'completionChange' in Metadata/LibraryRenderer
                    if (Feedback) Feedback.showToast(`Marked "${episode.title}" as Listened`);
                }
                this.hasCreditedSession = true; // Only one badge per listen session
            }
        }
    }
};
