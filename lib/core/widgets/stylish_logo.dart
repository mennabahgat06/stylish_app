import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

/// Round gradient icon + "Stylish" (splash and home app bar).
class StylishLogo extends StatelessWidget {
  final double size;
  final double fontSize;

  const StylishLogo({super.key, this.size = 28, this.fontSize = 18});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: size,
          height: size,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(colors: [Colors.blue, AppColors.primaryPink]),
          ),
          child: Icon(Icons.all_inclusive, color: Colors.white, size: size * 0.6),
        ),
        const SizedBox(width: 8),
        Text(
          'Stylish',
          style: TextStyle(
            color: AppColors.primaryPink,
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
