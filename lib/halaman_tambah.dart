import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import 'tugas_model.dart';
import 'halaman_daftar.dart';

class HalamanTambah extends StatefulWidget {
  const HalamanTambah({super.key});
  @override
  State<HalamanTambah> createState() => _HalamanTambahState();
}

class _HalamanTambahState extends State<HalamanTambah> {
  late final TextEditingController _judul;
  late final TextEditingController _mataKuliah;
  late DateTime _tenggat;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _judul = TextEditingController();
    _mataKuliah = TextEditingController();
    _tenggat = DateTime.now().add(const Duration(days: 7));
  }

  @override
  void dispose() {
    _judul.dispose();
    _mataKuliah.dispose();
    super.dispose();
  }

  Future<void> _pilihTanggal() async {
    final hasil = await showDatePicker(
      context: context,
      initialDate: _tenggat,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (!mounted || hasil == null) return;
    setState(() => _tenggat = hasil);
  }

  void _simpan() {
    if (!_formKey.currentState!.validate()) return;
    context.read<TugasModel>().tambah(
      judul: _judul.text,
      mataKuliah: _mataKuliah.text,
      tenggat: _tenggat,
    );
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Tugas')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 620),
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                TextFormField(
                  controller: _judul,
                  decoration: const InputDecoration(
                    labelText: 'Judul tugas',
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) =>
                      (v?.trim().isEmpty ?? true) ? 'Judul wajib diisi' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _mataKuliah,
                  decoration: const InputDecoration(
                    labelText: 'Mata kuliah',
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) => (v?.trim().isEmpty ?? true)
                      ? 'Mata kuliah wajib diisi'
                      : null,
                ),
                const SizedBox(height: 16),
                OutlinedButton.icon(
                  onPressed: _pilihTanggal,
                  icon: const Icon(Icons.event),
                  label: Text('Tenggat: ${tanggal(_tenggat)}'),
                ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _simpan,
                  icon: const Icon(Icons.save_outlined),
                  label: const Text('Simpan tugas'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
