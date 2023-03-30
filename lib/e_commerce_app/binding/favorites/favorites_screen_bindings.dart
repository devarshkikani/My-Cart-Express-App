// ignore_for_file: deprecated_member_use

import 'package:get/get.dart';
import 'package:my_cart_express/e_commerce_app/controller/favorites/favorites_screen_controller.dart';

class FavoritesScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<FavoritesScreenController>(FavoritesScreenController());
  }
}
