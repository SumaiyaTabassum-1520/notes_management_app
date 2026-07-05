import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/note.dart';

class FirestoreService {
  final CollectionReference _notesCollection =
      FirebaseFirestore.instance.collection('notes');

  Future<void> addNote(String title, String description) async {
    final note = Note(title: title, description: description);
    await _notesCollection.add(note.toMap());
  }

  Stream<List<Note>> getNotes() {
    return _notesCollection
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Note.fromDocument(doc)).toList());
  }

  Future<void> updateNote(String id, String title, String description) async {
    await _notesCollection.doc(id).update({
      'title': title,
      'description': description,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> deleteNote(String id) async {
    await _notesCollection.doc(id).delete();
  }
}
