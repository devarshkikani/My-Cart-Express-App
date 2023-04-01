// ignore_for_file: deprecated_member_use

import 'package:get/get.dart';
import 'package:my_cart_express/e_commerce_app/e_controller/e_main_home/e_main_home_contoller.dart';

class EMainHomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EMainHomeController>(() => EMainHomeController());
  }
}
