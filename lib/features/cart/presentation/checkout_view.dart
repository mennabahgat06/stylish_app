import 'package:flutter/material.dart';
import '../../../core/utils/app_snack_bar.dart';
import '../../../core/utils/price_formatter.dart';
import '../../../core/widgets/back_app_bar.dart';
import '../../../core/widgets/custom_button.dart';
import '../../orders/data/services/order_service.dart';
import '../data/models/cart_model.dart';
import '../data/services/cart_service.dart';
import 'widgets/cart_summary.dart';

/// POST place_order with the cart items, then empties the cart.
/// Returns true to the cart screen when the order is placed.
class CheckoutView extends StatefulWidget {
  final CartModel cart;

  const CheckoutView({super.key, required this.cart});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  final OrderService _orderService = OrderService();
  final CartService _cartService = CartService();
  bool _isLoading = false;

  Future<void> _placeOrder() async {
    setState(() => _isLoading = true);
    try {
      await _orderService.placeOrder(widget.cart.items);
      await _cartService.clear();
      if (!mounted) return;
      AppSnackBar.show(context, 'Order Placed Successfully!');
      Navigator.pop(context, true);
    } catch (e) {
      if (mounted) AppSnackBar.show(context, e.toString(), isError: true);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const BackAppBar(title: 'Checkout'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Shopping List', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 12),
          ...widget.cart.items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text('• ${item.name}  x${item.quantity}  -  ${PriceFormatter.format(item.total)}'),
            ),
          ),
          const SizedBox(height: 12),
          CartSummary(cart: widget.cart),
          const SizedBox(height: 24),
          CustomPrimaryButton(text: 'Place Order', isLoading: _isLoading, onPressed: _placeOrder),
        ],
      ),
    );
  }
}
