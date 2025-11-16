import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/dive.dart';
import 'pages/dive_list_page.dart';
import 'data/hive_boxes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(DiveAdapter());
  await Hive.openBox<Dive>(HiveBoxes.diveBox);

  runApp(const DiveTrackerApp());
}

class DiveTrackerApp extends StatelessWidget {
  const DiveTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scuba Dive Tracker',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const DiveListPage(),
    );
  }
}
