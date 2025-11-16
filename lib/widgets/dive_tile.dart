import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../data/hive_boxes.dart';
import '../models/dive.dart';

class DiveTile extends StatelessWidget {
  final Dive dive;
  final int index;

  const DiveTile({
    super.key,
    required this.dive,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(dive.location),
      subtitle: Text("Depth: ${dive.depth} ft — Date: ${dive.date}"),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          Hive.box<Dive>(HiveBoxes.diveBox).deleteAt(index);
        },
      ),
    );
  }
}
