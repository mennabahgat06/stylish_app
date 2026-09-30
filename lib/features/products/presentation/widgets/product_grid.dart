import 'package:flutter/material.dart';
import '../../data/models/product_model.dart';
import '../product_details_view.dart';
import 'product_card.dart';

/// 2-column grid of [ProductCard]. Tap -> product details.
/// [shrinkWrap] = true when the grid is inside another scroll view.
class ProductGrid extends StatelessWidget {
  final List<ProductModel> products;
  final bool shrinkWrap;
  final VoidCallback? onReturn;
  final Widget Function(ProductModel product)? topRightBuilder;
  final EdgeInsetsGeometry? padding;

  const ProductGrid({
    super.key,
    required this.products,
    this.shrinkWrap = false,
    this.onReturn,
    this.topRightBuilder,
    this.padding,
  });

  Future<void> _open(BuildContext context, ProductModel product) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ProductDetailsView(product: product)),
    );
    onReturn?.call();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: shrinkWrap,
      physics: shrinkWrap ? const NeverScrollableScrollPhysics() : null,
      padding: padding ?? (shrinkWrap ? EdgeInsets.zero : const EdgeInsets.all(16)),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.68,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return ProductCard(
          product: product,
          onTap: () => _open(context, product),
          topRight: topRightBuilder?.call(product),
        );
      },
    );
  }
}
