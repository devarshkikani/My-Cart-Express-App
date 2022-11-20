import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cart_express/theme/colors.dart';
import 'package:my_cart_express/theme/text_style.dart';

AppBar appbarWidget({
  required String title,
  Function()? onTap,
  bool? centerTitle,
  Color? backgroundColor,
}) {
  return AppBar(
    backgroundColor: backgroundColor ?? background,
    elevation: 0,
    leading: IconButton(
      onPressed: onTap ??
          () {
            Get.back();
          },
      icon: Icon(
        Platform.isAndroid
            ? Icons.arrow_back_rounded
            : Icons.arrow_back_ios_rounded,
        color: primary,
      ),
    ),
    centerTitle: centerTitle ?? true,
    title: Text(
      title,
      style: regularText20,
    ),
  );
}
