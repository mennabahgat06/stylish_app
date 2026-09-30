import '../../../products/data/models/product_model.dart';

/// One line in the (local) cart.
class CartItemModel {
  final ProductModel product;
  final int quantity;

  CartItemModel({required this.product, required this.quantity});

  int get id => product.id;
  String get name => product.name;
  String? get imageUrl => product.imageUrl;
  double get price => product.price;
  double get total => price * quantity;

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      product: ProductModel.fromJson(Map<String, dynamic>.from(json['product'] as Map)),
      quantity: (json['quantity'] as num? ?? 1).toInt(),
    );
  }

  Map<String, dynamic> toJson() => {'product': product.toJson(), 'quantity': quantity};
}
