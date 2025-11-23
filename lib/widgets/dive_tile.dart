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
    return ListTile(
      title: Text(dive.location),
      subtitle: Text("Depth: ${dive.depth} ft — Date: ${dive.date}"),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          FirestoreService().deleteDive(dive.id);
        },
      ),
    );
  }
}
