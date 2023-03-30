import 'package:get/get.dart';
import 'package:my_cart_express/e_commerce_app/controller/product_details/product_details_screen_controller.dart';

// ignore: deprecated_member_use
class ProductDetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductDetailsController>(() => ProductDetailsController());
  }
}
