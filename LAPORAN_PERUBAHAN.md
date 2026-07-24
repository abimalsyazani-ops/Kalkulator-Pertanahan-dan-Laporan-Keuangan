# Laporan Perubahan

Tanggal: 20 Juli 2026

Tambahan revisi: 21 Juli 2026

## Perubahan Utama

- Menambahkan menu baru **Laporan Keuangan** setelah **Daftar Jasa Notaris**.
- Menambahkan tab **Ringkasan**, **Pemasukan**, **Pengeluaran**, dan **Laporan**.
- Menambahkan LocalStorage baru:
  - `aktaPpatFinanceTransactionsV1`
  - `aktaPpatFinanceSettingsV1`
- Menambahkan pencatatan pemasukan manual, pengeluaran manual, pembayaran invoice, dan uang muka invoice.
- Menambahkan daftar invoice dan piutang tanpa mengubah data invoice lama.
- Menambahkan saldo akun/kas dengan saldo awal.
- Menambahkan cetak laporan keuangan menggunakan area cetak baru `financePrintArea`.
- Menambahkan ekspor Excel laporan keuangan dengan sheet ringkasan, transaksi, pemasukan, pengeluaran, dan piutang invoice.
- Menambahkan data keuangan ke backup JSON dengan properti `finance`.
- Menaikkan cache PWA ke `kalkulator-akta-pwa-v1.1.0`.

## Batasan yang Dijaga

- Rumus kalkulator akta dan pertanahan tidak diubah.
- Struktur record invoice/perhitungan lama tidak diubah.
- Key LocalStorage lama tidak diganti.
- Fitur cetak invoice, Word, Excel invoice, Salin Rincian, WhatsApp, riwayat, dan backup lama tetap dipertahankan.
- Invoice tidak otomatis dihitung sebagai pemasukan sebelum pembayaran dicatat.

## Revisi Laporan Keuangan 21 Juli 2026

- Mengubah pilihan kategori pengeluaran menjadi **Gaji Kariyawan**, **Oprasional Office**, **Pajak-pajak**, **Voucher AHU**, **Paket PPAT**, dan **PNBP**.
- Menghapus input nomor referensi pada form pengeluaran.
- Mengganti input nama file bukti pada form pengeluaran menjadi referensi bukti pembayaran.
- Menambahkan tombol **Cetak PDF** dan **Unduh Word** pada laporan keuangan.
- Merapikan ekspor Excel laporan keuangan dengan sheet ringkasan, transaksi, pemasukan, pengeluaran, kategori, dan piutang invoice.
- Menaikkan cache PWA ke `kalkulator-akta-pwa-v1.1.1`.

## Revisi Pemasukan 21 Juli 2026

- Mengubah pilihan kategori pemasukan manual menjadi **Notaris** dan **PPAT**.
- Menghapus input nomor referensi pada pemasukan manual dan pembayaran invoice.
- Mengganti nomor referensi pemasukan dengan referensi bukti pembayaran.
- Menaikkan cache PWA ke `kalkulator-akta-pwa-v1.1.2`.

## Uji Coba dan Perbaikan Laporan Keuangan 21 Juli 2026

- Memperbaiki ringkasan **Total Pembayaran Invoice** agar pembayaran invoice lama yang diterima pada periode laporan tetap ikut terbaca.
- Memperbaiki perhitungan **Total Piutang Invoice** agar berdasarkan sisa tagihan invoice, bukan sekadar total invoice dikurangi pembayaran pada periode yang sama.
- Mencegah transaksi pemasukan dari invoice diedit melalui form pemasukan manual agar hubungan invoice dan piutang tidak rusak.
- Menambahkan informasi **Bukti transfer** pada detail transaksi, pencarian transaksi, serta format cetak/Word laporan keuangan.
- Menaikkan cache PWA ke `kalkulator-akta-pwa-v1.1.3`.

## Perbaikan Bug Laporan Keuangan 21 Juli 2026

- Menyimpan `vendorName` pada transaksi pengeluaran, dengan fallback dari data lama yang masih memakai `clientName`.
- Menolak transaksi nominal Rp0, negatif, NaN, Infinity, atau tidak valid.
- Menolak transaksi baru yang memakai akun keuangan yang belum terdaftar.
- Menolak nama akun duplikat walaupun berbeda huruf besar/kecil atau spasi.
- Membuat tambah, edit, dan hapus akun lebih aman dengan penyimpanan transactional.
- Menyaring invoice lunas, lebih bayar, dan sisa tagihan Rp0 dari daftar piutang.
- Menyesuaikan ringkasan, transaksi, daftar piutang, cetak, Word, dan Excel agar mengikuti periode yang dipilih.
- Menolak periode khusus dengan tanggal mulai lebih besar dari tanggal akhir.
- Menampilkan peringatan jika nilai invoice berubah setelah pembayaran dicatat atau invoice sumber sudah dihapus.
- Menyembunyikan tombol Duplikat untuk pembayaran invoice dan uang muka.
- Menolak backup dengan `sourceKey` uang muka yang sama.
- Membuat proses impor backup transactional dan rollback jika penyimpanan gagal.
- Mengubah alur **Catat Uang Muka** agar membuka form pembayaran terlebih dahulu dan tetap menolak pencatatan ganda.
- Mengubah label bukti pembayaran menjadi **Referensi bukti pembayaran (nama file saja)**.
- Mengaktifkan tombol **Tambah Akun** untuk membersihkan dan memfokuskan form akun.
- Menaikkan cache PWA ke `kalkulator-akta-pwa-v1.1.4`.

## Perapihan Word dan Cetak Laporan Keuangan 21 Juli 2026

- Merapikan ringkasan total pada format Word dan cetak agar label dan nominal tidak menempel.
- Mengubah tampilan bukti transfer pada Word dan cetak menjadi **Tersimpan** jika referensi file tersedia.
- Menaikkan cache PWA ke `kalkulator-akta-pwa-v1.1.5`.

## Perbaikan Tiga Bug Tersisa Laporan Keuangan 21 Juli 2026

- Mengubah status keuangan invoice agar dihitung dari transaksi pembayaran yang tercatat, bukan dari status invoice lama.
- Menampilkan peringatan **Status invoice tercatat Lunas, tetapi pembayaran belum tercatat penuh dalam laporan keuangan.** jika invoice lama berstatus Lunas/Lebih Bayar namun pembayaran belum tercatat penuh.
- Menambahkan kolom/label **Vendor/Penerima** pada tabel transaksi, detail transaksi, cetak, Word, Excel sheet **TRANSAKSI**, dan Excel sheet **PENGELUARAN**.
- Menambahkan fallback vendor dari `vendorName`, `payeeName`, lalu data lama yang masih tersimpan sebagai penerima pengeluaran.
- Menolak periode terbalik pada filter transaksi, laporan periode khusus, daftar piutang, cetak, Word, dan Excel dengan pesan **Tanggal mulai tidak boleh lebih besar dari tanggal akhir.**
- Menaikkan cache PWA ke `kalkulator-akta-pwa-v1.1.6`.

## Perbaikan Alur Invoice Menjadi Pemasukan 21 Juli 2026

- Mengubah daftar pada tab pemasukan menjadi **Invoice Siap Dicatat**.
- Invoice hanya tampil sebagai kandidat jika status invoice sudah **Lunas**.
- Status invoice **Lunas** tidak otomatis menambah total pemasukan.
- Menambahkan status pencatatan keuangan terpisah: **Belum Dicatat** dan **Sudah Dicatat**.
- Menambahkan filter sederhana **Semua**, **Belum Dicatat**, dan **Sudah Dicatat**.
- Tombol **Catat Pembayaran** hanya membuka form; transaksi baru tersimpan setelah tombol **Masukkan Pembayaran** ditekan.
- Form pembayaran otomatis mengisi ID invoice, nomor invoice, tanggal invoice, nama klien, jenis layanan, dan total invoice.
- Pembayaran invoice disimpan dengan `sourceType: "invoice_payment"` dan `sourceKey: "{invoiceId}-payment"` agar invoice yang sama tidak tercatat dua kali.
- Pembayaran sebagian dan lebih bayar tetap dapat disimpan setelah konfirmasi, dengan status keuangan dan sisa pembayaran yang sesuai.
- Jika transaksi pembayaran invoice dihapus, invoice kembali tampil sebagai **Belum Dicatat**.
- Menaikkan cache PWA ke `kalkulator-akta-pwa-v1.1.7`.

## Perapihan Tanggal Cetak dan Word Laporan Keuangan 21 Juli 2026

- Merapikan header periode pada cetak dan unduh Word laporan keuangan.
- Memisahkan informasi **Jenis laporan**, **Periode**, dan **Tanggal cetak** agar tanggal tidak bertumpuk atau dobel.
- Untuk laporan harian, periode kini tampil satu kali sebagai tanggal laporan.
- Menaikkan cache PWA ke `kalkulator-akta-pwa-v1.1.8`.

## Migrasi Supabase 24 Juli 2026

- Menambahkan koneksi Supabase ke project `https://ryypcolefvucmkzugard.supabase.co` menggunakan publishable key.
- Menambahkan tabel cloud `public.app_user_state` untuk menyimpan snapshot backup data aplikasi per akun Supabase.
- Mengaktifkan RLS dan policy agar setiap user hanya dapat membaca dan menulis datanya sendiri.
- Menambahkan panel **Sinkronisasi Supabase** pada menu **Pengaturan Tarif**.
- Menambahkan tombol **Masuk**, **Daftar**, **Keluar**, **Sinkronkan Sekarang**, **Upload Data Lokal**, dan **Ambil Data Cloud**.
- Menjaga LocalStorage lama sebagai cache/fallback agar aplikasi tetap bisa berjalan offline.
- Menambahkan file dokumentasi schema `SUPABASE_SCHEMA.sql`.
- Menaikkan cache PWA ke `kalkulator-akta-pwa-v1.1.9`.

## Supabase Storage dan Admin 24 Juli 2026

- Menambahkan tabel `public.app_profiles` untuk role `user` dan `admin`.
- Menambahkan policy admin agar admin dapat memuat data cloud pengguna lain untuk pemeriksaan laporan.
- Menambahkan bucket private `payment-proofs` untuk bukti pembayaran berupa gambar/PDF.
- Menambahkan policy Storage agar pengguna hanya dapat mengakses file pada folder user ID miliknya, sedangkan admin dapat membaca semua bukti pembayaran.
- Mengubah input bukti pembayaran pada pembayaran invoice, pemasukan manual, dan pengeluaran agar file browser sungguhan diupload ke Supabase Storage.
- Menyimpan metadata bukti baru pada transaksi: `receiptBucket`, `receiptStoragePath`, dan `receiptUploadedAt`.
- Menambahkan tombol admin **Refresh Pengguna** dan **Muat Data Pengguna** pada panel Supabase.
- Menjaga kompatibilitas data lama yang hanya memiliki `receiptFileName` atau `receiptReference`.
- Menaikkan cache PWA ke `kalkulator-akta-pwa-v1.2.0`.

## Perapihan Setelah Supabase 24 Juli 2026

- Merapikan teks yang masih menyebut data hanya tersimpan di browser/perangkat.
- Menyesuaikan label tombol cloud menjadi **Kirim Data Lokal ke Cloud** dan **Ambil Data Cloud ke Browser**.
- Menjelaskan bahwa Backup JSON tetap dipertahankan untuk arsip manual dan pemulihan darurat.
- Memperbarui README agar sesuai dengan arsitektur PWA + Supabase Auth + Supabase Storage.
- Menaikkan cache PWA ke `kalkulator-akta-pwa-v1.2.1`.

## Sinkronisasi Otomatis Tanpa Form Login 24 Juli 2026

- Menghapus kolom email, password, dan tombol login/sinkron manual dari panel **Sinkronisasi Supabase**.
- Mengubah alur Supabase menjadi sesi anonymous otomatis melalui `signInAnonymously()`.
- Mengupload snapshot data lokal ke Supabase secara otomatis setelah sesi anonymous tersedia.
- Mempertahankan RLS dan user ID Supabase agar data setiap browser tetap terisolasi.
- Memperbarui README dan laporan pengujian sesuai alur tanpa form login.
- Menaikkan cache PWA ke `kalkulator-akta-pwa-v1.2.2`.

## Perapihan Filter Periode Keuangan 24 Juli 2026

- Menghapus panel **Filter Periode Keuangan** dari menu **Laporan Keuangan**.
- Ringkasan keuangan, invoice siap dicatat, dan daftar transaksi utama kembali memakai **Semua Periode** secara otomatis.
- Filter tanggal khusus tetap tersedia pada daftar transaksi dan tab **Laporan** untuk kebutuhan cetak, Word, PDF, dan Excel.
- Menaikkan cache PWA ke `kalkulator-akta-pwa-v1.2.3`.
