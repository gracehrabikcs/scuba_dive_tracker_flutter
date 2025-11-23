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
  final Color cursorColor = Colors.cyanAccent;

  @override
  void initState() {
    super.initState();
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

    await service.updateDive(updatedDive);
    Navigator.pop(context);
  }

  void deleteDive() async {
    await service.deleteDive(widget.dive.id);
    Navigator.pop(context);
  }

  InputDecoration fieldDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: cursorColor),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: cursorColor, width: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Dive",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue[800], // ocean-themed
        iconTheme: const IconThemeData(color: Colors.white), // back button white
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
                  cursorColor: cursorColor,
                  style: const TextStyle(color: Colors.white),
                  decoration: fieldDecoration("Location"),
                ),
                TextField(
                  controller: depthController,
                  keyboardType: TextInputType.number,
                  cursorColor: cursorColor,
                  style: const TextStyle(color: Colors.white),
                  decoration: fieldDecoration("Depth (ft)"),
                ),
                TextField(
                  controller: dateController,
                  cursorColor: cursorColor,
                  style: const TextStyle(color: Colors.white),
                  decoration: fieldDecoration("Date"),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: saveDive,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal.shade400, // ocean theme
                        foregroundColor: Colors.white, // text color
                      ),
                      child: const Text("Save Changes"),
                    ),
                    ElevatedButton(
                      onPressed: deleteDive,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade300, // ocean-themed delete
                        foregroundColor: Colors.white, // text color
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
