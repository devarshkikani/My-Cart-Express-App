

import 'package:get/get.dart';
import 'package:my_cart_express/staff_app/staff_controller/staff_main_home_controller.dart';

class StaffMainHomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StaffMainHomeController>(() => StaffMainHomeController());
  }
}
