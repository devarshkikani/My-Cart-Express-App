// ignore_for_file: deprecated_member_use

import 'package:get/get.dart';
import 'package:my_cart_express/e_commerce_app/controller/address/delivery_address_screen_controller.dart';

class DeliveryAddressScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DeliveryAddressScreenController>(
        () => DeliveryAddressScreenController());
  }
}
