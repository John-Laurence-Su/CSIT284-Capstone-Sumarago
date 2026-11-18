import 'package:flutter/material.dart';

import 'package:capstone_sumarago/services/library_scope.dart';
import 'package:capstone_sumarago/services/library_service.dart';
import 'package:capstone_sumarago/widget/loan_card.dart';
import 'book_detail_screen.dart';

class LoansScreen extends StatefulWidget {
  const LoansScreen({super.key});

  @override
  State<LoansScreen> createState() => _LoansScreenState();
}

class _LoansScreenState extends State<LoansScreen> {
  final _searchController = TextEditingController();
  String _query = '';
  LoanFilter _filter = LoanFilter.active;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final service = LibraryScope.of(context);
    final loans = service.searchLoans(_query, filter: _filter);

    return Scaffold(
      appBar: AppBar(title: const Text('Loans')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
            child: SearchBar(
              controller: _searchController,
              hintText: 'Search member ID, loan ID or book',
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
              child: SegmentedButton<LoanFilter>(
                showSelectedIcon: false,
                segments: const [
                  ButtonSegment(value: LoanFilter.active, label: Text('Active')),
                  ButtonSegment(
                      value: LoanFilter.returned, label: Text('Returned')),
                  ButtonSegment(value: LoanFilter.all, label: Text('All')),
                ],
                selected: {_filter},
                onSelectionChanged: (s) => setState(() => _filter = s.first),
              ),
            ),
          ),
          Expanded(
            child: loans.isEmpty
                ? const Center(child: Text('No loans found'))
                : ListView.builder(
                    padding: const EdgeInsets.only(bottom: 12),
                    itemCount: loans.length,
                    itemBuilder: (context, i) {
                      final loan = loans[i];
                      return LoanCard(
                        loan: loan,
                        book: service.bookById(loan.bookId),
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) =>
                                BookDetailScreen(bookId: loan.bookId),
                          ),
                        ),
                        onReturn: loan.isActive
                            ? () => service.returnBook(loan.id)
                            : null,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
