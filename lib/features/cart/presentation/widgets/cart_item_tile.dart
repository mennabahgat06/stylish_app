import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/price_formatter.dart';
import '../../../../core/widgets/app_network_image.dart';
import '../../data/models/cart_item_model.dart';

/// One cart line: image, name, price, quantity and a delete button.
class CartItemTile extends StatelessWidget {
  final CartItemModel item;
  final VoidCallback? onRemove;

  const CartItemTile({super.key, required this.item, this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.inputBackground,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          AppNetworkImage(url: item.imageUrl, width: 50, height: 50, radius: 8),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                Text(PriceFormatter.format(item.price),
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              ],
            ),
          ),
          Text('x${item.quantity}', style: const TextStyle(fontWeight: FontWeight.bold)),
          if (onRemove != null)
            IconButton(
              icon: const Icon(Icons.delete_outline, color: AppColors.primaryPink),
              onPressed: onRemove,
            ),
        ],
      ),
    );
  }
}
