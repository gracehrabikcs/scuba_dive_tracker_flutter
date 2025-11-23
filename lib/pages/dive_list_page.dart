import 'package:flutter/material.dart';
import '../data/firestore_service.dart';
import '../models/dive.dart';
import '../widgets/dive_tile.dart';
import 'add_dive_page.dart';

class DiveListPage extends StatelessWidget {
  const DiveListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final service = FirestoreService();

    return Scaffold(
      appBar: AppBar(title: const Text("My Dive Log")),
      body: StreamBuilder<List<Dive>>(
        stream: service.getDives(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final dives = snapshot.data!;

          if (dives.isEmpty) {
            return const Center(child: Text("No dives logged yet."));
          }

          return ListView.builder(
            itemCount: dives.length,
            itemBuilder: (context, index) {
              return DiveTile(dive: dives[index]);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddDivePage()),
          );
        },
      ),
    );
  }
}
