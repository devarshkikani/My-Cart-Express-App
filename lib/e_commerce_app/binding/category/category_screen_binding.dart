// ignore_for_file: deprecated_member_use

import 'package:get/get.dart';
import 'package:my_cart_express/e_commerce_app/controller/category/category_screen_controller.dart';

class CategoryScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoryScreenController>(() => CategoryScreenController());
  }
}
