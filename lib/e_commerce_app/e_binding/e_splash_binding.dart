// ignore_for_file: deprecated_member_use

import 'package:get/get.dart';
import 'package:my_cart_express/e_commerce_app/e_controller/e_splash_controller.dart';

class ESplashScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ESplashScreenController>(ESplashScreenController());
  }
}
