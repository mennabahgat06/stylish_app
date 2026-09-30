import 'cart_item_model.dart';

/// Cart items + totals (calculated in the app).
class CartModel {
  /// Change these if the shop adds fees.
  static const double taxRate = 0;
  static const double deliveryFee = 0;

  final List<CartItemModel> items;

  CartModel({required this.items});

  bool get isEmpty => items.isEmpty;
  double get subtotal => items.fold<double>(0, (sum, item) => sum + item.total);
  double get tax => subtotal * taxRate;
  double get delivery => items.isEmpty ? 0 : deliveryFee;
  double get total => subtotal + tax + delivery;
}
