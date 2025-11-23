import 'package:flutter/material.dart';
import '../models/dive.dart';
import '../data/firestore_service.dart';

class EditDivePage extends StatefulWidget {
  final Dive dive;

  const EditDivePage({super.key, required this.dive});

  @override
  State<EditDivePage> createState() => _EditDivePageState();
}

class _EditDivePageState extends State<EditDivePage> {
  late TextEditingController locationController;
  late TextEditingController depthController;
  late TextEditingController dateController;

  final service = FirestoreService();

  @override
  void initState() {
    super.initState();
    print('Editing dive ID: ${widget.dive.id}'); // <- add this

    locationController = TextEditingController(text: widget.dive.location);
    depthController = TextEditingController(text: widget.dive.depth.toString());
    dateController = TextEditingController(text: widget.dive.date);
  }

  void saveDive() async {
    final updatedDive = Dive(
      id: widget.dive.id,
      location: locationController.text,
      depth: int.tryParse(depthController.text) ?? 0,
      date: dateController.text,
    );

    await service.updateDive(updatedDive); // new method for updating

    Navigator.pop(context);
  }

  void deleteDive() async {
    await service.deleteDive(widget.dive.id);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Dive"),
        backgroundColor: Colors.blue[800], // ocean-themed
      ),
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/underwater_background.jpg',
              fit: BoxFit.cover,
            ),
          ),
          // Soft overlay
          Container(
            color: Colors.black.withOpacity(0.3),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextField(
                  controller: locationController,
                  decoration: const InputDecoration(
                    labelText: "Location",
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                TextField(
                  controller: depthController,
                  decoration: const InputDecoration(
                    labelText: "Depth (ft)",
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                  style: const TextStyle(color: Colors.white),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: dateController,
                  decoration: const InputDecoration(
                    labelText: "Date",
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: saveDive,
                      child: const Text("Save Changes"),
                    ),
                    ElevatedButton(
                      onPressed: deleteDive,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: const Text("Delete"),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
