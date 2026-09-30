import 'package:flutter/material.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/custom_button.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({super.key});

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Product', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        actions: const [
          Icon(Icons.favorite, color: AppColors.primaryPink),
          SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 260,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(
                child: Icon(Icons.checkroom, size: 100, color: Colors.black87),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Mens Starry', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            const Text(
              'Vision Alta Men\'s Shoes Size (All Colours) Mens Starry Sky Printed Shirt 100% Cotton Fabric',
              style: TextStyle(color: Colors.grey, fontSize: 12, height: 1.4),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('100 \$', style: TextStyle(color: AppColors.primaryPink, fontSize: 24, fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove_circle, color: AppColors.primaryPink),
                      onPressed: () => setState(() => quantity > 1 ? quantity-- : null),
                    ),
                    Text('$quantity', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    IconButton(
                      icon: const Icon(Icons.add_circle, color: AppColors.primaryPink),
                      onPressed: () => setState(() => quantity++),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 40),
            CustomPrimaryButton(
              text: 'Add To Cart',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Added to Cart!')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}