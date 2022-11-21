import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cart_express/theme/colors.dart';
import 'package:my_cart_express/theme/text_style.dart';
import 'package:my_cart_express/widget/app_bar_widget.dart';

class AuthPickupScreen extends StatefulWidget {
  const AuthPickupScreen({super.key});

  @override
  State<AuthPickupScreen> createState() => _AuthPickupScreenState();
}

class _AuthPickupScreenState extends State<AuthPickupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.height,
        color: primary,
        child: Column(
          children: [
            appBarWithAction(),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: const BoxDecoration(
                  color: offWhite,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: bodyView(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget bodyView() {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Authorise Pick Up',
              style: regularText18,
            ),
          ],
        ),
      ],
    );
  }
}
