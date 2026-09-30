import 'package:flutter/material.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/loading_view.dart';
import '../../../core/widgets/stylish_logo.dart';
import '../../cart/presentation/cart_view.dart';
import '../../categories/data/models/category_model.dart';
import '../../categories/presentation/widgets/categories_list.dart';
import '../../products/data/models/product_model.dart';
import '../../products/data/services/product_service.dart';
import '../../products/presentation/widgets/product_grid.dart';
import '../../search/presentation/search_view.dart';
import '../data/models/slider_model.dart';
import '../data/services/home_service.dart';
import 'widgets/search_bar_button.dart';
import 'widgets/section_title.dart';
import 'widgets/slider_banner.dart';

/// Tab 1: GET sliders, categories, best_seller_products, top_rated_products.
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeService _homeService = HomeService();
  final ProductService _productService = ProductService();

  List<SliderModel> _sliders = [];
  List<CategoryModel> _categories = [];
  List<ProductModel> _bestSellers = [];
  List<ProductModel> _topRated = [];
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
      final results = await Future.wait([
        _homeService.getSliders(),
        _homeService.getCategories(),
        _productService.getBestSellers(),
        _productService.getTopRated(),
      ]);
      if (!mounted) return;
      setState(() {
        _sliders = results[0] as List<SliderModel>;
        _categories = results[1] as List<CategoryModel>;
        _bestSellers = results[2] as List<ProductModel>;
        _topRated = results[3] as List<ProductModel>;
      });
    } catch (e) {
      if (mounted) setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _open(Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const StylishLogo(),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined, color: Colors.black),
            onPressed: () => _open(const CartView()),
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) return const LoadingView();
    if (_error != null) return ErrorView(message: _error!, onRetry: _load);

    return RefreshIndicator(
      onRefresh: _load,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        children: [
          SearchBarButton(onTap: () => _open(const SearchView())),
          const SizedBox(height: 18),
          const SectionTitle(title: 'All Featured'),
          const SizedBox(height: 12),
          CategoriesList(
            categories: _categories,
            onTap: (category) => _open(SearchView(category: category)),
          ),
          const SizedBox(height: 16),
          SliderBanner(sliders: _sliders),
          const SizedBox(height: 20),
          const SectionTitle(title: 'Best Seller'),
          const SizedBox(height: 12),
          ProductGrid(products: _bestSellers, shrinkWrap: true),
          const SizedBox(height: 20),
          const SectionTitle(title: 'Top Rated'),
          const SizedBox(height: 12),
          ProductGrid(products: _topRated, shrinkWrap: true),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
