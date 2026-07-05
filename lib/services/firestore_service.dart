import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/note.dart';

/// Centralizes all Cloud Firestore CRUD operations for Notes.
/// Keeping this logic in one place makes the UI code simple and testable.
class FirestoreService {
  final CollectionReference _notesCollection =
      FirebaseFirestore.instance.collection('notes');

  /// CREATE — Adds a new note document to Firestore.
  Future<void> addNote(String title, String description) async {
    final note = Note(title: title, description: description);
    await _notesCollection.add(note.toMap());
  }

  /// READ — Streams all notes in real time, most recently created first.
  Stream<List<Note>> getNotes() {
    return _notesCollection
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Note.fromDocument(doc)).toList());
  }

  /// UPDATE — Overwrites the title/description of an existing note.
  Future<void> updateNote(String id, String title, String description) async {
    await _notesCollection.doc(id).update({
      'title': title,
      'description': description,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  /// DELETE — Removes a note document by its ID.
  Future<void> deleteNote(String id) async {
    await _notesCollection.doc(id).delete();
  }
}
