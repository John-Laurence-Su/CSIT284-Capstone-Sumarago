import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'services/library_scope.dart';
import 'services/library_service.dart';

class BookTrackerApp extends StatefulWidget {
  const BookTrackerApp({super.key});

  @override
  State<BookTrackerApp> createState() => _BookTrackerAppState();
}

class _BookTrackerAppState extends State<BookTrackerApp> {
  late final LibraryService _service = LibraryService.seeded();

  @override
  void dispose() {
    _service.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LibraryScope(
      service: _service,
      child: MaterialApp(
        title: 'Book Borrowing Tracker',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorSchemeSeed: Colors.indigo,
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
