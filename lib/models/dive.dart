class Dive {
  final String id;        // Firestore document ID
  final String location;
  final int depth;
  final String date;

  Dive({
    required this.id,
    required this.location,
    required this.depth,
    required this.date,
  });

  // Create a Dive from Firestore document
  factory Dive.fromMap(String id, Map<String, dynamic> data) {
    return Dive(
      id: id,
      location: data['location'] ?? '',
      depth: data['depth'] ?? 0,
      date: data['date'] ?? '',
    );
  }

  // Convert Dive to Firestore map
  Map<String, dynamic> toMap() {
    return {
      'location': location,
      'depth': depth,
      'date': date,
    };
  }
}
