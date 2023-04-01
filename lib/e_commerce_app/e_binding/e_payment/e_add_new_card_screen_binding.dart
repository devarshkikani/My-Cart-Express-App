// ignore_for_file: deprecated_member_use

import 'package:get/get.dart';
import 'package:my_cart_express/e_commerce_app/e_controller/e_payment/e_add_new_card_screen_controller.dart';

class EAddNewCardScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EAddNewCardScreenController>(
        () => EAddNewCardScreenController());
  }
}
