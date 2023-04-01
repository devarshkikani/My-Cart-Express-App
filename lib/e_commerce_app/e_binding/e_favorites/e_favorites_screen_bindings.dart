// ignore_for_file: deprecated_member_use

import 'package:get/get.dart';
import 'package:my_cart_express/e_commerce_app/e_controller/e_favorites/e_favorites_screen_controller.dart';

class EFavoritesScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<EFavoritesScreenController>(EFavoritesScreenController());
  }
}
