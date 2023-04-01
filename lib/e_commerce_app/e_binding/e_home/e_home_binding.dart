// ignore_for_file: deprecated_member_use

import 'package:get/get.dart';
import 'package:my_cart_express/e_commerce_app/e_controller/e_home/e_home_controller.dart';

class EHomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EHomeController>(() => EHomeController());
  }
}
