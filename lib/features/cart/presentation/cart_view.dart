import 'package:flutter/material.dart';
import '../../../core/utils/app_snack_bar.dart';
import '../../../core/widgets/back_app_bar.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/empty_view.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/loading_view.dart';
import '../data/models/cart_model.dart';
import '../data/services/cart_service.dart';
import 'checkout_view.dart';
import 'widgets/cart_item_tile.dart';
import 'widgets/cart_summary.dart';

/// Local cart (saved on the device). Checkout -> POST place_order.
class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  final CartService _cartService = CartService();
  CartModel? _cart;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final cart = await _cartService.getCart();
      if (mounted) setState(() => _cart = cart);
    } catch (e) {
      if (mounted) setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _remove(int cartItemId) async {
    try {
      await _cartService.removeItem(cartItemId);
      _load();
    } catch (e) {
      if (mounted) AppSnackBar.show(context, e.toString(), isError: true);
    }
  }

  Future<void> _goToCheckout() async {
    final ordered = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => CheckoutView(cart: _cart!)),
    );
    if (ordered == true && mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const BackAppBar(title: 'Cart'),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) return const LoadingView();
    if (_error != null) return ErrorView(message: _error!, onRetry: _load);
    final cart = _cart!;
    if (cart.isEmpty) {
      return const EmptyView(icon: Icons.shopping_cart_outlined, message: 'Your cart is empty');
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Shopping List', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 12),
          Expanded(
            child: ListView(
              children: cart.items
                  .map((item) => CartItemTile(item: item, onRemove: () => _remove(item.id)))
                  .toList(),
            ),
          ),
          CartSummary(cart: cart),
          const SizedBox(height: 20),
          CustomPrimaryButton(text: 'Checkout', onPressed: _goToCheckout),
        ],
      ),
    );
  }
}
