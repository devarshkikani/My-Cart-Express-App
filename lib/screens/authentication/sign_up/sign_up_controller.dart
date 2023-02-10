// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_cart_express/constant/app_endpoints.dart';
import 'package:my_cart_express/constant/storage_key.dart';
import 'package:my_cart_express/models/branches_model.dart';
import 'package:my_cart_express/models/user_model.dart';
import 'package:my_cart_express/screens/home/main_home_screen.dart';
import 'package:my_cart_express/screens/not_verify/not_verify_screen.dart';
import 'package:my_cart_express/utils/network_dio.dart';

class SignUpController extends GetxController {
  GetStorage box = GetStorage();
  RxList<Branches> branchesList = <Branches>[].obs;
  RxList locationList = [].obs;
  List<String> aboutMeList = <String>[
    "I've Shipped Before",
    "I'm Shipping on behalf of a Company",
    "I'm New to Shipping"
  ];
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailId = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController firstName = TextEditingController();
  final TextEditingController middleName = TextEditingController();
  final TextEditingController aboutme = TextEditingController();
  final TextEditingController branchName = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final TextEditingController location = TextEditingController();
  final TextEditingController businessName = TextEditingController();
  final TextEditingController businessContact = TextEditingController();
  final TextEditingController positionCompany = TextEditingController();
  RxString branchId = ''.obs;
  RxBool termsAndService = false.obs;
  RxBool privacyPolicy = false.obs;

  // @override
  // void onInit() {
  //   getBranches();
  //   super.onInit();
  // }

  Future<void> getBranches(BuildContext context) async {
    Map<String, dynamic>? response = await NetworkDio.getDioHttpMethod(
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.branches,
      context: context,
    );
    if (response != null) {
      for (var i = 0; i < response['data'].length; i++) {
        branchesList.add(Branches.fromJson(response['data'][i]));
      }
    }
    await getLocation(context);
  }

  Future<void> getLocation(BuildContext context) async {
    Map<String, dynamic>? response = await NetworkDio.getDioHttpMethod(
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.location,
      context: context,
    );
    if (response != null) {
      locationList.value = response['data'];
    }
  }

  Future<void> signUpOnTap({
    required BuildContext context,
  }) async {
    final data = dio.FormData.fromMap(
      {
        'about_me': aboutme.text.trim(),
        'firstname': firstName.text.trim(),
        'middlename': middleName.text.trim(),
        'lastname': lastName.text.trim(),
        'email': emailId.text.trim(),
        'phone': phoneNumber.text
            .replaceAll('(', '')
            .replaceAll(')', '')
            .replaceAll('-', '')
            .replaceAll(' ', ''),
        'location': location.text.trim(),
        'branch_id': branchId.value,
        'password': password.text.trim(),
        'password_confirm': password.text.trim(),
        'device': Platform.isAndroid ? 1 : 2,
        // 'g_id': '1',
        // 'person_dd': '',
        // 'ipaddress': '',
        // 'device_unique_value': '',
        // 'legal_business_name': businessName.text,
        // 'business_contact_person': businessContact.text,
        // 'position_in_company': positionCompany.text,
      },
    );
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
      context: context,
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.signUp,
      data: data,
    );
    if (response != null) {
      NetworkDio.showSuccess(
        title: "Success",
        sucessMessage: response['message'],
      );
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
