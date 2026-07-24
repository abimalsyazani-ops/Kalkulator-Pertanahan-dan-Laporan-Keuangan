const CACHE_NAME = "kalkulator-akta-pwa-v1.2.8";

const APP_SHELL = [
  "./",
  "./index.html",
  "./offline.html",
  "./manifest.webmanifest",
  "./assets/vendor/xlsx.full.min.js",
  "./assets/icons/app-logo-72.png",
  "./assets/icons/app-logo-96.png",
  "./assets/icons/app-logo-128.png",
  "./assets/icons/app-logo-144.png",
  "./assets/icons/app-logo-152.png",
  "./assets/icons/app-logo-192.png",
  "./assets/icons/app-logo-384.png",
  "./assets/icons/app-logo-512.png",
  "./assets/icons/app-logo-maskable-192.png",
  "./assets/icons/app-logo-maskable-512.png"
];

self.addEventListener("install", event => {
  event.waitUntil(
    caches
      .open(CACHE_NAME)
      .then(cache => cache.addAll(APP_SHELL))
      .then(() => {
        if (!self.registration.active) return self.skipWaiting();
        return undefined;
      })
  );
});

self.addEventListener("activate", event => {
  event.waitUntil(
    caches
      .keys()
      .then(keys => Promise.all(keys.filter(key => key !== CACHE_NAME).map(key => caches.delete(key))))
      .then(() => self.clients.claim())
  );
});

self.addEventListener("message", event => {
  if (event.data?.type === "SKIP_WAITING") self.skipWaiting();
});

function isExcludedRequest(request) {
  if (request.method !== "GET") return true;
  const url = new URL(request.url);
  return url.protocol === "blob:" || url.hostname === "wa.me" || url.hostname === "api.whatsapp.com";
}

async function networkFirstNavigation(request) {
  const cache = await caches.open(CACHE_NAME);
  try {
    const response = await fetch(request);
    if (response.ok && new URL(request.url).origin === self.location.origin) {
      await cache.put(request, response.clone());
    }
    return response;
  } catch {
    return (
      (await cache.match(request, { ignoreSearch: true })) ||
      (await cache.match("./index.html")) ||
      (await cache.match("./offline.html"))
    );
  }
}

async function cacheFirstStatic(request) {
  const cached = await caches.match(request, { ignoreSearch: false });
  if (cached) return cached;
  const response = await fetch(request);
  const url = new URL(request.url);
  if (response.ok && url.origin === self.location.origin) {
    const cache = await caches.open(CACHE_NAME);
    await cache.put(request, response.clone());
  }
  return response;
}

self.addEventListener("fetch", event => {
  const { request } = event;
  if (isExcludedRequest(request)) return;
  if (request.mode === "navigate") {
    event.respondWith(networkFirstNavigation(request));
    return;
  }
  event.respondWith(cacheFirstStatic(request));
});

