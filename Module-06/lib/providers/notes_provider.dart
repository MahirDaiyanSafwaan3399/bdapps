import 'package:flutter/material.dart';
import '../models/note.dart';
import '../services/firestore_service.dart';

class NotesProvider extends ChangeNotifier {
  final FirestoreService _databaseService = FirestoreService();
  List<Note> _notes = [];
  bool _isLoading = false;

  List<Note> get notes => _notes;
  bool get isLoading => _isLoading;

  Future<void> fetchNotes() async {
    _isLoading = true;
    notifyListeners();
    try {
      _notes = await _databaseService.getNotesCollection();
    } catch (e) {
      debugPrint("Cloud synchronization error context: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createNote(String title, String description) async {
    final freshNode = Note(
      id: '',
      title: title,
      description: description,
      updatedAt: DateTime.now(),
    );
    await _databaseService.addDocument(freshNode.toFirestore());
    await fetchNotes();
  }

  Future<void> updateNote(String id, String title, String description) async {
    final modifiedNode = Note(
      id: id,
      title: title,
      description: description,
      updatedAt: DateTime.now(),
    );
    await _databaseService.updateDocument(id, modifiedNode.toFirestore());
    await fetchNotes();
  }

  Future<void> deleteNote(String id) async {
    await _databaseService.deleteDocument(id);
    await fetchNotes();
  }
}
