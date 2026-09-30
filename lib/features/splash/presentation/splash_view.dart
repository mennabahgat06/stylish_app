import 'package:flutter/material.dart';
import '../../../core/storage/token_storage.dart';
import '../../home/presentation/main_navigation_view.dart';
import '../../onboarding/presentation/onboarding_view.dart';
import '../../../core/widgets/stylish_logo.dart';

/// Logo for 2 seconds. Logged in -> Home, otherwise -> Onboarding.
class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _goNext();
  }

  Future<void> _goNext() async {
    await Future.delayed(const Duration(seconds: 2));
    final isLoggedIn = await TokenStorage.isLoggedIn();
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => isLoggedIn ? const MainNavigationView() : const OnboardingView(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: StylishLogo(size: 48, fontSize: 32)),
    );
  }
}
