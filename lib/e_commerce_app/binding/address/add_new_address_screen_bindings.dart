// ignore_for_file: deprecated_member_use

import 'package:get/get.dart';
import 'package:my_cart_express/e_commerce_app/controller/address/add_new_address_controller.dart';

class AddNewAddressBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<AddNewAddressController>(AddNewAddressController());
  }
}
