import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_cart_express/constant/storage_key.dart';
import 'package:my_cart_express/models/user_model.dart';
import 'package:my_cart_express/screens/authentication/welcome_screen.dart';
import 'package:my_cart_express/screens/home/main_home_screen.dart';

class MoreScreenController extends GetxController {
  GetStorage box = GetStorage();
  late UserModel userModel;

  @override
  void onInit() {
    userModel = UserModel.fromJson(box.read(StorageKey.currentUser));
    super.onInit();
  }

  Future<void> logOutOnTap(BuildContext context) async {
    box.erase();
    MainHomeScreen.selectedIndex.value = 0;
    Get.offAll(
      () => const WelcomeScreen(),
    );
  }
}
