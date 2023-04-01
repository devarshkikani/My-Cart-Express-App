// ignore_for_file: deprecated_member_use

import 'package:get/get.dart';
import 'package:my_cart_express/e_commerce_app/e_controller/e_address/e_add_new_address_controller.dart';

class EAddNewAddressBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<EAddNewAddressController>(EAddNewAddressController());
  }
}
