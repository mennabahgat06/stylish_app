import 'package:flutter/material.dart';
import '../../../core/utils/app_colors.dart';
import '../../cart/presentation/cart_view.dart';
import '../../products/presentation/product_details_view.dart';
import '../../search/presentation/search_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = ['Beauty', 'Fashion', 'Kids', 'Mens', 'Womens'];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.menu, color: Colors.black),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.all_inclusive, color: AppColors.primaryPink),
            SizedBox(width: 6),
            Text('Stylish',
                style: TextStyle(
                    color: AppColors.primaryPink,
                    fontWeight: FontWeight.bold,
                    fontSize: 18)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined, color: Colors.black),
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => const CartView())),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            // Search Bar
            GestureDetector(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const SearchView())),
              child: Container(
                height: 44,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: AppColors.inputBackground,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.search, color: AppColors.textMuted),
                    SizedBox(width: 8),
                    Text('Search any Product..',
                        style: TextStyle(
                            color: AppColors.textMuted, fontSize: 13)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),
            const Text('All Featured',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 12),
            // Horizontal Categories
            SizedBox(
              height: 80,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 14),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      CircleAvatar(
                        radius: 26,
                        backgroundColor: Colors.pink.shade50,
                        child: const Icon(Icons.checkroom,
                            color: AppColors.primaryPink),
                      ),
                      const SizedBox(height: 4),
                      Text(categories[index],
                          style: const TextStyle(fontSize: 11)),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            // Banner
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFFFA7189),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('50-40% OFF',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                        SizedBox(height: 4),
                        Text('Now in [product]\nAll colours',
                            style:
                                TextStyle(color: Colors.white70, fontSize: 11)),
                      ],
                    ),
                  ),
                  const Icon(Icons.shopping_bag, size: 50, color: Colors.white),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text('Recommended',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 12),
            // Product Cards Grid
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.72,
              ),
              itemCount: 4,
              itemBuilder: (context, index) {
                return _buildProductCard(context);
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (_) => const ProductDetailsView())),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 6,
                offset: const Offset(0, 2)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(10)),
                ),
                child: const Center(
                  child: Icon(Icons.checkroom, size: 60, color: Colors.black87),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Mens Starry',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  const Text('Mens Starry Sky Shirt',
                      style: TextStyle(color: Colors.grey, fontSize: 10),
                      maxLines: 1),
                  const SizedBox(height: 4),
                  const Text('₹399',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                  Row(
                    children: const [
                      Icon(Icons.star, color: AppColors.starYellow, size: 12),
                      Icon(Icons.star, color: AppColors.starYellow, size: 12),
                      Icon(Icons.star, color: AppColors.starYellow, size: 12),
                      Icon(Icons.star, color: AppColors.starYellow, size: 12),
                      SizedBox(width: 4),
                      Text('1,52,344',
                          style: TextStyle(color: Colors.grey, fontSize: 9)),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
