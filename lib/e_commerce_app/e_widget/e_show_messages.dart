import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cart_express/e_commerce_app/e_theme/e_app_colors.dart';
import 'package:my_cart_express/e_commerce_app/e_theme/e_app_text_theme.dart';

class EShowMessgae {
  static void showSuccess({
    required String title,
    required String sucessMessage,
  }) {
    Get.snackbar(
      title,
      sucessMessage,
      margin: const EdgeInsets.all(15),
      backgroundColor: success.withOpacity(0.9),
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  static void showWarning({
    required String message,
  }) {
    Get.snackbar(
      '',
      '',
      titleText: const SizedBox(),
      messageText: Text(
        message,
        style: regularText16,
      ),
      margin: const EdgeInsets.all(15),
      backgroundColor: lightPrimary.withOpacity(0.9),
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  static void showError({
    required String title,
    required String errorMessage,
  }) {
    Get.snackbar(
      title,
      errorMessage,
      colorText: whiteColor,
      backgroundColor: error.withOpacity(0.9),
      margin: const EdgeInsets.all(15),
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
