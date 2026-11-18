import 'package:flutter/foundation.dart';

import 'package:capstone_sumarago/data/dummy_data.dart';
import 'package:capstone_sumarago/models/book.dart';
import 'package:capstone_sumarago/models/loan.dart';

enum AvailabilityFilter { all, available, borrowed }

enum LoanFilter { active, returned, all }

/// Holds all books and loans in memory and exposes the app's logic.
/// Notifies listeners whenever something changes.
class LibraryService extends ChangeNotifier {
  LibraryService({
    required List<Book> books,
    List<Loan> loans = const [],
  })  : _books = List.of(books),
        _loans = List.of(loans),
        _loanCounter = loans.length;

  factory LibraryService.seeded() =>
      LibraryService(books: sampleBooks, loans: buildSampleLoans());

  final List<Book> _books;
  final List<Loan> _loans;
  int _loanCounter;

  /// Remembered so the borrow dialog can prefill it.
  String lastMemberId = '';

  List<Book> get books => List.unmodifiable(_books);
  List<Loan> get loans => List.unmodifiable(_loans);

  Book? bookById(String id) {
    for (final b in _books) {
      if (b.id == id) return b;
    }
    return null;
  }

  Loan? activeLoanFor(String bookId) {
    for (final l in _loans) {
      if (l.bookId == bookId && l.isActive) return l;
    }
    return null;
  }

  bool isAvailable(String bookId) => activeLoanFor(bookId) == null;

  List<Loan> loansForBook(String bookId) =>
      _loans.where((l) => l.bookId == bookId).toList().reversed.toList();

  /// Search by title, author, genre, book ID or ISBN.
  List<Book> searchBooks(
    String query, {
    AvailabilityFilter filter = AvailabilityFilter.all,
  }) {
    final q = query.trim().toLowerCase();
    return _books.where((b) {
      final matchesQuery = q.isEmpty ||
          b.title.toLowerCase().contains(q) ||
          b.author.toLowerCase().contains(q) ||
          b.genre.toLowerCase().contains(q) ||
          b.id.toLowerCase().contains(q) ||
          (b.isbn ?? '').contains(q);
      if (!matchesQuery) return false;
      switch (filter) {
        case AvailabilityFilter.all:
          return true;
        case AvailabilityFilter.available:
          return isAvailable(b.id);
        case AvailabilityFilter.borrowed:
          return !isAvailable(b.id);
      }
    }).toList();
  }

  /// Search loans by loan ID, member ID, book ID or book title.
  List<Loan> searchLoans(
    String query, {
    LoanFilter filter = LoanFilter.active,
  }) {
    final q = query.trim().toLowerCase();
    final result = _loans.where((l) {
      if (filter == LoanFilter.active && !l.isActive) return false;
      if (filter == LoanFilter.returned && l.isActive) return false;
      if (q.isEmpty) return true;
      final title = bookById(l.bookId)?.title.toLowerCase() ?? '';
      return l.id.toLowerCase().contains(q) ||
          l.memberId.toLowerCase().contains(q) ||
          l.bookId.toLowerCase().contains(q) ||
          title.contains(q);
    }).toList();
    // Newest first.
    return result.reversed.toList();
  }

  Loan borrow({
    required String bookId,
    required String memberId,
    int days = 14,
  }) {
    if (!isAvailable(bookId)) {
      throw StateError('Book $bookId is already borrowed.');
    }
    final now = DateTime.now();
    _loanCounter++;
    final loan = Loan(
      id: 'LN-${_loanCounter.toString().padLeft(4, '0')}',
      bookId: bookId,
      memberId: memberId.trim().toUpperCase(),
      borrowedAt: now,
      dueAt: now.add(Duration(days: days)),
    );
    _loans.add(loan);
    lastMemberId = loan.memberId;
    notifyListeners();
    return loan;
  }

  void returnBook(String loanId) {
    final i = _loans.indexWhere((l) => l.id == loanId);
    if (i == -1 || !_loans[i].isActive) return;
    _loans[i] = _loans[i].copyWith(returnedAt: DateTime.now());
    notifyListeners();
  }
}
