import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:my_cart_express/screens/authentication/reset_password/reset_password.dart';
import 'package:my_cart_express/utils/network_dio.dart';
import 'package:my_cart_express/constant/app_endpoints.dart';

class ForgotPasswordScreenController extends GetxController {
  Future<void> resetPasswordOntap(
      {required String email, required BuildContext context}) async {
    final data = dio.FormData.fromMap({
      'email': email,
    });
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.forgotPassword,
      context: context,
      data: data,
    );
    if (response != null) {
      NetworkDio.showSuccess(
          title: 'Suceess', sucessMessage: response['message']);
      Get.to(() => const ResetPasswordScreen());
    }
  }
}
