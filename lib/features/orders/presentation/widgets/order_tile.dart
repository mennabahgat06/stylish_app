import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/price_formatter.dart';
import '../../../../core/widgets/app_network_image.dart';
import '../../data/models/order_model.dart';

/// One order: image, title, status / date, total and an optional cancel link.
class OrderTile extends StatelessWidget {
  final OrderModel order;
  final VoidCallback? onCancel;

  const OrderTile({super.key, required this.order, this.onCancel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.inputBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          AppNetworkImage(url: order.imageUrl, width: 60, height: 60, radius: 8),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(order.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(
                  order.date.isEmpty ? order.status : '${order.status} · ${order.date}',
                  style: const TextStyle(color: Colors.grey, fontSize: 11),
                ),
                if (onCancel != null)
                  GestureDetector(
                    onTap: onCancel,
                    child: const Padding(
                      padding: EdgeInsets.only(top: 6),
                      child: Text('Cancel order',
                          style: TextStyle(
                              color: AppColors.primaryPink,
                              fontSize: 12,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
              ],
            ),
          ),
          Text(PriceFormatter.format(order.total),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        ],
      ),
    );
  }
}
