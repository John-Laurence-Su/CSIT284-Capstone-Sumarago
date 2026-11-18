import 'package:flutter/material.dart';

import 'package:capstone_sumarago/services/library_scope.dart';
import 'package:capstone_sumarago/services/library_service.dart';
import 'package:capstone_sumarago/widget/book_card.dart';
import 'book_detail_screen.dart';

class BookListScreen extends StatefulWidget {
  const BookListScreen({super.key});

  @override
  State<BookListScreen> createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  final _searchController = TextEditingController();
  String _query = '';
  AvailabilityFilter _filter = AvailabilityFilter.all;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final service = LibraryScope.of(context);
    final books = service.searchBooks(_query, filter: _filter);

    return Scaffold(
      appBar: AppBar(title: const Text('Books')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
            child: SearchBar(
              controller: _searchController,
              hintText: 'Search title, author, genre or ID',
              leading: const Icon(Icons.search),
              trailing: [
                if (_query.isNotEmpty)
                  IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                      setState(() => _query = '');
                    },
                  ),
              ],
              onChanged: (v) => setState(() => _query = v),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: SizedBox(
              width: double.infinity,
              child: SegmentedButton<AvailabilityFilter>(
                showSelectedIcon: false,
                segments: const [
                  ButtonSegment(
                      value: AvailabilityFilter.all, label: Text('All')),
                  ButtonSegment(
                      value: AvailabilityFilter.available,
                      label: Text('Available')),
                  ButtonSegment(
                      value: AvailabilityFilter.borrowed,
                      label: Text('Borrowed')),
                ],
                selected: {_filter},
                onSelectionChanged: (s) => setState(() => _filter = s.first),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '${books.length} book${books.length == 1 ? '' : 's'}',
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
          ),
          Expanded(
            child: books.isEmpty
                ? const Center(child: Text('No books found'))
                : ListView.builder(
                    padding: const EdgeInsets.only(bottom: 12),
                    itemCount: books.length,
                    itemBuilder: (context, i) {
                      final book = books[i];
                      return BookCard(
                        book: book,
                        available: service.isAvailable(book.id),
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => BookDetailScreen(bookId: book.id),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
