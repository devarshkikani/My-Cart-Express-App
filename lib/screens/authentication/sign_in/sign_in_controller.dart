import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dio/dio.dart' as dio;
import 'package:my_cart_express/constant/app_endpoints.dart';
import 'package:my_cart_express/constant/storage_key.dart';
import 'package:my_cart_express/models/user_model.dart';
import 'package:my_cart_express/screens/home/main_home_screen.dart';
import 'package:my_cart_express/screens/not_verify/not_verify_screen.dart';
import 'package:my_cart_express/utils/network_dio.dart';
import 'package:flutter/cupertino.dart';

class SignInController extends GetxController {
  GetStorage box = GetStorage();
  RxString fcmToken = ''.obs;
  final messaging = FirebaseMessaging.instance;
  void setupSettings() async {
    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    String? token = await messaging.getToken();

    fcmToken.value = token.toString();
    if (kDebugMode) {
      print('Registration Token=$token');
    }
  }

  Future<void> signInOnTap({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    final data = dio.FormData.fromMap({
      'email': email,
      'password': password,
      'firebase_token': fcmToken.value,
      'device': Platform.isAndroid ? 1 : 2,
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
      if (model.verifyEmail == '0') {
        box.write(StorageKey.isRegister, false);
        Get.offAll(
          () => NotVerifyScreen(
            userDetails: const {},
          ),
        );
      } else {
        box.write(StorageKey.isRegister, true);
        Get.offAll(
          () => MainHomeScreen(),
        );
      }
    }
  }
}
