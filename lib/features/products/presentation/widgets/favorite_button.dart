import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';

/// Round white button with a heart.
class FavoriteButton extends StatelessWidget {
  final bool isFavorite;
  final VoidCallback onTap;

  const FavoriteButton({super.key, required this.isFavorite, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: 16,
        backgroundColor: Colors.white,
        child: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          color: AppColors.primaryPink,
          size: 18,
        ),
      ),
    );
  }
}
