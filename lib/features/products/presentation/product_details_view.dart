import 'package:flutter/material.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_snack_bar.dart';
import '../../../core/utils/price_formatter.dart';
import '../../../core/widgets/app_network_image.dart';
import '../../../core/widgets/back_app_bar.dart';
import '../../../core/widgets/custom_button.dart';
import '../../cart/data/services/cart_service.dart';
import '../../favorites/data/services/favorite_service.dart';
import '../data/models/product_model.dart';
import 'widgets/quantity_selector.dart';
import 'widgets/rating_stars.dart';

/// Product details (from the list), add to the local cart, POST add_to_favorite.
class ProductDetailsView extends StatefulWidget {
  final ProductModel product;

  const ProductDetailsView({super.key, required this.product});

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  final CartService _cartService = CartService();
  final FavoriteService _favoriteService = FavoriteService();

  ProductModel get _product => widget.product;
  late bool _isFavorite = widget.product.isFavorite;
  int _quantity = 1;
  bool _isAdding = false;

  Future<void> _toggleFavorite() async {
    final newValue = !_isFavorite;
    setState(() => _isFavorite = newValue);
    try {
      if (newValue) {
        await _favoriteService.add(_product.id);
      } else {
        await _favoriteService.remove(_product.id);
      }
    } catch (e) {
      if (!mounted) return;
      setState(() => _isFavorite = !newValue); // undo
      AppSnackBar.show(context, e.toString(), isError: true);
    }
  }

  Future<void> _addToCart() async {
    setState(() => _isAdding = true);
    try {
      await _cartService.addToCart(product: _product, quantity: _quantity);
      if (mounted) AppSnackBar.show(context, 'Added to Cart!');
    } catch (e) {
      if (mounted) AppSnackBar.show(context, e.toString(), isError: true);
    } finally {
      if (mounted) setState(() => _isAdding = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BackAppBar(
        title: 'Product',
        actions: [
          IconButton(
            icon: Icon(_isFavorite ? Icons.favorite : Icons.favorite_border,
                color: AppColors.primaryPink),
            onPressed: _toggleFavorite,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppNetworkImage(
              url: _product.imageUrl,
              height: 260,
              width: double.infinity,
              radius: 16,
            ),
            const SizedBox(height: 20),
            Text(_product.name,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            if (_product.rating > 0) ...[
              const SizedBox(height: 6),
              RatingStars(rating: _product.rating, size: 16),
            ],
            const SizedBox(height: 6),
            Text(_product.description,
                style: const TextStyle(color: Colors.grey, fontSize: 12, height: 1.4)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  PriceFormatter.format(_product.price),
                  style: const TextStyle(
                      color: AppColors.primaryPink, fontSize: 24, fontWeight: FontWeight.bold),
                ),
                QuantitySelector(
                  quantity: _quantity,
                  onChanged: (value) => setState(() => _quantity = value),
                ),
              ],
            ),
            const SizedBox(height: 40),
            CustomPrimaryButton(text: 'Add To Cart', isLoading: _isAdding, onPressed: _addToCart),
          ],
        ),
      ),
    );
  }
}
