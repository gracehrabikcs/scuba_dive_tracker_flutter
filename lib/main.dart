import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'pages/dive_list_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
