class Note {
  final String id;
  final String title;
  final String description;
  final DateTime updatedAt;

  Note({
    required this.id,
    required this.title,
    required this.description,
    required this.updatedAt,
  });

  // Maps incoming Firestore DocumentSnapshots to local runtime instances
  factory Note.fromFirestore(Map<String, dynamic> data, String documentId) {
    return Note(
      id: documentId,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      updatedAt: DateTime.parse(
        data['updatedAt'] ?? DateTime.now().toIso8601String(),
      ),
    );
  }

  // Packs runtime objects into dynamic payloads for collection updates
  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'description': description,
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
