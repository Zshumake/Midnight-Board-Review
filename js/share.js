/**
 * Share Module
 * Handles Deep Linking (URL params) and Copy-to-Clipboard logic
 */

export const Share = {
    /**
     * Parse URL parameters for deep linking
     * @param {Array} episodes - List of episodes
     * @param {Object} state - State management object
     * @returns {number|null} - Index of episode to load, or null if unrelated
     */
    initDeepLinking(episodes, state) {
        const urlParams = new URLSearchParams(window.location.search);
        const paramEp = urlParams.get('ep');
        const paramT = urlParams.get('t');

        if (paramEp !== null) {
            const index = parseInt(paramEp, 10);
            if (paramT !== null) {
                const epTitle = episodes[index]?.title;
                if (epTitle) {
                    state.setPosition(epTitle, parseFloat(paramT));
                }
            }
            // Clean URL without reloading (optional, keeps URL clean)
            // window.history.replaceState({}, document.title, window.location.pathname);
            return index;
        }
        return null; // No deep link
    },



    /**
     * Setup RSS Copy Listener
     */
    setupRssCopy(ui) {
        if (!ui.copyRssBtn) return;

        ui.copyRssBtn.addEventListener('click', () => {
            navigator.clipboard.writeText(ui.rssUrlText.innerText).then(() => {
                const originalText = ui.copyRssBtn.innerText;
                ui.copyRssBtn.innerText = 'Copied!';
                setTimeout(() => ui.copyRssBtn.innerText = originalText, 2000);
            });
        });
    }
};
