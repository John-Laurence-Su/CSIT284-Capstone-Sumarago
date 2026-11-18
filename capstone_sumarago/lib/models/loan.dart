class Loan {
  const Loan({
    required this.id,
    required this.bookId,
    required this.memberId,
    required this.borrowedAt,
    required this.dueAt,
    this.returnedAt,
  });

  /// e.g. LN-0001
  final String id;
  final String bookId;

  /// e.g. M-1001 (typed in by the borrower, no account needed)
  final String memberId;
  final DateTime borrowedAt;
  final DateTime dueAt;
  final DateTime? returnedAt;

  bool get isActive => returnedAt == null;
  bool get isOverdue => isActive && DateTime.now().isAfter(dueAt);

  int get daysLeft {
    final today = DateTime.now();
    final a = DateTime(today.year, today.month, today.day);
    final b = DateTime(dueAt.year, dueAt.month, dueAt.day);
    return b.difference(a).inDays;
  }

  Loan copyWith({DateTime? returnedAt}) => Loan(
        id: id,
        bookId: bookId,
        memberId: memberId,
        borrowedAt: borrowedAt,
        dueAt: dueAt,
        returnedAt: returnedAt ?? this.returnedAt,
      );
}
