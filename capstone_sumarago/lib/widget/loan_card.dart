import 'package:flutter/material.dart';

import 'package:capstone_sumarago/models/book.dart';
import 'package:capstone_sumarago/models/loan.dart';
import 'package:capstone_sumarago/utils/date_utils.dart';
import 'package:capstone_sumarago/widget/status_chip.dart';

class LoanCard extends StatelessWidget {
  const LoanCard({
    super.key,
    required this.loan,
    required this.book,
    required this.onTap,
    this.onReturn,
  });

  final Loan loan;
  final Book? book;
  final VoidCallback onTap;
  final VoidCallback? onReturn;

  @override
  Widget build(BuildContext context) {
    final StatusChip chip = !loan.isActive
        ? StatusChip.returned()
        : loan.isOverdue
            ? StatusChip.overdue()
            : StatusChip.borrowed();

    final String dateLine = loan.isActive
        ? 'Due ${formatDate(loan.dueAt)}'
            '${loan.isOverdue ? ' (${-loan.daysLeft} days late)' : ' (${loan.daysLeft} days left)'}'
        : 'Returned ${formatDate(loan.returnedAt!)}';

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      book?.title ?? loan.bookId,
                      style: Theme.of(context).textTheme.titleMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  chip,
                ],
              ),
              const SizedBox(height: 6),
              Text('${loan.id}  •  ${loan.bookId}  •  Member ${loan.memberId}'),
              const SizedBox(height: 2),
              Text(dateLine),
              if (onReturn != null)
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    onPressed: onReturn,
                    icon: const Icon(Icons.assignment_return_outlined),
                    label: const Text('Return'),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
