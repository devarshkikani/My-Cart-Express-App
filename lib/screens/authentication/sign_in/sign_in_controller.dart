import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dio/dio.dart' as dio;
import 'package:my_cart_express/constant/app_endpoints.dart';
import 'package:my_cart_express/constant/storage_key.dart';
import 'package:my_cart_express/models/user_model.dart';
import 'package:my_cart_express/screens/home/main_home_screen.dart';
import 'package:my_cart_express/utils/network_dio.dart';
import 'package:flutter/cupertino.dart';

class SignInController extends GetxController {
  GetStorage box = GetStorage();
  Future<void> signInOnTap({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    final data = dio.FormData.fromMap({
      'email': email,
      'password': password,
    });
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
      context: context,
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.signIn,
      data: data,
    );
    if (response != null) {
      UserModel model = UserModel.fromJson(response['data']);
      box.write(StorageKey.apiToken, response['token']);
      box.write(StorageKey.currentUser, model.toJson());
      box.write(StorageKey.userId, model.userId);
      box.write(StorageKey.isLogedIn, true);
      await NetworkDio.setDynamicHeader();
      Get.offAll(
        () => MainHomeScreen(),
      );
    }
  }
}
