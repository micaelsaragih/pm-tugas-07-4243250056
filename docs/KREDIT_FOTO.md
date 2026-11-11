# Kredit Foto — Planner Tugas Kuliah

Foto yang digunakan sebagai ilustrasi suasana belajar, bukan foto pribadi mahasiswa.

| Tampilan | File Lokal | Karya Asli | Fotografer | Lisensi | Sumber |
|---|---|---|---|---|---|
| Banner daftar | `assets/images/banner_daftar.jpg` | Laptop picture with notepad.jpg | Eric Bailey | CC0 1.0 | https://commons.wikimedia.org/wiki/File:Laptop_picture_with_notepad.jpg |
| Banner statistik | `assets/images/banner_statistik.jpg` | Laptop on a desk.jpg | Radek Grzybowski | CC0 1.0 | https://commons.wikimedia.org/wiki/File:Laptop_on_a_desk.jpg |

## Status Penyimpanan dan Integrasi

1. **Aset Lokal**: Kedua gambar telah diunduh dari Wikimedia Commons dalam format JPEG asli dan disimpan secara lokal di folder `assets/images/`.
2. **Pendaftaran Aset**: Folder dan berkas gambar telah didaftarkan pada `pubspec.yaml` di bawah konfigurasi `flutter.assets`.
3. **Pemuatan Aset**: Kode program pada `lib/halaman_daftar.dart` dan `lib/halaman_statistik.dart` telah dialihkan dari `Image.network` menjadi `Image.asset` (`banner_daftar.jpg` dan `banner_statistik.jpg`).
4. **Bebas Ketergantungan Internet**: Aplikasi tidak lagi memerlukan koneksi internet untuk memuat banner, dan tidak terpengaruh oleh pembatasan akses atau pemblokiran ke Wikimedia Commons.
5. **Penyajian Visual**: Kedua banner disajikan dengan pemotongan visual `BoxFit.cover`, sudut membulat (`ClipRRect` 16px), serta lapisan overlay gradien gelap transparan agar teks tetap kontras dan mudah dibaca pada berbagai ukuran layar (mobile, tablet, desktop).

Lisensi CC0 1.0 Universal (Public Domain Dedication): https://creativecommons.org/publicdomain/zero/1.0/
