// ignore_for_file: deprecated_member_use

import 'package:get/get.dart';
import 'package:my_cart_express/e_commerce_app/controller/track_order/track_order_screen_controller.dart';

class TrackOrderScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TrackOrderScreenController>(() => TrackOrderScreenController());
  }
}
