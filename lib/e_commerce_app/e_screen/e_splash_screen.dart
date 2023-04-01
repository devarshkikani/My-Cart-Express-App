// ignore_for_file: always_specify_types

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cart_express/e_commerce_app/e_constant/e_default_image.dart';
import 'package:my_cart_express/e_commerce_app/e_controller/e_splash_controller.dart';

class SplashScreen extends GetView<ESplashScreenController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Image.asset(
              shoppingCart,
              height: 250,
            ),
          ),
        ],
      ),
    );
  }
}
