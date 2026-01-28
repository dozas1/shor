// Service Worker para SHOR PWA
const CACHE_NAME = 'shor-v1';
const urlsToCache = [
  '/shor/',
  '/shor/index.html',
  '/shor/manifest.json',
  '/shor/icon-192.png',
  '/shor/icon-512.png'
];

// Instalación del service worker
self.addEventListener('install', event => {
  event.waitUntil(
    caches.open(CACHE_NAME)
      .then(cache => {
        console.log('[SW] Caché abierto');
        return cache.addAll(urlsToCache);
      })
  );
});

// Activación del service worker
self.addEventListener('activate', event => {
  event.waitUntil(
    caches.keys().then(cacheNames => {
      return Promise.all(
        cacheNames.map(cacheName => {
          if (cacheName !== CACHE_NAME) {
            console.log('[SW] Eliminando caché antigua:', cacheName);
            return caches.delete(cacheName);
          }
        })
      );
    })
  );
});

// Interceptar peticiones
self.addEventListener('fetch', event => {
  event.respondWith(
    caches.match(event.request)
      .then(response => {
        // Retornar desde caché si existe, sino hacer fetch
        return response || fetch(event.request);
      })
  );
});
