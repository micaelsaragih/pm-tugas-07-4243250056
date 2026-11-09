import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';
import 'halaman_daftar.dart';
import 'halaman_tambah.dart';
import 'halaman_statistik.dart';
import 'tugas_model.dart';

void main() => runApp(ChangeNotifierProvider(
  create: (_) => TugasModel(), child: const PlannerApp(),
));

final plannerRouter = GoRouter(
  initialLocation: '/',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, shell) => PlannerShell(shell: shell),
      branches: [
        StatefulShellBranch(routes: [
          GoRoute(path: '/', builder: (_, __) => const HalamanDaftar(), routes: [
            GoRoute(path: 'tambah', builder: (_, __) => const HalamanTambah()),
          ]),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(path: '/statistik', builder: (_, __) => const HalamanStatistik()),
        ]),
      ],
    ),
  ],
);

class PlannerApp extends StatelessWidget {
  const PlannerApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp.router(
    title: 'Planner Tugas Kuliah', debugShowCheckedModeBanner: false,
    theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo), useMaterial3: true),
    routerConfig: plannerRouter,
  );
}

class PlannerShell extends StatelessWidget {
  const PlannerShell({super.key, required this.shell});
  final StatefulNavigationShell shell;
  @override
  Widget build(BuildContext context) {
    final aktif = context.select((TugasModel model) => model.jumlahAktif);
    final lebar = MediaQuery.sizeOf(context).width;
    final iconDaftar = Badge.count(count: aktif, isLabelVisible: aktif > 0,
      child: const Icon(Icons.assignment_outlined));
    void pilih(int i) => shell.goBranch(i, initialLocation: shell.currentIndex == i);
    if (lebar >= 840) {
      return Scaffold(body: Row(children: [
        NavigationRail(
          selectedIndex: shell.currentIndex, onDestinationSelected: pilih,
          labelType: NavigationRailLabelType.all,
          destinations: [
            NavigationRailDestination(icon: iconDaftar, label: const Text('Daftar')),
            const NavigationRailDestination(icon: Icon(Icons.pie_chart_outline), label: Text('Statistik')),
          ],
        ),
        const VerticalDivider(width: 1),
        Expanded(child: shell),
      ]));
    }
    return Scaffold(body: shell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: shell.currentIndex, onDestinationSelected: pilih,
        destinations: [
          NavigationDestination(icon: iconDaftar, label: 'Daftar'),
          const NavigationDestination(icon: Icon(Icons.pie_chart_outline), label: 'Statistik'),
        ],
      ),
    );
  }
}
