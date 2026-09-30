import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';

/// 5 stars (full / half / empty) + number of reviews.
class RatingStars extends StatelessWidget {
  final double rating;
  final int reviewsCount;
  final double size;

  const RatingStars({super.key, required this.rating, this.reviewsCount = 0, this.size = 12});

  IconData _iconFor(int index) {
    if (rating >= index + 1) return Icons.star;
    if (rating > index) return Icons.star_half;
    return Icons.star_border;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < 5; i++) Icon(_iconFor(i), color: AppColors.starYellow, size: size),
        if (reviewsCount > 0) ...[
          const SizedBox(width: 4),
          Text('$reviewsCount', style: const TextStyle(color: Colors.grey, fontSize: 9)),
        ],
      ],
    );
  }
}
