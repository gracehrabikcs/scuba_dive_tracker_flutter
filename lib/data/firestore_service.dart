import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/dive.dart';

class FirestoreService {
  final CollectionReference divesRef =
  FirebaseFirestore.instance.collection('dives');

  Stream<List<Dive>> getDives() {
    return divesRef.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Dive.fromMap(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  Future<void> addDive(Dive dive) async {
    await divesRef.add(dive.toMap());
  }

  Future<void> deleteDive(String id) async {
    await divesRef.doc(id).delete();
  }

  Future<void> updateDive(Dive dive) async {
    await divesRef.doc(dive.id).update(dive.toMap());
  }

}
