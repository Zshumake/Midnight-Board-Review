/**
 * AudioEngine.js - V2 Audio Architecture
 * 
 * A dedicated Singleton class for managing HTML5 Audio and MediaSession.
 * DESIGN GOALS:
 * 1. UI Agnostic: Knows nothing about DOM, classes, or buttons.
 * 2. Promise Guarded: Prevents race conditions between load() and play().
 * 3. iOS Compliant: Respects Apple's restrictive auto-play and background policies.
 */

class AudioEngine {
    constructor() {
        this.audio = new Audio();
        this.audio.preload = 'auto'; // Essential for iOS metadata fetching
        // iOS requires explicit volume setting mostly for UI sync, hardware volume is physical
        this.audio.volume = 1.0;

        // State Management
        this._src = '';
        this._title = '';
        this._isPlaying = false;
        this._playbackRate = 1.0;

        // Promise Queue to serialize async audio operations
        this._queue = Promise.resolve();

        // Event Listeners Storage
        this._listeners = new Map();

        this._initListeners();
        this._initMediaSession();
    }

    // --- Public API ---

    /**
     * Load a new track. This is a DESTRUCTIVE operation.
     * @param {string} src - Audio URL
     * @param {number} startTime - Start time in seconds
     * @param {object} metadata - { title, artist, artwork }
     */
    async load(src, startTime = 0, metadata = {}) {
        return this._enqueue(async () => {
            // 1. Reset
            this.audio.pause();
            this._isPlaying = false;
            this.audio.src = src;
            this.audio.currentTime = startTime;
            this.audio.playbackRate = this._playbackRate;

            // 2. Metadata
            this._src = src;
            this._title = metadata.title || 'Unknown Title';
            this._updateMediaSessionMetadata(metadata);

            // 3. Load (Forces browser to negotiate stream)
            // FIX: Wait for 'canplay' to ensure we have a valid buffer before resolving.
            // This prevents "Ghost Mode" where the engine thinks it's ready but the hardware isn't.
            await new Promise((resolve) => {
                const onCanPlay = () => {
                    this.audio.removeEventListener('canplay', onCanPlay);
                    resolve();
                };
                this.audio.addEventListener('canplay', onCanPlay);
                this.audio.load();
            });

            // 4. Update State
            this._updateMediaSessionState();
        });
    }

    /**
     * Resume playback. Must be called from User Gesture first time.
     */
    async play() {
        return this._enqueue(async () => {
            try {
                await this.audio.play();
                this._isPlaying = true;
                this._updateMediaSessionState();
            } catch (error) {
                console.error("AudioEngine: Play failed", error);
                this._emit('error', error);
                // Don't throw, just let UI know via state change if needed
            }
        });
    }

    /**
     * Pause playback.
     */
    async pause() {
        return this._enqueue(async () => {
            this.audio.pause();
            this._isPlaying = false;
            this._updateMediaSessionState();
        });
    }

    /**
     * Toggle Play/Pause
     */
    async toggle() {
        if (this.audio.paused) {
            return this.play();
        } else {
            return this.pause();
        }
    }

    /**
     * Seek to specific time
     */
    async seek(time) {
        return this._enqueue(async () => {
            const newTime = Math.max(0, Math.min(time, this.audio.duration || 0));
            this.audio.currentTime = newTime;
            this._updateMediaSessionState();
        });
    }

    /**
     * Seek relative to current time
     */
    async seekRelative(amount) {
        return this.seek(this.audio.currentTime + amount);
    }

    /**
     * Set playback rate
     */
    setSpeed(rate) {
        this._playbackRate = rate;
        this.audio.playbackRate = rate;
        this._updateMediaSessionState(); // Update metadata for Lock Screen
    }

    /**
     * Get current state
     */
    get state() {
        return {
            currentTime: this.audio.currentTime,
            duration: this.audio.duration,
            paused: this.audio.paused,
            playbackRate: this.audio.playbackRate,
            src: this.audio.src,
            title: this._title
        };
    }

    // --- Event Handling ---

    on(event, callback) {
        if (!this._listeners.has(event)) {
            this._listeners.set(event, new Set());
        }
        this._listeners.get(event).add(callback);
    }

    off(event, callback) {
        if (this._listeners.has(event)) {
            this._listeners.get(event).delete(callback);
        }
    }

    _emit(event, data) {
        if (this._listeners.has(event)) {
            for (const cb of this._listeners.get(event)) {
                cb(data);
            }
        }
    }

    // --- Internal Logic ---

    _enqueue(task) {
        // Chain promises to prevent race conditions (e.g. pause() interrupting play())
        this._queue = this._queue.then(task).catch(err => {
            console.error("AudioEngine: Queue Error", err);
        });
        return this._queue;
    }

    _initListeners() {
        // HTML5 Audio Events -> AudioEngine Events

        this.audio.addEventListener('timeupdate', () => {
            // Aggressive iOS State Enforcement (V1.2.24 Strategy Logic preserved within Engine)
            // If we are ticking, we are playing.
            if ('mediaSession' in navigator && !this.audio.paused) {
                if (navigator.mediaSession.playbackState !== 'playing') {
                    navigator.mediaSession.playbackState = 'playing';
                }
            }
            this._emit('timeupdate', {
                currentTime: this.audio.currentTime,
                duration: this.audio.duration
            });
        });

        this.audio.addEventListener('play', () => {
            this._isPlaying = true;
            this._updateMediaSessionState();
            this._emit('play');
        });

        this.audio.addEventListener('pause', () => {
            this._isPlaying = false;
            this._updateMediaSessionState();
            this._emit('pause');
        });

        this.audio.addEventListener('ended', () => {
            this._emit('ended');
        });

        this.audio.addEventListener('durationchange', () => {
            this._emit('durationchange', this.audio.duration);
        });

        this.audio.addEventListener('error', (e) => {
            console.error("AudioEngine: Native Error", e);
            this._emit('error', this.audio.error);
        });

        // iOS Visibility Sync
        document.addEventListener('visibilitychange', () => {
            if (document.hidden && !this.audio.paused) {
                this._updateMediaSessionState();
            }
        });
    }

    _initMediaSession() {
        if (!('mediaSession' in navigator)) return;

        const ms = navigator.mediaSession;

        ms.setActionHandler('play', () => {
            // "Gentle Resume" logic: Just call play
            this.play();
        });
        ms.setActionHandler('pause', () => {
            this.pause();
        });
        ms.setActionHandler('seekbackward', () => {
            this.seekRelative(-10);
        });
        ms.setActionHandler('seekforward', () => {
            this.seekRelative(10);
        });
        ms.setActionHandler('previoustrack', () => {
            this._emit('prev');
        });
        ms.setActionHandler('nexttrack', () => {
            this._emit('next');
        });
    }

    _updateMediaSessionMetadata(metadata) {
        if (!('mediaSession' in navigator)) return;

        navigator.mediaSession.metadata = new MediaMetadata({
            title: metadata.title || this._title,
            artist: metadata.artist || 'Midnight Review',
            album: metadata.album || 'Board Review Podcast',
            artwork: metadata.artwork || [{ src: 'cover.jpg?v=6', sizes: '512x512', type: 'image/jpeg' }]
        });
    }

    _updateMediaSessionState() {
        if (!('mediaSession' in navigator)) return;

        const ms = navigator.mediaSession;

        // 1. Playback State
        ms.playbackState = this.audio.paused ? 'paused' : 'playing';

        // 2. Position State (Essential for Lock Screen Timer)
        if ('setPositionState' in ms) {
            try {
                const duration = this.audio.duration;
                // Only set if we have valid numbers
                if (Number.isFinite(duration) && duration > 0) {
                    ms.setPositionState({
                        duration: duration,
                        playbackRate: this.audio.playbackRate,
                        position: this.audio.currentTime
                    });
                }
            } catch (e) {
                // Ignore errors if audio isn't ready
                console.warn("AudioEngine: setPositionState failed", e);
            }
        }
    }
}

// Export as Singleton
export const audioEngine = new AudioEngine();
