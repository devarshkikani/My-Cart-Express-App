import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_cart_express/e_commerce_app/e_constant/e_storage_key.dart';
import 'package:my_cart_express/e_commerce_app/e_routes/e_app_pages.dart';

class ESignInController extends GetxController {
  GetStorage box = GetStorage();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  Future<void> signInClick() async {
    if (formKey.currentState!.validate()) {
      box.write(EStorageKey.eIsLogedIn, true);
      Get.offAllNamed(ERoutes.mainHome);
    }
  }

  Future<void> signUpWithFacebookClick() async {
    box.write(EStorageKey.eIsLogedIn, true);
    Get.offAllNamed(ERoutes.mainHome);
  }
}
