import 'package:flutter/material.dart';

import 'package:capstone_sumarago/services/library_scope.dart';
import 'package:capstone_sumarago/utils/date_utils.dart';
import 'package:capstone_sumarago/widget/borrow_dialog.dart';
import 'package:capstone_sumarago/widget/status_chip.dart';

class BookDetailScreen extends StatelessWidget {
  const BookDetailScreen({super.key, required this.bookId});

  final String bookId;

  @override
  Widget build(BuildContext context) {
    final service = LibraryScope.of(context);
    final book = service.bookById(bookId);
    if (book == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text('Book not found')),
      );
    }

    final activeLoan = service.activeLoanFor(bookId);
    final history = service.loansForBook(bookId);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: Text(book.id)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(book.title, style: textTheme.headlineSmall),
          const SizedBox(height: 4),
          Text(book.author, style: textTheme.titleMedium),
          const SizedBox(height: 12),
          Row(
            children: [
              activeLoan == null
                  ? StatusChip.available()
                  : (activeLoan.isOverdue
                      ? StatusChip.overdue()
                      : StatusChip.borrowed()),
            ],
          ),
          const SizedBox(height: 16),
          _InfoRow(label: 'Book ID', value: book.id),
          _InfoRow(label: 'Genre', value: book.genre),
          _InfoRow(label: 'Year', value: '${book.year}'),
          if (book.isbn != null) _InfoRow(label: 'ISBN', value: book.isbn!),
          if (book.description.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(book.description),
          ],
          const SizedBox(height: 20),
          if (activeLoan == null)
            FilledButton.icon(
              icon: const Icon(Icons.bookmark_add_outlined),
              label: const Text('Borrow this book'),
              onPressed: () async {
                final memberId = await showBorrowDialog(
                  context,
                  bookTitle: book.title,
                  initialMemberId: service.lastMemberId,
                );
                if (memberId == null) return;
                final loan =
                    service.borrow(bookId: book.id, memberId: memberId);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          'Borrowed (${loan.id}). Due ${formatDate(loan.dueAt)}'),
                    ),
                  );
                }
              },
            )
          else ...[
            Card(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Currently borrowed', style: textTheme.titleSmall),
                    const SizedBox(height: 6),
                    Text('Loan ${activeLoan.id}  •  Member ${activeLoan.memberId}'),
                    Text('Borrowed ${formatDate(activeLoan.borrowedAt)}'),
                    Text('Due ${formatDate(activeLoan.dueAt)}'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            FilledButton.tonalIcon(
              icon: const Icon(Icons.assignment_return_outlined),
              label: const Text('Mark as returned'),
              onPressed: () {
                service.returnBook(activeLoan.id);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Book returned')),
                );
              },
            ),
          ],
          if (history.isNotEmpty) ...[
            const SizedBox(height: 24),
            Text('Borrow history', style: textTheme.titleMedium),
            const SizedBox(height: 4),
            for (final l in history)
              ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.history),
                title: Text('${l.id}  •  Member ${l.memberId}'),
                subtitle: Text(
                  '${formatDate(l.borrowedAt)} → '
                  '${l.returnedAt != null ? formatDate(l.returnedAt!) : 'not returned'}',
                ),
              ),
          ],
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(label,
                style: const TextStyle(fontWeight: FontWeight.w600)),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
