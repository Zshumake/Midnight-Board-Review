const CACHE_NAME = 'midnight-review-v2.0.2';
const ASSETS_TO_CACHE = [
    './',
    './index.html',
    './style.v2.0.1.css',
    './site.webmanifest',
    './js/player.js',
    './js/state.js',
    './js/library.js', // Keeps library logic
    './js/share.js',
    './js/tracking.js',
    './js/episodes.js',
    './js/icons.js',
    './js/descriptions.js',
    './js/series/pmr_board_review.js',
    // New Modules
    './js/modules/audioEngine.js',
    './js/modules/infoModal.js',
    './js/modules/reportModal.js',
    './js/modules/rssModal.js',
    './js/modules/searchEngine.js',
    './js/modules/synonyms.js',
    './js/modules/updater.js',
    './js/modules/ui/controls.js',
    './js/modules/ui/feedback.js',
    './js/modules/ui/libraryRenderer.js',
    './js/modules/ui/metadata.js',
    './js/modules/ui/progressBar.js',
    // Assets
    './cover.jpg',
    './cover.png'
];

// ... (install/activate listeners irrelevant to change)

// Fetch Event: Stale-While-Revalidate Strategy
// Search for cached version, but always try to update it in the background
self.addEventListener('fetch', (event) => {
    const url = event.request.url;

    // 1. Skip external requests
    if (!url.startsWith(self.location.origin)) return;

    // 2. CRITICAL: Skip Audio Files to fix Lock Screen/Background Playback on iOS
    // Safari Range Requests fail if served from Service Worker cache without full 206 support.
    if (url.endsWith('.mp3') || url.endsWith('.m4a') || url.includes('.mp3') || url.includes('.m4a')) {
        return;
    }

    event.respondWith(
        caches.match(event.request).then((cachedResponse) => {
            const fetchPromise = fetch(event.request).then((networkResponse) => {
                caches.open(CACHE_NAME).then((cache) => {
                    cache.put(event.request, networkResponse.clone());
                });
                return networkResponse;
            });
            return cachedResponse || fetchPromise;
        })
    );
});

// Message Listener for skipWaiting
self.addEventListener('message', (event) => {
    if (event.data && event.data.type === 'SKIP_WAITING') {
        self.skipWaiting();
    }
});
