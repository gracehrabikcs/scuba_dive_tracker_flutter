import 'package:flutter/material.dart';
import '../data/firestore_service.dart';
import '../models/dive.dart';
import '../widgets/dive_tile.dart';
import 'add_dive_page.dart';

enum SortOption { date, depth }

class DiveListPage extends StatefulWidget {
  const DiveListPage({super.key});

  @override
  State<DiveListPage> createState() => _DiveListPageState();
}

class _DiveListPageState extends State<DiveListPage> {
  final FirestoreService service = FirestoreService();
  SortOption _sortOption = SortOption.date;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[800], // ocean blue color
        elevation: 4, // keep a small shadow for depth
        leading: PopupMenuButton<SortOption>(
          icon: const Icon(Icons.sort, color: Colors.white), // white menu icon
          onSelected: (option) {
            setState(() {
              _sortOption = option;
            });
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: SortOption.date,
              child: Text("Sort by Date"),
            ),
            const PopupMenuItem(
              value: SortOption.depth,
              child: Text("Sort by Depth"),
            ),
          ],
        ),
        title: const Text(
          "My Dive Log",
          style: TextStyle(color: Colors.white), // white title text
        ),
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
          // Semi-transparent overlay
          Positioned.fill(
            child: Container(
              color: Colors.blue.shade900.withOpacity(0.3),
            ),
          ),
          // Dive list content
          StreamBuilder<List<Dive>>(
            stream: service.getDives(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              List<Dive> dives = snapshot.data!;

              if (dives.isEmpty) {
                return const Center(
                  child: Text(
                    "No dives logged yet.",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                );
              }

              // Sort the dives based on the selected option
              dives.sort((a, b) {
                if (_sortOption == SortOption.date) {
                  return a.date.compareTo(b.date);
                } else {
                  return b.depth.compareTo(a.depth); // descending depth
                }
              });

              return ListView.builder(
                itemCount: dives.length,
                itemBuilder: (context, index) {
                  return DiveTile(dive: dives[index]);
                },
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal.shade400, // Matching ocean theme
        foregroundColor: Colors.white,          // white plus sign
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
