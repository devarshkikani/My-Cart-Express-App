// ignore_for_file: deprecated_member_use

import 'package:get/get.dart';
import 'package:my_cart_express/e_commerce_app/controller/details/details_controller.dart';
import 'package:my_cart_express/e_commerce_app/data/provider/api.dart';
import 'package:my_cart_express/e_commerce_app/data/repository/posts_repository.dart';
import 'package:http/http.dart' as http;

class DetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailsController>(() {
      return DetailsController(
          repository:
              MyRepository(apiClient: MyApiClient(httpClient: http.Client())));
    });
  }
}
