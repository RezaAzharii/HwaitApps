import 'package:flutter/material.dart';
import 'package:hwait_apps/core/core.dart';

class ProgressSection extends StatelessWidget {
  final double current;
  final double targetAmount;

  const ProgressSection({
    required this.current,
    required this.targetAmount,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final double percent = (current / (targetAmount == 0 ? 1 : targetAmount))
        .clamp(0.0, 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Progress Tabungan',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: percent,
          minHeight: 10,
          backgroundColor: Colors.grey[300],
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
        ),
        const SizedBox(height: 8),
        Text(
          '${formatCurrency(current.toInt())} dari ${formatCurrency(targetAmount.toInt())}',
          style: TextStyle(color: Colors.grey[700], fontSize: 14),
        ),
      ],
    );
  }
}
