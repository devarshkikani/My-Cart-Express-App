import 'package:flutter/material.dart';
import 'package:my_cart_express/e_commerce_app/e_theme/e_app_colors.dart';
import 'package:my_cart_express/e_commerce_app/e_theme/e_app_text_theme.dart';

InkWell eElevatedButton({
  required BuildContext context,
  required String title,
  required Function()? onTap,
  bool? showShadow,
  Size? maximumSize,
  Color? backgroundColor,
  Color? textColor,
}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: maximumSize == null ? 45 : maximumSize.height,
      decoration: BoxDecoration(
        color: backgroundColor ?? Theme.of(context).colorScheme.primary,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        boxShadow: showShadow == true
            ? <BoxShadow>[
                BoxShadow(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                  offset: const Offset(5, 5),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ]
            : <BoxShadow>[],
      ),
      child: Center(
        child: Text(
          title,
          style: regularText16.copyWith(
            color: textColor ?? whiteColor,
          ),
        ),
      ),
    ),
  );
}
