import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class AppSnackBar {
  static void error(BuildContext context, String message) {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.error(message: message),
      displayDuration: const Duration(seconds: 2),
    );
  }

  static void success(BuildContext context, String message) {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.success(message: message),
      displayDuration: const Duration(seconds: 2),
    );
  }

  static void info(BuildContext context, String message) {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.info(message: message),
      displayDuration: const Duration(seconds: 2),
    );
  }
}
