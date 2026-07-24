# Kalkulator Biaya Akta dan Pertanahan - PWA

Proyek ini adalah versi PWA dari aplikasi Kalkulator Biaya Akta dan Pertanahan. Aplikasi tetap dapat berjalan di browser dan offline, dengan Supabase sebagai layanan login, sinkronisasi data cloud, dan penyimpanan bukti pembayaran.

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

Riwayat, pengaturan, invoice, dan laporan keuangan tetap menggunakan LocalStorage sebagai cache/offline dengan key lama yang kompatibel. Saat pengguna masuk Supabase, snapshot data dapat disinkronkan ke tabel `app_user_state`, sedangkan bukti pembayaran baru disimpan ke bucket private `payment-proofs`.

Backup JSON masih tersedia untuk arsip manual dan pemulihan darurat. Service worker hanya menyimpan file aplikasi statis dan tidak membaca, mengubah, atau menghapus LocalStorage.

## Pembaruan

Ketika service worker versi baru tersedia, aplikasi menampilkan tombol **Perbarui Sekarang**. Pembaruan tidak menghapus data LocalStorage.
