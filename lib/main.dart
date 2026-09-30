import 'package:flutter/material.dart';
import 'core/utils/app_colors.dart';
import 'features/splash/presentation/splash_view.dart';

void main() {
  runApp(const StylishApp());
}

class StylishApp extends StatelessWidget {
  const StylishApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stylish',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.backgroundWhite,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryPink),
        useMaterial3: true,
      ),
      home: const SplashView(),
    );
  }
}