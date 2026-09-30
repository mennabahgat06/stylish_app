import 'package:flutter/material.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/back_app_bar.dart';
import '../../../core/widgets/empty_view.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/loading_view.dart';
import '../../categories/data/models/category_model.dart';
import '../../products/data/models/product_model.dart';
import '../../products/data/services/product_service.dart';
import '../../products/presentation/widgets/product_grid.dart';

/// GET products/search?q=...   or, from a category, GET products filtered by category_id.
class SearchView extends StatefulWidget {
  final CategoryModel? category;

  const SearchView({super.key, this.category});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _searchController = TextEditingController();
  final ProductService _productService = ProductService();
  List<ProductModel> _results = [];
  bool _isLoading = false;
  bool _hasSearched = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    if (widget.category != null) _search();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _search() async {
    final query = _searchController.text.trim();
    if (query.isEmpty && widget.category == null) return;

    setState(() {
      _isLoading = true;
      _hasSearched = true;
      _error = null;
    });
    try {
      final category = widget.category;
      final results = query.isEmpty && category != null
          ? await _productService.getByCategory(category.id)
          : await _productService.search(query);
      if (mounted) setState(() => _results = results);
    } catch (e) {
      if (mounted) setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BackAppBar(title: widget.category?.name ?? 'Search'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _searchController,
              autofocus: widget.category == null,
              textInputAction: TextInputAction.search,
              onSubmitted: (_) => _search(),
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.inputBackground,
                hintText: 'Search any Product..',
                hintStyle: const TextStyle(color: AppColors.textMuted, fontSize: 13),
                prefixIcon: const Icon(Icons.search, color: AppColors.textMuted),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.arrow_forward, color: AppColors.primaryPink),
                  onPressed: _search,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (_hasSearched && !_isLoading && _error == null)
              Text('${_results.length} Items',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Expanded(child: _buildBody()),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) return const LoadingView();
    if (_error != null) return ErrorView(message: _error!, onRetry: _search);
    if (!_hasSearched) {
      return const EmptyView(icon: Icons.search, message: 'Type a product name and press search');
    }
    if (_results.isEmpty) {
      return const EmptyView(icon: Icons.search_off, message: 'No products found');
    }
    return ProductGrid(products: _results, padding: EdgeInsets.zero);
  }
}
