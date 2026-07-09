import 'package:flutter/material.dart';
import '../models/subject.dart';

class TrackerProvider extends ChangeNotifier {
  final List<Subject> _subjects = [];
  bool _isDarkMode = false;

  List<Subject> get subjects => List.unmodifiable(_subjects);
  bool get isDarkMode => _isDarkMode;

  // Requirement: Using .where() to filter passing subjects (Grade C or better / mark >= 50)
  List<Subject> get passingSubjects =>
      _subjects.where((subject) => subject.mark >= 50).toList();

  void addSubject(String name, double mark) {
    _subjects.add(Subject(name: name, mark: mark));
    notifyListeners();
  }

  void removeSubject(int index) {
    _subjects.removeAt(index);
    notifyListeners();
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  // Summary Calculations
  int get totalSubjects => _subjects.length;

  double get averageMark {
    if (_subjects.isEmpty) return 0.0;
    double total = _subjects.fold(0, (sum, item) => sum + item.mark);
    return total / _subjects.length;
  }

  String get overallGrade {
    double avg = averageMark;
    if (_subjects.isEmpty) return 'N/A';
    if (avg >= 80) return 'A';
    if (avg >= 65) return 'B';
    if (avg >= 50) return 'C';
    return 'F';
  }
}
