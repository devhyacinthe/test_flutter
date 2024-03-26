import 'package:flutter/material.dart';

class SnackBarService {
  static void showSnackBar({
    required BuildContext context,
    required String message,
    required Duration duration,
    required Color backgroundColor,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: duration,
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        content: Text(message),
        action: SnackBarAction(
            label: "Ok",
            onPressed: () {},
            textColor: Theme.of(context).colorScheme.primary),
      ),
    );
  }
}
