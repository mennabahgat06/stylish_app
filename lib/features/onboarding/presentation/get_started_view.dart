import 'package:flutter/material.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/custom_button.dart';
import '../../auth/presentation/login_view.dart';
import '../../auth/presentation/register_view.dart';

/// Dark screen with Login / Register buttons.
class GetStartedView extends StatelessWidget {
  const GetStartedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.darkTop, AppColors.darkBottom],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  'You want Authentic, here you go!',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text('Find it here, buy it now!',
                    style: TextStyle(color: Colors.white60, fontSize: 14)),
                const SizedBox(height: 36),
                CustomPrimaryButton(
                  text: 'Login',
                  onPressed: () => Navigator.push(
                      context, MaterialPageRoute(builder: (_) => const LoginView())),
                ),
                const SizedBox(height: 14),
                CustomPrimaryButton(
                  text: 'Register',
                  backgroundColor: Colors.white,
                  textColor: AppColors.primaryPink,
                  onPressed: () => Navigator.push(
                      context, MaterialPageRoute(builder: (_) => const RegisterView())),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
