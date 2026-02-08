const CACHE_NAME = 'midnight-review-v1.2.4';
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
    './js/welcomeModal.js',
    './js/tracking.js',
    './js/icons.js',
    './js/descriptions.js',
    './js/series/pmr_board_review.js',
    './cover.jpg',
    './cover.png'
];

// Install Event: Cache essential assets
self.addEventListener('install', (event) => {
    event.waitUntil(
        caches.open(CACHE_NAME)
            .then((cache) => cache.addAll(ASSETS_TO_CACHE))
            .then(() => self.skipWaiting())
    );
});

// Activate Event: Clean up old caches
self.addEventListener('activate', (event) => {
    event.waitUntil(
        caches.keys().then((cacheNames) => {
            return Promise.all(
                cacheNames.map((cacheName) => {
                    if (cacheName !== CACHE_NAME) {
                        return caches.delete(cacheName);
                    }
                })
            );
        }).then(() => self.clients.claim())
    );
});

// Fetch Event: Stale-While-Revalidate Strategy
// Search for cached version, but always try to update it in the background
self.addEventListener('fetch', (event) => {
    // Skip external audio/fonts (let browser handle those)
    if (!event.request.url.startsWith(self.location.origin)) return;

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
