import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

/// Error message + "Try again".
class ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const ErrorView({super.key, required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 48, color: AppColors.textMuted),
            const SizedBox(height: 12),
            Text(message, textAlign: TextAlign.center, style: const TextStyle(color: Colors.grey)),
            TextButton(
              onPressed: onRetry,
              child: const Text('Try again', style: TextStyle(color: AppColors.primaryPink)),
            ),
          ],
        ),
      ),
    );
  }
}
