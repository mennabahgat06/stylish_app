import 'package:flutter/material.dart';
import '../../../../core/utils/price_formatter.dart';
import '../../data/models/cart_model.dart';
import 'price_row.dart';

/// Subtotal, tax, delivery and total.
class CartSummary extends StatelessWidget {
  final CartModel cart;

  const CartSummary({super.key, required this.cart});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        PriceRow(label: 'Subtotal', amount: PriceFormatter.format(cart.subtotal)),
        if (cart.tax > 0) PriceRow(label: 'Tax and Fees', amount: PriceFormatter.format(cart.tax)),
        if (cart.delivery > 0)
          PriceRow(label: 'Delivery Fee', amount: PriceFormatter.format(cart.delivery)),
        const Divider(),
        PriceRow(label: 'Order Total', amount: PriceFormatter.format(cart.total), isTotal: true),
      ],
    );
  }
}
