// ignore_for_file: deprecated_member_use

import 'package:get/get.dart';
import 'package:my_cart_express/e_commerce_app/e_controller/e_profile/e_account_info_screen_controller.dart';

class EAccountInfoScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EAccountInfoScreenController>(
        () => EAccountInfoScreenController());
  }
}
