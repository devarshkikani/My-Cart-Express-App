// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:my_cart_express/order_tracking_app/constant/app_endpoints.dart';
import 'package:my_cart_express/order_tracking_app/constant/storage_key.dart';
import 'package:my_cart_express/order_tracking_app/models/user_model.dart';
import 'package:my_cart_express/order_tracking_app/screens/authentication/otp/otp_screen.dart';
import 'package:my_cart_express/order_tracking_app/screens/home/main_home_screen.dart';
import 'package:my_cart_express/order_tracking_app/screens/not_verify/not_verify_screen.dart';
import 'package:my_cart_express/order_tracking_app/utils/global_singleton.dart';
import 'package:my_cart_express/order_tracking_app/utils/network_dio.dart';
import 'package:my_cart_express/staff_app/staff_binding/staff_main_home_binding..dart';
import 'package:my_cart_express/staff_app/staff_screen/staff_main_home_page.dart';

class LoginController extends GetxController {
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
      // 'firebase_token': fcmToken.value,
      // 'device': Platform.isAndroid ? 1 : 2,
    });
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
      context: context,
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.signIn,
      data: data,
    );
    log("Data- ${{
      'email': email,
      'password': password,
      'firebase_token': fcmToken.value,
      'device': Platform.isAndroid ? 1 : 2,
    }}");

    if (response != null) {
      UserModel model = UserModel.fromJson(response['data']);
      if (response["modules"].runtimeType != List) {
        StaffBottomModule modual =
            StaffBottomModule.fromJson(response['modules']);
        box.write(StorageKey.staffBottomModual, modual.toJson());
      }
      box.write(StorageKey.apiToken, response['token']);
      box.write(StorageKey.currentUser, model.toJson());
      box.write(StorageKey.userId, model.userId);
      box.write(StorageKey.isLogedIn, true);
      await NetworkDio.setDynamicHeader();
      await getUserDetails(context, model.isStaff);
    }
  }

  Future<void> getUserDetails(BuildContext context, num isStaff) async {
    Map<String, dynamic>? response = await NetworkDio.getDioHttpMethod(
        url: ApiEndPoints.apiEndPoint + ApiEndPoints.userInfo,
        context: context);

    if (response != null) {
      GlobalSingleton.userDetails = response['data'];
      if (isStaff == 1) {
        box.write(StorageKey.isRegister, true);
        Get.to(() => OtpScreen());

        // Get.offAll(
        //   () => const StaffMainHome(),
        //   binding: StaffMainHomeBinding(),
        // );
      } else if (response['data']['verify_email'] == '0') {
        box.write(StorageKey.isRegister, false);
        Get.offAll(() => NotVerifyScreen(
              userDetails: response['data'],
            ));
      } else {
        box.write(StorageKey.isRegister, true);
        Get.offAll(
          () => MainHomeScreen(selectedIndex: 0.obs),
        );
      }
    }
  }
}
