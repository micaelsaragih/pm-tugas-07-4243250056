# Tugas Rutin 7 — Planner Tugas Kuliah

**Micael Zecsen Saragih | 4243250056 | PSIK24D | Ilmu Komputer UNIMED**

Aplikasi Flutter Planner Tugas Kuliah untuk mengelola judul tugas, mata kuliah, tenggat, dan status selesai. Menggunakan **Provider/ChangeNotifier** sebagai app state dan **setState** untuk filter halaman daftar. Tidak mengirim data ke backend atau melakukan penyimpanan permanen.

## Fitur
- Daftar tugas dengan filter Semua, Aktif, Selesai (FilterChip).
- Banner foto ruang belajar pada halaman daftar dan statistik, dilengkapi fallback ikon saat jaringan tidak tersedia.
- Form tambah tugas dengan validasi dan pemilih tanggal.
- Menandai selesai dan menghapus tugas.
- Statistik total, selesai, aktif dan persentase otomatis.
- Badge jumlah tugas aktif; NavigationBar pada mobile dan NavigationRail pada desktop.
- Navigasi go_router `/`, `/tambah`, `/statistik`.
- Tiga unit test tanpa UI.

## Peta state

```text
ChangeNotifierProvider<TugasModel> [STATE BERSAMA]
 ├── PlannerShell: badge jumlahAktif (context.select)
 ├── HalamanDaftar: daftar tugas (context.watch)
 │    └── FilterTugas [STATE LOKAL: setState]
 ├── HalamanTambah: form
 │    ├── TextEditingController x2 [STATE LOKAL, lifecycle]
 │    └── tanggal terpilih [STATE LOKAL: setState]
 └── HalamanStatistik: nilai agregat (context.watch)
```

## Lifecycle dan pilihan state management (150–250 kata)

Aplikasi Planner Tugas Kuliah memisahkan state berdasarkan cakupan penggunaannya. Filter Semua, Aktif, dan Selesai hanya dibutuhkan oleh halaman daftar. Oleh karena itu, nilai filter disimpan dalam StatefulWidget dan diperbarui melalui setState. Cara ini sederhana dan tidak membuat halaman lain ikut menyimpan pilihan filter. Form tambah tugas juga menggunakan StatefulWidget karena nilai input dan tanggal diproses sementara sebelum tugas disimpan.

Pada initState, dua TextEditingController dibuat untuk menampung judul dan nama mata kuliah. Keduanya dipakai selama pengguna mengisi formulir, kemudian wajib dibersihkan dalam dispose ketika halaman ditutup. Pembersihan tersebut mencegah kebocoran sumber daya. Pemilihan tanggal bersifat asinkron; setelah proses selesai, pemeriksaan mounted dilakukan sebelum setState, sebab pengguna mungkin sudah meninggalkan halaman.

Daftar tugas merupakan state bersama karena halaman daftar, statistik, dan badge navigasi membutuhkan data yang konsisten. Saya memilih Provider dengan ChangeNotifier agar logika tambah, tandai selesai, dan hapus dipisahkan dari tampilan, tetapi tetap mudah dipahami pada skala tugas kuliah. notifyListeners memberi tahu widget yang mendengarkan perubahan. Halaman statistik menggunakan context.watch untuk memperoleh data terbaru, sedangkan badge memakai context.select agar memantau jumlah tugas aktif saja. Pemisahan ini membuat kode lebih terstruktur dan logika dapat diuji melalui unit test tanpa memerlukan antarmuka Flutter.

## Foto dan sumber

Halaman **Daftar** menggunakan ilustrasi meja belajar karya Eric Bailey; halaman **Statistik** menggunakan foto laptop di meja karya Radek Grzybowski. Keduanya diambil dari Wikimedia Commons dan berlisensi CC0 1.0. Tautan asli dan detail penggunaan tercatat di [docs/KREDIT_FOTO.md](docs/KREDIT_FOTO.md).

**Catatan:** Foto ditampilkan lewat `Image.network`, bukan aset JPG lokal, sehingga membutuhkan akses ke Wikimedia Commons. Ketika foto gagal dimuat, ikon cadangan akan muncul. Gambar ini bersifat ilustratif dan tidak memengaruhi proses mengelola tugas.

## Cara menjalankan

```powershell
flutter pub get
flutter analyze
flutter test
flutter run -d chrome
```

Jika folder platform Flutter belum tersedia, jalankan satu kali: `flutter create --org id.ac.unimed --project-name pm_tugas_07_4243250056 .` sebelum `flutter run`.

Screenshot halaman daftar, form, statistik dan hasil pengujian harus dibuat dari aplikasi yang benar-benar berjalan di laptop. Source belum diuji ulang pada mesin pengembang setelah penambahan banner foto.

## Pernyataan AI

AI membantu penyusunan source code dan README; mahasiswa memeriksa dan menjalankan program, pengujian, serta dokumentasi akhir secara langsung.
