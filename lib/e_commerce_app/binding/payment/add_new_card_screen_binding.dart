// ignore_for_file: deprecated_member_use

import 'package:get/get.dart';
import 'package:my_cart_express/e_commerce_app/controller/payment/add_new_card_screen_controller.dart';

class AddNewCardScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddNewCardScreenController>(() => AddNewCardScreenController());
  }
}
