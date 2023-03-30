// ignore_for_file: deprecated_member_use

import 'package:get/get.dart';
import 'package:my_cart_express/e_commerce_app/controller/profile/profile_screen_controller.dart';

class ProfileScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ProfileScreenController>(ProfileScreenController());
  }
}
