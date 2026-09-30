import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';

/// "Label ........ amount"
class PriceRow extends StatelessWidget {
  final String label;
  final String amount;
  final bool isTotal;

  const PriceRow({super.key, required this.label, required this.amount, this.isTotal = false});

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
      fontSize: isTotal ? 16 : 13,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: style),
          Text(amount,
              style: style.copyWith(color: isTotal ? AppColors.primaryPink : Colors.black)),
        ],
      ),
    );
  }
}
