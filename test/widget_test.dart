import 'package:flutter_test/flutter_test.dart';
import 'package:pm_tugas_07_4243250056/main.dart';
import 'package:pm_tugas_07_4243250056/tugas_model.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Aplikasi dapat menampilkan banner dan navigasi berfungsi', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => TugasModel(),
        child: const PlannerApp(),
      ),
    );
    await tester.pumpAndSettle();

    // Pastikan judul dan teks banner halaman daftar muncul
    expect(find.text('Planner Tugas Kuliah'), findsOneWidget);
    expect(find.text('Atur tugas, raih target.'), findsOneWidget);

    // Navigasi ke halaman Statistik
    await tester.tap(find.text('Statistik'));
    await tester.pumpAndSettle();

    // Pastikan judul dan teks banner halaman statistik muncul
    expect(find.text('Statistik Tugas'), findsOneWidget);
    expect(find.text('Lihat progres belajarmu'), findsOneWidget);
  });
}
