/**
 * MediaKeyManager Module
 * Handles integration with the Media Session API (Lock Screen / Control Center / Hardware Keys)
 */
export const MediaKeyManager = {
    /**
     * Update the Media Session metadata and action handlers.
     * @param {Object} episode - The current episode object
     * @param {Object} handlers - Object containing action handlers: { play, pause, seekBackward, seekForward, previoustrack, nexttrack }
     */
    update(episode, handlers) {
        if ('mediaSession' in navigator) {
            // Set Metadata
            navigator.mediaSession.metadata = new MediaMetadata({
                title: episode.title,
                artist: 'Midnight Review',
                album: 'Board Review Podcast',
                artwork: [{ src: 'cover.jpg?v=6', sizes: '512x512', type: 'image/jpeg' }]
            });

            // Set Action Handlers
            if (handlers.play) navigator.mediaSession.setActionHandler('play', handlers.play);
            if (handlers.pause) navigator.mediaSession.setActionHandler('pause', handlers.pause);
            if (handlers.seekBackward) navigator.mediaSession.setActionHandler('seekbackward', handlers.seekBackward);
            if (handlers.seekForward) navigator.mediaSession.setActionHandler('seekforward', handlers.seekForward);
            if (handlers.previousTrack) navigator.mediaSession.setActionHandler('previoustrack', handlers.previousTrack);
            if (handlers.nextTrack) navigator.mediaSession.setActionHandler('nexttrack', handlers.nextTrack);
        }
    }
};
