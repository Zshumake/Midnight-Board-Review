/**
 * RSS Modal Module
 * Handles the RSS Feed section interactivity (Copy URL, etc.)
 */
export const RssModal = {
    init() {
        const copyBtn = document.getElementById('copy-rss');
        const urlText = document.getElementById('rss-url');

        if (copyBtn && urlText) {
            copyBtn.addEventListener('click', () => {
                navigator.clipboard.writeText(urlText.innerText).then(() => {
                    const originalText = copyBtn.innerText;
                    copyBtn.innerText = 'Copied!';
                    setTimeout(() => copyBtn.innerText = originalText, 2000);
                });
            });
        }
    }
};
