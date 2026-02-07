/**
 * ScrubHandler Module
 * Centralizes the complex mouse and touch dragging logic for progress bars.
 */
export const ScrubHandler = {
    /**
     * Set up scrubbing on a container element.
     * @param {HTMLElement} container - The progress bar container
     * @param {Object} ui - The UI object (to track dragging state)
     * @param {Object} audio - The HTMLAudioElement (or a wrapper with duration)
     * @param {Object} callbacks - { onDrag, onCommit }
     */
    init(container, ui, audio, callbacks) {
        const handleMove = (e) => {
            if (!ui.isDragging) return;
            const rect = container.getBoundingClientRect();
            const clientX = e.touches ? e.touches[0].clientX : e.clientX;
            let percent = ((clientX - rect.left) / rect.width) * 100;
            percent = Math.max(0, Math.min(100, percent));

            if (callbacks.onDrag) callbacks.onDrag(percent);
        };

        const handleEnd = (e) => {
            if (!ui.isDragging) return;
            ui.isDragging = false;

            const rect = container.getBoundingClientRect();
            const clientX = e.changedTouches ? e.changedTouches[0].clientX : e.clientX;
            let percent = ((clientX - rect.left) / rect.width) * 100;
            percent = Math.max(0, Math.min(100, percent));

            if (callbacks.onCommit) callbacks.onCommit(percent);

            document.removeEventListener('mousemove', handleMove);
            document.removeEventListener('touchmove', handleMove);
            document.removeEventListener('mouseup', handleEnd);
            document.removeEventListener('touchend', handleEnd);
        };

        const handleStart = (e) => {
            // Prevent scrolling on mobile during drag
            if (e.touches) e.preventDefault();

            ui.isDragging = true;
            handleMove(e);

            document.addEventListener('mousemove', handleMove);
            document.addEventListener('touchmove', handleMove, { passive: false });
            document.addEventListener('mouseup', handleEnd);
            document.addEventListener('touchend', handleEnd);
        };

        container.addEventListener('mousedown', handleStart);
        container.addEventListener('touchstart', handleStart, { passive: false });
    }
};
