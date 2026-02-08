/**
 * Updater Module
 * Handles Service Worker lifecycle, update notifications, and app maintenance.
 */
export const Updater = {
    version: '1.2.9',
    swRegistration: null,
    checkInterval: 60 * 60 * 1000, // Check every hour
    intervalId: null,

    /**
     * Initialize the update system
     */
    init() {
        if ('serviceWorker' in navigator) {
            window.addEventListener('load', () => {
                navigator.serviceWorker.register('./sw.js')
                    .then(reg => {
                        this.swRegistration = reg;
                        console.log('Updater: Service Worker registered');

                        // 1. Listen for new workers
                        reg.addEventListener('updatefound', () => {
                            const newWorker = reg.installing;
                            newWorker.addEventListener('statechange', () => {
                                if (newWorker.state === 'installed' && navigator.serviceWorker.controller) {
                                    this.showUpdateToast();
                                }
                            });
                        });

                        // 2. Initial Check
                        this.checkForUpdates();

                        // 3. Setup Auto-Polling
                        this.startAutoCheck();

                        // 4. Check on Visibility Change (Foreground)
                        document.addEventListener('visibilitychange', () => {
                            if (document.visibilityState === 'visible') {
                                this.checkForUpdates();
                            }
                        });
                    })
                    .catch(err => console.error('Updater: Registration failed', err));
            });

            // Listen for reload signal from SW
            navigator.serviceWorker.addEventListener('controllerchange', () => {
                window.location.reload();
            });
        }

        this.setupMaintenanceListeners();
    },

    /**
     * Manually check for updates
     */
    checkForUpdates() {
        if (this.swRegistration) {
            console.log('Updater: Checking for updates...');
            this.swRegistration.update();
        }
    },

    /**
     * Start periodic checks
     */
    startAutoCheck() {
        if (this.intervalId) clearInterval(this.intervalId);
        this.intervalId = setInterval(() => {
            this.checkForUpdates();
        }, this.checkInterval);
    },

    /**
     * Show the "Update Available" UI
     */
    showUpdateToast() {
        const toast = document.getElementById('update-toast');
        const refreshBtn = document.getElementById('update-refresh-btn');

        if (toast && refreshBtn) {
            toast.classList.add('visible');
            refreshBtn.onclick = () => this.forceUpdate();
        }
    },

    /**
     * Signal the Service Worker to skip waiting and activate new version
     */
    forceUpdate() {
        if (this.swRegistration && this.swRegistration.waiting) {
            this.swRegistration.waiting.postMessage({ type: 'SKIP_WAITING' });
        }
    },

    /**
     * Setup global maintenance listeners (Reset App)
     */
    setupMaintenanceListeners() {
        const resetBtn = document.getElementById('reset-app-btn');
        if (resetBtn) {
            resetBtn.onclick = () => this.resetApp();
        }
    },

    /**
     * EMERGENCY: Wipe all data and reload
     * Used for troubleshooting or clearing old badges
     */
    async resetApp() {
        if (confirm("Reset App Cache? \n\nThis will clear all badges, listening progress, and cached files. You will need an internet connection to reload the app.")) {
            // 1. Clear LocalStorage
            localStorage.clear();

            // 2. Clear All Caches
            if ('caches' in window) {
                const keys = await caches.keys();
                await Promise.all(keys.map(key => caches.delete(key)));
            }

            // 3. Unregister SW for clean slate
            if (this.swRegistration) {
                await this.swRegistration.unregister();
            }

            // 4. Reload
            window.location.reload();
        }
    }
};
