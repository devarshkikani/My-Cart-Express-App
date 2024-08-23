import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get_storage/get_storage.dart';
import 'package:my_cart_express/order_tracking_app/constant/app_endpoints.dart';
import 'package:my_cart_express/order_tracking_app/utils/network_dio.dart';
import 'package:my_cart_express/staff_app/staff_binding/staff_main_home_binding..dart';
import 'package:my_cart_express/staff_app/staff_screen/staff_main_home_page.dart';

class OtpController extends GetxController {
  GetStorage box = GetStorage();

  Future<void> signInOnTap({
    required String otp,
    required BuildContext context,
  }) async {
    final data = dio.FormData.fromMap({"otp": otp});
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
      context: context,
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.otpVerification,
      data: data,
    );
    if (response != null) {
      Get.offAll(
        () => const StaffMainHome(),
        binding: StaffMainHomeBinding(),
      );
    }
  }
}
