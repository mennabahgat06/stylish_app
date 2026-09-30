import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';

/// (-)  2  (+)
class QuantitySelector extends StatelessWidget {
  final int quantity;
  final ValueChanged<int> onChanged;

  const QuantitySelector({super.key, required this.quantity, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.remove_circle, color: AppColors.primaryPink),
          onPressed: quantity > 1 ? () => onChanged(quantity - 1) : null,
        ),
        Text('$quantity', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        IconButton(
          icon: const Icon(Icons.add_circle, color: AppColors.primaryPink),
          onPressed: () => onChanged(quantity + 1),
        ),
      ],
    );
  }
}
