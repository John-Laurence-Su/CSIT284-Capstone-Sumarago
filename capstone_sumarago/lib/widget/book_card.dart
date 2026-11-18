import 'package:flutter/material.dart';

import '../models/book.dart';
import 'status_chip.dart';

class BookCard extends StatelessWidget {
  const BookCard({
    super.key,
    required this.book,
    required this.available,
    required this.onTap,
  });

  final Book book;
  final bool available;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: scheme.primaryContainer,
          child: Icon(Icons.menu_book, color: scheme.onPrimaryContainer),
        ),
        title: Text(book.title, maxLines: 1, overflow: TextOverflow.ellipsis),
        subtitle: Text(
          '${book.author}\n${book.id}  •  ${book.genre}',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        isThreeLine: true,
        trailing: available ? StatusChip.available() : StatusChip.borrowed(),
      ),
    );
  }
}
