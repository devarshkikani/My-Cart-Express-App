import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cart_express/e_commerce_app/routes/app_pages.dart';
import 'package:my_cart_express/e_commerce_app/widget/show_messages.dart';

class SignUpController extends GetxController {
  RxBool isCheck = false.obs;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  Future<void> signUpClick() async {
    if (formKey.currentState!.validate()) {
      if (isCheck.value) {
        Get.offAllNamed(Routes.mainHome);
      } else {
        ShowMessgae.showWarning(
          message: 'Apply term and condition first',
        );
      }
    }
  }

  Future<void> signUpWithFacebookClick() async {
    Get.offAllNamed(Routes.mainHome);
  }
}
