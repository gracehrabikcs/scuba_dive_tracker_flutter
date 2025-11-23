import 'package:flutter/material.dart';
import '../models/dive.dart';
import '../data/firestore_service.dart';

class AddDivePage extends StatefulWidget {
  const AddDivePage({super.key});

  @override
  State<AddDivePage> createState() => _AddDivePageState();
}

class _AddDivePageState extends State<AddDivePage> {
  final locationController = TextEditingController();
  final depthController = TextEditingController();
  final dateController = TextEditingController();

  final service = FirestoreService();

  void saveDive() async {
    final dive = Dive(
      id: '', // Firestore will assign automatically
      location: locationController.text,
      depth: int.tryParse(depthController.text) ?? 0,
      date: dateController.text,
    );

    await service.addDive(dive);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    const cursorColor = Colors.cyanAccent;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add New Dive",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue[800], // ocean blue
        iconTheme: const IconThemeData(color: Colors.white), // makes back button white
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/underwater_background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                controller: locationController,
                cursorColor: cursorColor,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: "Location",
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: cursorColor),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: cursorColor, width: 2),
                  ),
                ),
              ),
              TextField(
                controller: depthController,
                keyboardType: TextInputType.number,
                cursorColor: cursorColor,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: "Depth (ft)",
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: cursorColor),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: cursorColor, width: 2),
                  ),
                ),
              ),
              TextField(
                controller: dateController,
                cursorColor: cursorColor,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: "Date",
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: cursorColor),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: cursorColor, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyan[700], // ocean-themed button
                  foregroundColor: Colors.white,
                ),
                onPressed: saveDive,
                child: const Text("Save Dive"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
