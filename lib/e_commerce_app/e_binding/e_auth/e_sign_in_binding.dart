// ignore_for_file: deprecated_member_use

import 'package:get/get.dart';
import 'package:my_cart_express/e_commerce_app/e_controller/e_auth/e_sign_in_controller.dart';

class ESignInBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ESignInController>(() => ESignInController());
  }
}
