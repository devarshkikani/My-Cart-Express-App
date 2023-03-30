// ignore_for_file: deprecated_member_use

import 'package:get/get.dart';
import 'package:my_cart_express/e_commerce_app/controller/home/search_screen_controller.dart';

class SearchScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchScreenController>(() => SearchScreenController());
  }
}
