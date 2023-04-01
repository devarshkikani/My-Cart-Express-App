// ignore_for_file: deprecated_member_use

import 'package:get/get.dart';
import 'package:my_cart_express/e_commerce_app/e_controller/e_home/e_filter_screen_controller.dart';

class EFilterScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EFilterScreenController>(() => EFilterScreenController());
  }
}
