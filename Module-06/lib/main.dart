import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_config.dart';
import 'providers/notes_provider.dart';
import 'screens/notes_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Triggers structural initialization matrix checks
  await FirebaseConfig.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NotesProvider(),
      child: MaterialApp(
        title: 'Cloud Document Vault',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.amber),
        home: const NotesListScreen(),
      ),
    );
  }
}
