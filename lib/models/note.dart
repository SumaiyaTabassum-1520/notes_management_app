import 'package:cloud_firestore/cloud_firestore.dart';

/// Represents a single Note stored in the "notes" Firestore collection.
class Note {
  final String? id; // Firestore document ID (null for a note not yet saved)
  final String title;
  final String description;
  final Timestamp? createdAt;
  final Timestamp? updatedAt;

  Note({
    this.id,
    required this.title,
    required this.description,
    this.createdAt,
    this.updatedAt,
  });

  /// Converts this Note into a Map that can be written to Firestore.
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }

  /// Builds a Note from a Firestore document snapshot.
  factory Note.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Note(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      createdAt: data['createdAt'] as Timestamp?,
      updatedAt: data['updatedAt'] as Timestamp?,
    );
  }
}
