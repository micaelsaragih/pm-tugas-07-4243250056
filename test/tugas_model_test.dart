import 'package:flutter_test/flutter_test.dart';
import 'package:pm_tugas_07_4243250056/tugas_model.dart';

void main() {
  test('tambah tugas memperbarui jumlah dan badge aktif', () {
    final model = TugasModel();
    model.tambah(judul: 'Laporan', mataKuliah: 'Mobile', tenggat: DateTime(2026, 11, 20));
    expect(model.jumlahTotal, 1);
    expect(model.jumlahAktif, 1);
    model.dispose();
  });

  test('tandai selesai memperbarui persentase', () {
    final model = TugasModel();
    model.tambah(judul: 'A', mataKuliah: 'Mobile', tenggat: DateTime(2026, 11, 20));
    model.tambah(judul: 'B', mataKuliah: 'Mobile', tenggat: DateTime(2026, 11, 21));
    final id = model.tugas.first.id;
    model.tandaiSelesai(id);
    expect(model.jumlahSelesai, 1);
    expect(model.jumlahAktif, 1);
    expect(model.persentaseSelesai, 50);
    model.dispose();
  });

  test('hapus mengurangi jumlah total tanpa memengaruhi tugas lain', () {
    final model = TugasModel();
    model.tambah(judul: 'A', mataKuliah: 'Mobile', tenggat: DateTime(2026, 11, 20));
    model.tambah(judul: 'B', mataKuliah: 'Mobile', tenggat: DateTime(2026, 11, 21));
    final id = model.tugas.first.id;
    model.hapus(id);
    expect(model.jumlahTotal, 1);
    expect(model.tugas.single.judul, 'B');
    model.dispose();
  });
}
