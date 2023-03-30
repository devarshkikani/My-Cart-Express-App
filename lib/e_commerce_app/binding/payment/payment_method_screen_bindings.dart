// ignore_for_file: deprecated_member_use

import 'package:get/get.dart';
import 'package:my_cart_express/e_commerce_app/controller/payment/payment_method_screen_controller.dart';

class PaymentMethosScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentMethodScreenController>(
        () => PaymentMethodScreenController());
  }
}
