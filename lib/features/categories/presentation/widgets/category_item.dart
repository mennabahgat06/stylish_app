import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../../data/models/category_model.dart';

/// Round category image + name.
class CategoryItem extends StatelessWidget {
  final CategoryModel category;
  final VoidCallback onTap;

  const CategoryItem({super.key, required this.category, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 64,
        child: Column(
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor: Colors.pink.shade50,
              foregroundImage:
                  category.imageUrl == null ? null : NetworkImage(category.imageUrl!),
              onForegroundImageError: category.imageUrl == null ? null : (_, __) {},
              child: const Icon(Icons.checkroom, color: AppColors.primaryPink),
            ),
            const SizedBox(height: 4),
            Text(
              category.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}
