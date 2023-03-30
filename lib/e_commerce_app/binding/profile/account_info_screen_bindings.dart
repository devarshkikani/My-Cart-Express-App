// ignore_for_file: deprecated_member_use

import 'package:get/get.dart';
import 'package:my_cart_express/e_commerce_app/controller/profile/account_info_screen_controller.dart';

class AccountInfoScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AccountInfoScreenController>(
        () => AccountInfoScreenController());
  }
}
