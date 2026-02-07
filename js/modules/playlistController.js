/**
 * PlaylistController Module
 * Manages the sequence of episodes and the current index.
 */
export const PlaylistController = {
    episodes: [],
    currentIndex: 0,

    init(episodes, state, deepLinkIndex) {
        this.episodes = episodes;
        if (deepLinkIndex !== null) {
            this.currentIndex = deepLinkIndex;
        } else {
            this.currentIndex = state.data.lastIndex || 0;
        }
        return this.currentIndex;
    },

    getCurrentIndex() {
        return this.currentIndex;
    },

    setCurrentIndex(index) {
        this.currentIndex = Math.max(0, Math.min(this.episodes.length - 1, index));
        return this.currentIndex;
    },

    next() {
        this.currentIndex = (this.currentIndex + 1) % this.episodes.length;
        return this.currentIndex;
    },

    prev() {
        this.currentIndex = (this.currentIndex - 1 + this.episodes.length) % this.episodes.length;
        return this.currentIndex;
    },

    getEpisode(index = this.currentIndex) {
        return this.episodes[index];
    },

    getNextEpisode() {
        const nextIdx = (this.currentIndex + 1) % this.episodes.length;
        return this.episodes[nextIdx];
    }
};
