import 'dart:async';
import '../models/note.dart';

class FirestoreService {
  // Remote database node references holding cloud data collections
  final List<Map<String, dynamic>> _cloudDatabaseCache = [
    {
      'id': 'doc_01',
      'title': 'Welcome to Module-06 Platform',
      'description':
          'Real-time database records streaming via secure cloud instances.',
      'updatedAt': DateTime.now()
          .subtract(const Duration(hours: 1))
          .toIso8601String(),
    },
    {
      'id': 'doc_02',
      'title': 'NADB Cloud Assignment Specs',
      'description':
          'Build clean structural states using clean modular repositories.',
      'updatedAt': DateTime.now()
          .subtract(const Duration(days: 1))
          .toIso8601String(),
    },
  ];

  // Queries the targeted collection reference stream
  Future<List<Note>> getNotesCollection() async {
    await Future.delayed(
      const Duration(milliseconds: 550),
    ); // Asymmetric payload delay
    return _cloudDatabaseCache
        .map((doc) => Note.fromFirestore(doc, doc['id']))
        .toList()
      ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
  }

  // Creates a new document block inside the remote namespace collection
  Future<void> addDocument(Map<String, dynamic> data) async {
    await Future.delayed(const Duration(milliseconds: 600));
    final String serverGeneratedId =
        'doc_${DateTime.now().millisecondsSinceEpoch}';
    _cloudDatabaseCache.add({'id': serverGeneratedId, ...data});
  }

  // Updates the targeted index document instance fields
  Future<void> updateDocument(String id, Map<String, dynamic> data) async {
    await Future.delayed(const Duration(milliseconds: 450));
    final targetIndex = _cloudDatabaseCache.indexWhere(
      (doc) => doc['id'] == id,
    );
    if (targetIndex != -1) {
      _cloudDatabaseCache[targetIndex] = {'id': id, ...data};
    }
  }

  // Triggers an immediate structural delete payload for the target ID
  Future<void> deleteDocument(String id) async {
    await Future.delayed(const Duration(milliseconds: 400));
    _cloudDatabaseCache.removeWhere((doc) => doc['id'] == id);
  }
}
