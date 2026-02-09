/**
 * Feedback.js
 * Manages user notifications, error toasts, and loading states.
 */

export const Feedback = {
    elements: {
        errorToast: document.getElementById('error-toast'),
        loadingDisclaimer: document.getElementById('loading-disclaimer'),
        playBtn: document.getElementById('play')
    },

    showError(message) {
        if (this.elements.errorToast) {
            this.elements.errorToast.innerText = message;
            this.elements.errorToast.classList.add('visible');
            setTimeout(() => {
                this.elements.errorToast.classList.remove('visible');
            }, 3000);
        }
    },

    showToast(message) {
        // Re-using error toast style for generic messages for now, 
        // or we could add a specific .toast class.
        // For now, let's just use the same mechanism but maybe different styling if needed.
        // Given current usage, showToast usually implies a success/info message (like "Copied").
        if (this.elements.errorToast) {
            this.elements.errorToast.innerText = message;
            this.elements.errorToast.style.backgroundColor = 'var(--accent-gold)';
            this.elements.errorToast.style.color = '#000';
            this.elements.errorToast.classList.add('visible');
            setTimeout(() => {
                this.elements.errorToast.classList.remove('visible');
                // Reset style
                setTimeout(() => {
                    this.elements.errorToast.style.backgroundColor = '';
                    this.elements.errorToast.style.color = '';
                }, 300);
            }, 3000);
        }
    },

    setLoading(isLoading) {
        if (this.elements.loadingDisclaimer) {
            this.elements.loadingDisclaimer.style.display = isLoading ? 'block' : 'none';
        }
        if (this.elements.playBtn) {
            if (isLoading) this.elements.playBtn.classList.add('loading');
            else this.elements.playBtn.classList.remove('loading');
        }

        // Handle List Item Loading State
        const activeRow = document.querySelector('.episode-item.active');
        if (activeRow) {
            const rowDisclaimer = activeRow.querySelector('.list-loading-disclaimer');
            if (rowDisclaimer) rowDisclaimer.style.display = isLoading ? 'block' : 'none';
        }
    }
};
