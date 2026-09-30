import 'package:flutter/material.dart';
import '../../../core/utils/app_snack_bar.dart';
import '../../../core/widgets/back_app_bar.dart';
import '../../../core/widgets/empty_view.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/loading_view.dart';
import '../../products/data/models/product_model.dart';
import '../../products/presentation/widgets/favorite_button.dart';
import '../../products/presentation/widgets/product_grid.dart';
import '../data/services/favorite_service.dart';

/// Favorite products (added with POST add_to_favorite, list kept on the device).
class FavoritesView extends StatefulWidget {
  const FavoritesView({super.key});

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  final FavoriteService _favoriteService = FavoriteService();
  List<ProductModel> _favorites = [];
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
      final favorites = await _favoriteService.getFavorites();
      if (mounted) setState(() => _favorites = favorites);
    } catch (e) {
      if (mounted) setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _remove(ProductModel product) async {
    try {
      await _favoriteService.remove(product.id);
      if (mounted) setState(() => _favorites.remove(product));
    } catch (e) {
      if (mounted) AppSnackBar.show(context, e.toString(), isError: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const BackAppBar(title: 'My Favorites'),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) return const LoadingView();
    if (_error != null) return ErrorView(message: _error!, onRetry: _load);
    if (_favorites.isEmpty) {
      return const EmptyView(icon: Icons.favorite_border, message: 'No favorites yet');
    }
    return ProductGrid(
      products: _favorites,
      onReturn: _load, // the user may un-favorite from the details screen
      topRightBuilder: (product) =>
          FavoriteButton(isFavorite: true, onTap: () => _remove(product)),
    );
  }
}
