import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/dive.dart';
import '../data/hive_boxes.dart';

class AddDivePage extends StatefulWidget {
  const AddDivePage({super.key});

  @override
  State<AddDivePage> createState() => _AddDivePageState();
}

class _AddDivePageState extends State<AddDivePage> {
  final locationController = TextEditingController();
  final depthController = TextEditingController();
  final dateController = TextEditingController();

  void saveDive() {
    final dive = Dive(
      location: locationController.text,
      depth: int.tryParse(depthController.text) ?? 0,
      date: dateController.text,
    );

    Hive.box<Dive>(HiveBoxes.diveBox).add(dive);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add New Dive")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: locationController,
              decoration: const InputDecoration(labelText: "Location"),
            ),
            TextField(
              controller: depthController,
              decoration: const InputDecoration(labelText: "Depth (ft)"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: dateController,
              decoration: const InputDecoration(labelText: "Date"),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: saveDive,
              child: const Text("Save Dive"),
            ),
          ],
        ),
      ),
    );
  }
}
