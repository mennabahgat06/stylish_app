import 'package:flutter/material.dart';
import 'core/network/auth_interceptor.dart';
import 'core/utils/app_colors.dart';
import 'core/utils/app_navigator.dart';
import 'features/onboarding/presentation/get_started_view.dart';
import 'features/splash/presentation/splash_view.dart';

void main() {
  // Token expired / invalid (401) -> back to the Login / Register screen.
  AuthInterceptor.onSessionExpired = () {
    AppNavigator.key.currentState?.pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const GetStartedView()),
      (route) => false,
    );
  };
  runApp(const StylishApp());
}

class StylishApp extends StatelessWidget {
  const StylishApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stylish',
      navigatorKey: AppNavigator.key,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.backgroundWhite,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryPink),
        useMaterial3: true,
      ),
      home: const SplashView(),
    );
  }
}
