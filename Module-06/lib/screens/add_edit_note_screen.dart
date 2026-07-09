import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/note.dart';
import '../providers/notes_provider.dart';

class AddEditNoteScreen extends StatefulWidget {
  final Note? note;
  const AddEditNoteScreen({super.key, this.note});

  @override
  State<AddEditNoteScreen> createState() => _AddEditNoteScreenState();
}

class _AddEditNoteScreenState extends State<AddEditNoteScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descController;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note?.title ?? '');
    _descController = TextEditingController(
      text: widget.note?.description ?? '',
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Future<void> _saveForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);
    final provider = Provider.of<NotesProvider>(context, listen: false);

    if (widget.note == null) {
      await provider.createNote(
        _titleController.text.trim(),
        _descController.text.trim(),
      );
    } else {
      await provider.updateNote(
        widget.note!.id,
        _titleController.text.trim(),
        _descController.text.trim(),
      );
    }

    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.note != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Modify Document' : 'New Cloud Document'),
      ),
      body: _isSaving
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        labelText: 'Document Title',
                        border: OutlineInputBorder(),
                      ),
                      validator: (v) =>
                          v!.isEmpty ? 'Title string field required' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _descController,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        labelText: 'Body Text Description',
                        border: OutlineInputBorder(),
                      ),
                      validator: (v) =>
                          v!.isEmpty ? 'Description content required' : null,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _saveForm,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text(
                        isEdit
                            ? 'Commit Document Updates'
                            : 'Publish to Collection Snapshot',
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
