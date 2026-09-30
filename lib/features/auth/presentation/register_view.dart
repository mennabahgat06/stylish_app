import 'package:flutter/material.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Create an\naccount', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
              const SizedBox(height: 28),
              const CustomTextField(hintText: 'Full Name', prefixIcon: Icons.person_outline),
              const SizedBox(height: 16),
              const CustomTextField(hintText: 'Phone', prefixIcon: Icons.phone_outlined, keyboardType: TextInputType.phone),
              const SizedBox(height: 16),
              const CustomTextField(hintText: 'Email', prefixIcon: Icons.email_outlined, keyboardType: TextInputType.emailAddress),
              const SizedBox(height: 16),
              const CustomTextField(hintText: 'Password', prefixIcon: Icons.lock_outline, isPassword: true),
              const SizedBox(height: 16),
              const CustomTextField(hintText: 'Confirm Password', prefixIcon: Icons.lock_outline, isPassword: true),
              const SizedBox(height: 24),
              const Text(
                'By clicking the Register button, you agree to the public offer',
                style: TextStyle(color: AppColors.textMuted, fontSize: 11),
              ),
              const SizedBox(height: 24),
              CustomPrimaryButton(
                text: 'Create Account',
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}