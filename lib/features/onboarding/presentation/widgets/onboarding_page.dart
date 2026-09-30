import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../../data/models/onboarding_item.dart';

/// Icon + title + description of one onboarding page.
class OnboardingPage extends StatelessWidget {
  final OnboardingItem item;

  const OnboardingPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 100,
          backgroundColor: Colors.pink.shade50,
          child: Icon(item.icon, size: 80, color: AppColors.primaryPink),
        ),
        const SizedBox(height: 36),
        Text(item.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Text(
          item.description,
          textAlign: TextAlign.center,
          style: const TextStyle(color: AppColors.textMuted, fontSize: 13, height: 1.5),
        ),
      ],
    );
  }
}
