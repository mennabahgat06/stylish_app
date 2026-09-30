import 'package:flutter/material.dart';
import '../../../../core/widgets/empty_view.dart';
import '../../data/models/order_model.dart';
import 'order_tile.dart';

/// List of orders, or an empty message.
class OrdersList extends StatelessWidget {
  final List<OrderModel> orders;
  final String emptyMessage;
  final ValueChanged<OrderModel>? onCancel;

  const OrdersList({
    super.key,
    required this.orders,
    required this.emptyMessage,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    if (orders.isEmpty) {
      return EmptyView(icon: Icons.receipt_long_outlined, message: emptyMessage);
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: orders.length,
      itemBuilder: (_, index) => OrderTile(
        order: orders[index],
        onCancel: onCancel == null ? null : () => onCancel!(orders[index]),
      ),
    );
  }
}
