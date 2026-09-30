import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';

/// Looks like a search field, opens the Search screen.
class SearchBarButton extends StatelessWidget {
  final VoidCallback onTap;

  const SearchBarButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: AppColors.inputBackground,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Row(
          children: [
            Icon(Icons.search, color: AppColors.textMuted),
            SizedBox(width: 8),
            Text('Search any Product..',
                style: TextStyle(color: AppColors.textMuted, fontSize: 13)),
          ],
        ),
      ),
    );
  }
}
