const CACHE_NAME = 'midnight-review-v1.3.2';
const ASSETS_TO_CACHE = [
    './',
    './index.html',
    './style.css',
    './site.webmanifest',
    './js/player.js',
    './js/state.js',
    './js/ui.js',
    './js/episodes.js',
    './js/library.js',
    './js/share.js',
    './js/modules/stickyPlayer.js', // Cache New Module
    './js/modules/rssModal.js',     // Cache New Module
    './js/tracking.js',
    './js/icons.js',
    './js/descriptions.js',
    './js/series/pmr_board_review.js',
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
