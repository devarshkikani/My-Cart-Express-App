import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_cart_express/e_commerce_app/e_constant/e_storage_key.dart';
import 'package:my_cart_express/e_commerce_app/e_routes/e_app_pages.dart';
import 'package:my_cart_express/e_commerce_app/e_widget/e_show_messages.dart';

class ESignUpController extends GetxController {
  RxBool isCheck = false.obs;
  GetStorage box = GetStorage();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  Future<void> signUpClick() async {
    if (formKey.currentState!.validate()) {
      if (isCheck.value) {
        box.write(EStorageKey.eIsLogedIn, true);
        Get.offAllNamed(ERoutes.mainHome);
      } else {
        EShowMessgae.showWarning(
          message: 'Apply term and condition first',
        );
      }
    }
  }

  Future<void> signUpWithFacebookClick() async {
    box.write(EStorageKey.eIsLogedIn, true);
    Get.offAllNamed(ERoutes.mainHome);
  }
}
