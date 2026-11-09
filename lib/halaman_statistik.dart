import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';
import 'tugas_model.dart';

class HalamanStatistik extends StatelessWidget {
  const HalamanStatistik({super.key});
  @override
  Widget build(BuildContext context) {
    final model = context.watch<TugasModel>();
    return Scaffold(appBar: AppBar(title: const Text('Statistik Tugas')),
      body: Center(child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: ListView(padding: const EdgeInsets.all(20), children: [
          Card(child: ListTile(leading: const Icon(Icons.assignment),
            title: const Text('Total Tugas'), trailing: Text('${model.jumlahTotal}'))),
          Card(child: ListTile(leading: const Icon(Icons.check_circle_outline),
            title: const Text('Tugas Selesai'), trailing: Text('${model.jumlahSelesai}'))),
          Card(child: ListTile(leading: const Icon(Icons.pending_actions),
            title: const Text('Tugas Aktif'), trailing: Text('${model.jumlahAktif}'))),
          const SizedBox(height: 20),
          Text('Progres Penyelesaian', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          LinearProgressIndicator(value: model.persentaseSelesai / 100, minHeight: 12),
          const SizedBox(height: 10),
          Text('${model.persentaseSelesai.toStringAsFixed(1)}% selesai',
            textAlign: TextAlign.center),
        ]),
      )),
    );
  }
}
