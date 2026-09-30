import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

/// Yes / No dialog. Returns true when the user confirms.
class ConfirmDialog extends StatelessWidget {
  final String title;
  final String message;
  final String confirmText;

  const ConfirmDialog({
    super.key,
    required this.title,
    this.message = 'Are you sure?',
    this.confirmText = 'Yes',
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('No')),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text(confirmText, style: const TextStyle(color: AppColors.primaryPink)),
        ),
      ],
    );
  }
}
