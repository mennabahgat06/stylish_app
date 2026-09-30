import 'package:flutter/material.dart';
import 'app_colors.dart';

/// AppSnackBar.show(context, 'Saved');
class AppSnackBar {
  static void show(BuildContext context, String message, {bool isError = false}) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: isError ? Colors.red.shade700 : AppColors.textBlack,
        ),
      );
  }
}
