# Laporan Pengujian PWA

Tanggal pengujian: 20 Juli 2026

Tambahan pengujian: 21 Juli 2026

## Hasil Otomatis

| Pengujian | Hasil | Keterangan |
|---|---|---|
| Manifest JSON | Lulus | JSON valid, `display: standalone`, start URL dan scope relatif. |
| Ikon PWA | Lulus | 10 ikon tersedia dengan nama file baru `app-logo-*`, memakai logo baru, format PNG, dan dimensi sesuai manifest. |
| Logo header aplikasi | Lulus | Logo sidebar ditanam langsung di HTML sebagai data gambar, sehingga tidak bergantung pada path aset dan tidak menampilkan ikon gambar rusak. |
| JavaScript aplikasi | Lulus | Pemeriksaan sintaks tanpa error. |
| Menu Daftar Jasa Notaris | Lulus | Menu baru tersedia di navigasi desktop dan mobile tanpa menghapus menu lama. |

| Menu Laporan Keuangan | Lulus | Modul tambahan untuk pemasukan, pengeluaran, piutang invoice, saldo akun, cetak laporan, Excel laporan, dan backup data keuangan telah ditambahkan. |
| Revisi kategori pengeluaran | Lulus | Pilihan kategori pengeluaran berisi Gaji Kariyawan, Oprasional Office, Pajak-pajak, Voucher AHU, Paket PPAT, dan PNBP. |
| Form pengeluaran | Lulus | Nomor referensi dan nama file bukti dihapus dari form; referensi bukti pembayaran tersedia. |
| Revisi kategori pemasukan | Lulus | Pilihan kategori pemasukan manual berisi Notaris dan PPAT. |
| Form pemasukan | Lulus | Nomor referensi pemasukan manual dan pembayaran invoice dihapus; referensi bukti pembayaran tersedia. |
| Pembayaran invoice lintas periode | Lulus | Pembayaran invoice lama yang diterima pada periode berjalan tetap masuk Total Pembayaran Invoice. |
| Piutang invoice | Lulus | Total Piutang Invoice dihitung dari sisa tagihan invoice setelah seluruh pembayaran terkait. |
| Edit transaksi invoice | Lulus | Transaksi pemasukan dari invoice dilindungi agar tidak berubah menjadi pemasukan manual. |
| Bukti transfer laporan | Lulus | Bukti transfer tampil pada detail transaksi, dapat dicari, serta ikut tampil pada cetak/Word laporan. |
| Layout Word dan cetak | Lulus | Ringkasan total memakai tabel agar label dan nominal tidak menempel. |
| Bukti transfer Word dan cetak | Lulus | Dokumen menampilkan status Tersimpan, bukan nama file bukti pembayaran. |
| Vendor pengeluaran setelah reload | Lulus | `vendorName` tersimpan dan tetap tersedia setelah transaksi dimuat ulang dari LocalStorage. |
| Validasi nominal transaksi | Lulus | Nominal Rp0, negatif, NaN, Infinity, dan nilai tidak valid ditolak. |
| Validasi akun transaksi | Lulus | Transaksi baru dengan akun yang belum terdaftar ditolak. |
| Akun duplikat | Lulus | Nama akun duplikat ditolak walaupun berbeda huruf besar/kecil atau spasi. |
| Transactional akun | Lulus | Tambah, edit, dan hapus akun tidak mengubah state apabila penyimpanan gagal. |
| Piutang lunas/lebih bayar | Lulus | Invoice lunas, lebih bayar, dan sisa Rp0 tidak tampil dalam daftar piutang. |
| Periode laporan | Lulus | Ringkasan, transaksi, daftar piutang, cetak, Word, dan Excel mengikuti periode yang dipilih. |
| Periode terbalik | Lulus | Periode khusus dengan tanggal mulai lebih besar dari tanggal akhir ditolak. |
| Peringatan invoice | Lulus | Perubahan nilai invoice dan invoice sumber yang hilang ditampilkan pada transaksi terkait. |
| Duplikat transaksi invoice | Lulus | Tombol Duplikat disembunyikan untuk pembayaran invoice dan uang muka. |
| Uang muka ganda | Lulus | Uang muka invoice yang sama tidak dapat disimpan dua kali. |
| Backup sourceKey | Lulus | Backup dengan `sourceKey` uang muka yang sama ditolak. |
| Rollback impor | Lulus | Simulasi kegagalan LocalStorage saat impor mengembalikan data lama. |
| Status pembayaran invoice | Lulus | Invoice lama berstatus Lunas tanpa pembayaran tetap dihitung Belum Dibayar dan memiliki piutang. |
| Pembayaran sebagian | Lulus | Pembayaran sebagian menghasilkan sisa piutang yang benar. |
| Invoice Siap Dicatat | Lulus | Invoice Estimasi tidak muncul; invoice Lunas muncul sebagai kandidat **Belum Dicatat**. |
| Ubah status lewat Riwayat | Lulus | Invoice yang statusnya diubah dari **Estimasi Awal** menjadi **Lunas** melalui data riwayat masuk otomatis ke antrian **Belum Dicatat** tanpa menambah pemasukan. |
| Pemasukan invoice | Lulus | Status Lunas tidak menambah pemasukan sebelum tombol **Masukkan Pembayaran** ditekan. |
| Form pembayaran invoice | Lulus | Form otomatis mengisi ID invoice, nomor invoice, tanggal invoice, nama klien, jenis layanan, dan total invoice. |
| Anti-duplikat invoice | Lulus | Invoice yang sudah memiliki `sourceType: "invoice_payment"` dan `sourceKey` pembayaran tidak dapat dicatat ulang. |
| Hapus pembayaran invoice | Lulus | Setelah transaksi pembayaran dihapus, invoice kembali tampil sebagai **Belum Dicatat**. |
| Lebih bayar invoice | Lulus | Pembayaran di atas total invoice menghasilkan status keuangan **Lebih Bayar** dan sisa pembayaran Rp0. |
| Vendor/Penerima | Lulus | Vendor tampil pada tabel, detail, cetak, Word, serta Excel TRANSAKSI dan PENGELUARAN. |
| Filter transaksi terbalik | Lulus | Filter transaksi dengan tanggal mulai lebih besar dari tanggal akhir ditolak tanpa menampilkan pesan tidak ada transaksi. |
| Excel laporan keuangan | Lulus | Workbook laporan keuangan dibuat dengan tampilan lebih rapi dan sheet Ringkasan, Transaksi, Pemasukan, Pengeluaran, Kategori, serta Piutang Invoice. |
| Word laporan keuangan | Lulus | Tombol Unduh Word membentuk dokumen `.doc` dari format cetak laporan. |
| Cetak PDF laporan keuangan | Lulus | Tombol Cetak PDF memanggil dialog cetak browser dari area laporan keuangan. |
| Header periode cetak/Word | Lulus | Jenis laporan, periode, dan tanggal cetak tampil terpisah sehingga tanggal tidak bertumpuk. |
| Schema Supabase | Lulus | Tabel `app_user_state` tersedia, RLS aktif, dan policy select/insert/update/delete per user sudah terpasang. |
| Panel Supabase | Lulus | Menu Pengaturan Tarif memiliki kontrol Masuk, Daftar, Keluar, Sinkronkan Sekarang, Upload Data Lokal, dan Ambil Data Cloud. |
| Supabase Storage | Lulus | Bucket private `payment-proofs` tersedia dengan batas 10 MB dan tipe gambar/PDF. |
| Policy bukti pembayaran | Lulus | Policy Storage membatasi akses per folder user ID dan memberi admin akses baca lintas pengguna. |
| Role admin | Lulus | Tabel `app_profiles` tersedia dengan RLS; role admin dapat membaca daftar profil dan data cloud pengguna. |
| Upload bukti pembayaran | Lulus | Form invoice, pemasukan, dan pengeluaran menyimpan metadata Storage pada transaksi baru jika file browser sungguhan dipilih. |
| Kompatibilitas bukti lama | Lulus | Transaksi lama yang hanya memiliki nama file tetap tampil sebagai referensi tanpa memerlukan Storage path. |
| Fallback LocalStorage | Lulus | LocalStorage lama tetap dipakai sebagai cache/offline dan test regresi laporan keuangan tetap lulus. |
| Data jasa notaris | Lulus | 11 kategori dan 43 layanan tertanam di file HTML. |
| Pencarian dan filter jasa notaris | Lulus | Pencarian, filter kategori, reset, hasil kosong, dan tombol Salin lolos simulasi fungsi. |
| Service worker | Lulus | Pemeriksaan sintaks dan simulasi siklus hidup tanpa error. |
| Cache app shell | Lulus | Seluruh 15 URL app shell berhasil dimasukkan ke cache simulasi. |
| Navigasi online | Lulus | Strategi network-first terverifikasi. |
| Navigasi offline | Lulus | Fallback ke cache/index/offline terverifikasi. |
| Aset statis | Lulus | Strategi cache-first terverifikasi. |
| Request non-GET | Lulus | Tidak dicegat atau dicache. |
| Pembaruan PWA | Lulus | Pesan `SKIP_WAITING` dan alur reload terpasang. |
| XLSX lokal | Lulus | SheetJS versi 0.18.5 termuat lokal dan menghasilkan workbook XLSX valid. |
| Rumus aplikasi | Lulus | Seluruh regression test AJB, Hibah, APHB, Girik, APHT, SKMHT, pajak, layanan umum, dan pembulatan identik dengan hasil sebelumnya. |
| Word | Lulus | Dokumen Word invoice berhasil dibentuk dari data perhitungan tanpa nilai `undefined`. |
| Catatan standar | Lulus | Lima catatan tetap muncul dalam keluaran dokumen. |
| Path proyek | Lulus | Semua file app shell tersedia melalui HTTP lokal dengan status 200. |
| LocalStorage | Lulus | Key dan fungsi penyimpanan tidak diubah; service worker tidak mengakses LocalStorage. |
| Netlify | Lulus | `netlify.toml` tersedia dengan header service worker, manifest, dan aset. |

## Pemeriksaan Fitur PWA

| Fitur | Hasil |
|---|---|
| Tombol instal tersembunyi secara default | Lulus |
| Tombol tampil melalui `beforeinstallprompt` | Lulus secara struktural |
| Tombol hilang setelah `appinstalled` | Lulus secara struktural |
| Deteksi standalone | Lulus secara struktural |
| Petunjuk instal Safari iPhone/iPad | Lulus secara struktural |
| Indikator Online/Offline | Lulus secara struktural |
| Peringatan WhatsApp saat offline | Lulus |
| Shortcut Calculator dan Riwayat | Lulus |
| Notifikasi pembaruan tanpa reload otomatis | Lulus |

## Validasi Perangkat Setelah Deploy

Lingkungan pengujian internal tidak dapat mengaktifkan prompt pemasangan sistem operasi. Setelah proyek diunggah ke HTTPS Netlify, lakukan pemeriksaan singkat berikut pada perangkat nyata:

1. Android Chrome: pastikan tombol **Instal Aplikasi** muncul dan aplikasi terbuka tanpa bilah browser.
2. Safari iPhone/iPad: gunakan **Bagikan > Tambahkan ke Layar Utama** dan pastikan mode standalone.
3. Aktifkan mode pesawat setelah aplikasi dibuka satu kali, lalu periksa kalkulator, riwayat, Cetak, Word, Excel, Salin Rincian, serta Backup JSON.
4. Periksa dialog cetak dan unduhan berkas karena keduanya bergantung pada kebijakan browser/perangkat.
5. Pastikan URL produksi Netlify menggunakan HTTPS.

## Catatan Keamanan Data

Folder dan ZIP tidak memuat riwayat, backup JSON, atau data klien. Data pengguna tetap berada pada LocalStorage perangkat masing-masing sampai pengguna login dan menjalankan sinkronisasi Supabase; bukti pembayaran baru yang dipilih sebagai file browser sungguhan disimpan pada Supabase Storage private.
