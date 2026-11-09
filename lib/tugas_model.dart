import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'tugas_kuliah.dart';

class TugasModel extends ChangeNotifier {
  final List<TugasKuliah> _tugas = [];
  int _idBerikutnya = 1;

  UnmodifiableListView<TugasKuliah> get tugas => UnmodifiableListView(_tugas);
  int get jumlahTotal => _tugas.length;
  int get jumlahSelesai => _tugas.where((t) => t.selesai).length;
  int get jumlahAktif => jumlahTotal - jumlahSelesai;
  double get persentaseSelesai => jumlahTotal == 0 ? 0 : jumlahSelesai / jumlahTotal * 100;

  void tambah({required String judul, required String mataKuliah, required DateTime tenggat}) {
    final j = judul.trim();
    final m = mataKuliah.trim();
    if (j.isEmpty || m.isEmpty) throw ArgumentError('Judul dan mata kuliah tidak boleh kosong');
    _tugas.add(TugasKuliah(id: _idBerikutnya++, judul: j, mataKuliah: m, tenggat: tenggat));
    _tugas.sort((a, b) => a.tenggat.compareTo(b.tenggat));
    notifyListeners();
  }

  void tandaiSelesai(int id) {
    final index = _tugas.indexWhere((t) => t.id == id);
    if (index == -1) return;
    _tugas[index] = _tugas[index].salin(selesai: !_tugas[index].selesai);
    notifyListeners();
  }

  void hapus(int id) {
    final sebelum = _tugas.length;
    _tugas.removeWhere((t) => t.id == id);
    if (_tugas.length != sebelum) notifyListeners();
  }
}
