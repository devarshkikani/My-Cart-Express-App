import 'package:get/get.dart';
import 'package:my_cart_express/e_commerce_app/e_controller/e_product_details/e_product_details_screen_controller.dart';

// ignore: deprecated_member_use
class EProductDetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EProductDetailsController>(() => EProductDetailsController());
  }
}
