import 'package:flutter/material.dart';

class StatusChip extends StatelessWidget {
  const StatusChip({super.key, required this.label, required this.color});

  final String label;
  final Color color;

  factory StatusChip.available() =>
      const StatusChip(label: 'Available', color: Colors.green);
  factory StatusChip.borrowed() =>
      const StatusChip(label: 'Borrowed', color: Colors.orange);
  factory StatusChip.overdue() =>
      const StatusChip(label: 'Overdue', color: Colors.red);
  factory StatusChip.returned() =>
      const StatusChip(label: 'Returned', color: Colors.blueGrey);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
