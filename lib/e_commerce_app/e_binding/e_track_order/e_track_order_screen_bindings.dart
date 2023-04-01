// ignore_for_file: deprecated_member_use

import 'package:get/get.dart';
import 'package:my_cart_express/e_commerce_app/e_controller/e_track_order/e_track_order_screen_controller.dart';

class ETrackOrderScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ETrackOrderScreenController>(
        () => ETrackOrderScreenController());
  }
}
