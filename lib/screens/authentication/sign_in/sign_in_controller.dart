import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_cart_express/constant/app_endpoints.dart';
import 'package:my_cart_express/constant/storage_key.dart';
import 'package:my_cart_express/models/user_model.dart';
import 'package:my_cart_express/screens/home/main_home_screen.dart';
import 'package:my_cart_express/utils/network_dio.dart';

class SignInController extends GetxController {
  Future<void> signInOnTap({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    GetStorage box = GetStorage();
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
      context: context,
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.login,
      data: {
        'email': email,
        'password': password,
        'ipaddress': '',
        'device_unique_value': '',
      },
    );
    if (response != null) {
      UserModel model = UserModel.fromJson(response);
      box.write(StorageKey.userId, model.userId);
      box.write(StorageKey.isLogedIn, true);
      Get.offAll(() => const MainHomeScreen());
    }
  }
}
