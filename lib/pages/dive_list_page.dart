import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../data/hive_boxes.dart';
import '../models/dive.dart';
import '../widgets/dive_tile.dart';
import 'add_dive_page.dart';

class DiveListPage extends StatelessWidget {
  const DiveListPage({super.key});

  @override
  Widget build(BuildContext context) {
    var diveBox = Hive.box<Dive>(HiveBoxes.diveBox);

    return Scaffold(
      appBar: AppBar(title: const Text("My Dive Log")),
      body: ValueListenableBuilder(
        valueListenable: diveBox.listenable(),
        builder: (context, Box<Dive> box, _) {
          if (box.isEmpty) {
            return const Center(child: Text("No dives logged yet."));
          }

          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final dive = box.getAt(index)!;
              return DiveTile(dive: dive, index: index);
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
