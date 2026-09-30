import 'package:flutter/material.dart';
import '../../../../core/utils/price_formatter.dart';
import '../../../../core/widgets/app_network_image.dart';
import '../../data/models/product_model.dart';
import 'rating_stars.dart';

/// Product box: image, name, description, price and rating.
/// Optional [topRight] widget (e.g. favorite heart).
class ProductCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback onTap;
  final Widget? topRight;

  const ProductCard({super.key, required this.product, required this.onTap, this.topRight});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: AppNetworkImage(
                      url: product.imageUrl,
                      width: double.infinity,
                      radius: 10,
                    ),
                  ),
                  if (topRight != null) Positioned(top: 8, right: 8, child: topRight!),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  Text(product.description,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.grey, fontSize: 10)),
                  const SizedBox(height: 4),
                  Text(PriceFormatter.format(product.price),
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                  if (product.rating > 0)
                    RatingStars(rating: product.rating),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
