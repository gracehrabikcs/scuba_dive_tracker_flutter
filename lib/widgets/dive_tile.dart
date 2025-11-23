import 'package:flutter/material.dart';
import '../models/dive.dart';
import '../data/firestore_service.dart';

class DiveTile extends StatelessWidget {
  final Dive dive;

  const DiveTile({
    super.key,
    required this.dive,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent, // Makes the card background see-through
      elevation: 0,
      child: ListTile(
        title: Text(
          dive.location,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          "Depth: ${dive.depth} ft — Date: ${dive.date}",
          style: const TextStyle(color: Colors.white70),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.white),
          onPressed: () {
            FirestoreService().deleteDive(dive.id);
          },
        ),
      ),
    );
  }
}
