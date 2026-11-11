import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import 'tugas_model.dart';

// Ilustrasi ruang belajar, CC0 — Wikimedia Commons.
const bannerStatistikAsset = 'assets/images/banner_statistik.jpg';

class HalamanStatistik extends StatelessWidget {
  const HalamanStatistik({super.key});
  @override
  Widget build(BuildContext context) {
    final model = context.watch<TugasModel>();
    final screenWidth = MediaQuery.sizeOf(context).width;
    final bannerHeight = screenWidth >= 600 ? 160.0 : 140.0;
    return Scaffold(
      appBar: AppBar(title: const Text('Statistik Tugas')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: SizedBox(
                  height: bannerHeight,
                  width: double.infinity,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        bannerStatistikAsset,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            ColoredBox(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                              child: const Center(
                                child: Icon(Icons.auto_graph, size: 68),
                              ),
                            ),
                      ),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Colors.black.withValues(alpha: 0.75),
                              Colors.black.withValues(alpha: 0.15),
                            ],
                          ),
                        ),
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.all(18),
                          child: Text(
                            'Lihat progres belajarmu',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 21,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  offset: Offset(0, 1),
                                  blurRadius: 4,
                                  color: Colors.black54,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.assignment),
                  title: const Text('Total Tugas'),
                  trailing: Text('${model.jumlahTotal}'),
                ),
              ),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.check_circle_outline),
                  title: const Text('Tugas Selesai'),
                  trailing: Text('${model.jumlahSelesai}'),
                ),
              ),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.pending_actions),
                  title: const Text('Tugas Aktif'),
                  trailing: Text('${model.jumlahAktif}'),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Progres Penyelesaian',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              LinearProgressIndicator(
                value: model.persentaseSelesai / 100,
                minHeight: 12,
              ),
              const SizedBox(height: 10),
              Text(
                '${model.persentaseSelesai.toStringAsFixed(1)}% selesai',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
