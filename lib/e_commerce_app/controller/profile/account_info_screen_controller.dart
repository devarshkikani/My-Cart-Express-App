import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cart_express/e_commerce_app/constant/enum.dart';

class AccountInfoScreenController extends GetxController {
  Rx<EditProfileType> editProfileType = EditProfileType.showDetails.obs;
  TextEditingController password = TextEditingController();
  TextEditingController confirm = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController birthDate = TextEditingController();

  void editProfileOnTap() {
    editProfileType.value = EditProfileType.editProfile;
  }

  void editPasswordOnTap() {
    editProfileType.value = EditProfileType.editPassword;
  }

  void saveProfileOnTap() {
    editProfileType.value = EditProfileType.showDetails;
  }

  void savePasswordOnTap() {
    editProfileType.value = EditProfileType.showDetails;
  }
}
