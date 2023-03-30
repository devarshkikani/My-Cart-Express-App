import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cart_express/e_commerce_app/routes/app_pages.dart';

class SignInController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  Future<void> signInClick() async {
    if (formKey.currentState!.validate()) {
      Get.offAllNamed(Routes.mainHome);
    }
  }

  Future<void> signUpWithFacebookClick() async {
    Get.offAllNamed(Routes.mainHome);
  }
}
