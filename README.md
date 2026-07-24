# Kalkulator Biaya Akta dan Pertanahan - PWA

Proyek ini adalah versi PWA dari aplikasi Kalkulator Biaya Akta dan Pertanahan. Seluruh perhitungan dan data tetap berjalan di browser. Tidak ada backend, database, login, atau data klien yang disertakan dalam folder proyek.

## Menjalankan Lokal

PWA memerlukan secure context. Gunakan server lokal dan jangan membuka `index.html` langsung melalui `file://`.

```text
python -m http.server 4173
```

Kemudian buka `http://localhost:4173`.

## Mengunggah ke Netlify

1. Unggah seluruh isi folder ini atau gunakan ZIP proyek.
2. Netlify membaca `netlify.toml` dan memublikasikan folder proyek secara langsung.
3. Pastikan alamat produksi menggunakan HTTPS.
4. Buka aplikasi satu kali saat online agar seluruh app shell tersimpan untuk penggunaan offline.

## Penyimpanan Data

Riwayat, pengaturan, dan data klien tetap disimpan pada LocalStorage browser dengan key yang sama seperti aplikasi sebelumnya. Service worker hanya menyimpan file aplikasi statis dan tidak membaca, mengubah, atau menghapus LocalStorage.

## Pembaruan

Ketika service worker versi baru tersedia, aplikasi menampilkan tombol **Perbarui Sekarang**. Pembaruan tidak menghapus data LocalStorage.
