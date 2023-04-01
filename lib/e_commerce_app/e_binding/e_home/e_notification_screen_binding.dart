// ignore_for_file: deprecated_member_use

import 'package:get/get.dart';
import 'package:my_cart_express/e_commerce_app/e_controller/e_home/e_notification_screen_controller.dart';

class ENotificationScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ENotificationScreenController>(
        () => ENotificationScreenController());
  }
}
