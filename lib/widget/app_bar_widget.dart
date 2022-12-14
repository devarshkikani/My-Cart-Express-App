import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cart_express/constant/sizedbox.dart';
import 'package:my_cart_express/screens/messages_screen/messages_screen.dart';
import 'package:my_cart_express/screens/notification_screen/notifications_screen.dart';
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

AppBar appBarWithAction({
  Function()? onTap,
  bool? centerTitle,
  Color? backgroundColor,
}) {
  return AppBar(
    leading: IconButton(
      onPressed: onTap ??
          () {
            Get.back();
          },
      icon: Icon(
        Platform.isAndroid
            ? Icons.arrow_back_rounded
            : Icons.arrow_back_ios_rounded,
      ),
    ),
    centerTitle: true,
    elevation: 0.0,
    title: const Text(
      'MyCartExpress',
    ),
    actions: [
      GestureDetector(
        onTap: () {
          Get.to(() => const MessagesScreen());
        },
        child: const Icon(
          Icons.mail_outline_rounded,
        ),
      ),
      width15,
      GestureDetector(
        onTap: () {
          Get.to(() => const NotificationScreen());
        },
        child: const Icon(
          Icons.notifications_active_outlined,
        ),
      ),
      width15,
    ],
  );
}
