import 'package:flutter/material.dart';

/// Asks for a member ID (no login needed). Returns the ID, or null if cancelled.
Future<String?> showBorrowDialog(
  BuildContext context, {
  required String bookTitle,
  String initialMemberId = '',
}) {
  return showDialog<String>(
    context: context,
    builder: (_) => _BorrowDialog(
      bookTitle: bookTitle,
      initialMemberId: initialMemberId,
    ),
  );
}

class _BorrowDialog extends StatefulWidget {
  const _BorrowDialog({
    required this.bookTitle,
    required this.initialMemberId,
  });

  final String bookTitle;
  final String initialMemberId;

  @override
  State<_BorrowDialog> createState() => _BorrowDialogState();
}

class _BorrowDialogState extends State<_BorrowDialog> {
  late final TextEditingController _controller =
      TextEditingController(text: widget.initialMemberId);
  String? _error;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final id = _controller.text.trim();
    if (id.isEmpty) {
      setState(() => _error = 'Enter a member ID');
      return;
    }
    Navigator.of(context).pop(id);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Borrow book'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.bookTitle,
              style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          TextField(
            controller: _controller,
            autofocus: true,
            textCapitalization: TextCapitalization.characters,
            decoration: InputDecoration(
              labelText: 'Member ID',
              hintText: 'e.g. M-1001',
              border: const OutlineInputBorder(),
              errorText: _error,
            ),
            onSubmitted: (_) => _submit(),
          ),
          const SizedBox(height: 8),
          const Text('Loan period: 14 days',
              style: TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(onPressed: _submit, child: const Text('Borrow')),
      ],
    );
  }
}
