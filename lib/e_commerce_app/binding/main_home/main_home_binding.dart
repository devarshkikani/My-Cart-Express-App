// ignore_for_file: deprecated_member_use

import 'package:get/get.dart';
import 'package:my_cart_express/e_commerce_app/controller/main_home/main_home_contoller.dart';

class MainHomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainHomeController>(() => MainHomeController());
  }
}
