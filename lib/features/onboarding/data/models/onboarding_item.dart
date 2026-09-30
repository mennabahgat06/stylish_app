import 'package:flutter/material.dart';

/// Content of one onboarding page.
class OnboardingItem {
  final String title;
  final String description;
  final IconData icon;

  const OnboardingItem({required this.title, required this.description, required this.icon});

  static const List<OnboardingItem> pages = [
    OnboardingItem(
      title: 'Choose Products',
      description: 'Browse trending fashion, find what you love and add it to your cart in one tap.',
      icon: Icons.shopping_bag_outlined,
    ),
    OnboardingItem(
      title: 'Make Payment',
      description: 'Check out quickly and safely. Your order total is always clear before you pay.',
      icon: Icons.credit_card_outlined,
    ),
    OnboardingItem(
      title: 'Get Your Order',
      description: 'Track your orders from the profile page until they arrive at your door.',
      icon: Icons.local_shipping_outlined,
    ),
  ];
}
