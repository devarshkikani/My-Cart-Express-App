import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cart_express/e_commerce_app/theme/app_colors.dart';
import 'package:my_cart_express/e_commerce_app/theme/app_text_theme.dart';

OutlinedButton outlinedButton({
  required String title,
  required Function()? onTap,
  Size? maximumSize,
  Color? backgroundColor,
  Color? textColor,
  Color? borderColor,
}) {
  return OutlinedButton(
    style: OutlinedButton.styleFrom(
      backgroundColor: backgroundColor ?? Colors.transparent,
      maximumSize: maximumSize ?? Size(Get.width / 2, 50),
      side: BorderSide(
        color: borderColor ?? lightPrimary,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
    ),
    onPressed: onTap,
    child: Center(
      child: Text(
        title,
        style: mediumText16.copyWith(
          color: textColor ?? lightPrimary,
        ),
      ),
    ),
  );
}
