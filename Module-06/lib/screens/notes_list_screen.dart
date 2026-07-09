import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/notes_provider.dart';
import 'add_edit_note_screen.dart';

class NotesListScreen extends StatefulWidget {
  const NotesListScreen({super.key});

  @override
  State<NotesListScreen> createState() => _NotesListScreenState();
}

class _NotesListScreenState extends State<NotesListScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<NotesProvider>().fetchNotes());
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NotesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('🔥 Firestore Notebook'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : provider.notes.isEmpty
          ? const Center(
              child: Text('No active collection documents detected.'),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: provider.notes.length,
              itemBuilder: (context, index) {
                final note = provider.notes[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  elevation: 2,
                  child: ListTile(
                    title: Text(
                      note.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      note.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AddEditNoteScreen(note: note),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => provider.deleteNote(note.id),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AddEditNoteScreen()),
        ),
      ),
    );
  }
}
