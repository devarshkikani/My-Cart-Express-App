// ignore_for_file: deprecated_member_use

import 'package:get/get.dart';
import 'package:my_cart_express/e_commerce_app/controller/cart/cart_screen_controller.dart';

class CartScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CartScreenController>(() => CartScreenController());
  }
}
