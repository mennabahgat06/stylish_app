import 'package:flutter/material.dart';
import '../../data/models/category_model.dart';
import 'category_item.dart';

/// Horizontal list of categories.
class CategoriesList extends StatelessWidget {
  final List<CategoryModel> categories;
  final ValueChanged<CategoryModel> onTap;

  const CategoriesList({super.key, required this.categories, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 84,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 14),
        itemBuilder: (_, index) => CategoryItem(
          category: categories[index],
          onTap: () => onTap(categories[index]),
        ),
      ),
    );
  }
}
