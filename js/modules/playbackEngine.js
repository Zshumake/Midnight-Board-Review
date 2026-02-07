/**
 * PlaybackEngine Module
 * Wrapper for the native Audio element to provide a clean, promise-safe API.
 */
export const PlaybackEngine = {
    audio: null,
    playPromise: null,

    init(audioElement) {
        this.audio = audioElement;
    },

    load(url) {
        this.audio.src = url;
    },

    play() {
        this.playPromise = this.audio.play();
        return this.playPromise;
    },

    pause() {
        if (this.playPromise) {
            this.playPromise.then(() => {
                this.audio.pause();
            }).catch(() => { });
        } else {
            this.audio.pause();
        }
    },

    seek(time) {
        if (this.audio.duration) {
            this.audio.currentTime = Math.max(0, Math.min(this.audio.duration, time));
        }
    },

    skip(amount) {
        this.seek(this.audio.currentTime + amount);
    },

    setSpeed(rate) {
        this.audio.playbackRate = rate;
    },

    getDuration() {
        return this.audio.duration || 0;
    },

    getCurrentTime() {
        return this.audio.currentTime || 0;
    },

    isPaused() {
        return this.audio.paused;
    }
};
