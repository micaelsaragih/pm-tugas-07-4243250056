import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';
import 'tugas_model.dart';

enum FilterTugas { semua, aktif, selesai }

class HalamanDaftar extends StatefulWidget {
  const HalamanDaftar({super.key});
  @override
  State<HalamanDaftar> createState() => _HalamanDaftarState();
}
class _HalamanDaftarState extends State<HalamanDaftar> {
  FilterTugas _filter = FilterTugas.semua; // Ephemeral state: hanya halaman daftar.
  @override
  Widget build(BuildContext context) {
    final model = context.watch<TugasModel>();
    final items = model.tugas.where((t) => switch (_filter) {
      FilterTugas.semua => true,
      FilterTugas.aktif => !t.selesai,
      FilterTugas.selesai => t.selesai,
    }).toList();
    return Scaffold(
      appBar: AppBar(title: const Text('Planner Tugas Kuliah')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/tambah'),
        icon: const Icon(Icons.add), label: const Text('Tambah Tugas')),
      body: Column(children: [
        SizedBox(height: 66, child: ListView(scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          children: [
            for (final f in FilterTugas.values) Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChip(
                label: Text(switch(f) { FilterTugas.semua => 'Semua', FilterTugas.aktif => 'Aktif', FilterTugas.selesai => 'Selesai' }),
                selected: _filter == f,
                onSelected: (_) => setState(() => _filter = f)),
            ),
          ],
        )),
        Expanded(child: items.isEmpty
          ? Center(child: Text(model.jumlahTotal == 0
              ? 'Belum ada tugas. Tambahkan tugas pertamamu.'
              : 'Tidak ada tugas pada filter ini.'))
          : ListView.builder(itemCount: items.length, itemBuilder: (context, i) {
              final t = items[i];
              return Card(margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                child: ListTile(
                  leading: Checkbox(value: t.selesai,
                    onChanged: (_) => context.read<TugasModel>().tandaiSelesai(t.id)),
                  title: Text(t.judul,
                    style: t.selesai ? const TextStyle(decoration: TextDecoration.lineThrough) : null),
                  subtitle: Text('${t.mataKuliah} • Tenggat ${tanggal(t.tenggat)}'),
                  trailing: IconButton(tooltip: 'Hapus ${t.judul}',
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () => context.read<TugasModel>().hapus(t.id)),
                ),
              );
            })),
      ]),
    );
  }
}
String tanggal(DateTime value) => '${value.day.toString().padLeft(2,'0')}/${value.month.toString().padLeft(2,'0')}/${value.year}';
