import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_cart_express/constant/app_endpoints.dart';
import 'package:my_cart_express/constant/storage_key.dart';
import 'package:my_cart_express/models/branches_model.dart';
import 'package:my_cart_express/models/user_model.dart';
import 'package:my_cart_express/screens/home/main_home_screen.dart';
import 'package:my_cart_express/utils/network_dio.dart';

class SignUpController extends GetxController {
  GetStorage box = GetStorage();
  RxList<Branches> branchesList = <Branches>[].obs;
  List<String> typeList = <String>['Business Customer', 'Person'];
  RxString type = ''.obs;
  RxString branchId = ''.obs;

  @override
  void onInit() {
    getBranches();
    super.onInit();
  }

  Future<void> getBranches() async {
    Map<String, dynamic>? response = await NetworkDio.getDioHttpMethod(
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.branches,
    );
    if (response != null) {
      for (var i = 0; i < response['data'].length; i++) {
        branchesList.add(Branches.fromJson(response['data'][i]));
      }
    }
  }

  Future<void> signUpOnTap({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String passwordConfirm,
    required String branchId,
    required String gid,
    String? legalBusinessName,
    String? businessContactPerson,
    String? positionInCompany,
    required BuildContext context,
  }) async {
    final data = dio.FormData.fromMap(
      gid == '1'
          ? {
              'firstname': firstName,
              'email': email,
              'password': password,
              'lastname': lastName,
              'password_confirm': passwordConfirm,
              'branch_id': branchId,
              'g_id': gid,
            }
          : {
              'firstname': firstName,
              'lastname': lastName,
              'email': email,
              'password': password,
              'password_confirm': passwordConfirm,
              'branch_id': branchId,
              'person_dd': '',
              'legal_business_name': legalBusinessName,
              'business_contact_person': businessContactPerson,
              'position_in_company': positionInCompany,
              'g_id': gid,
              'ipaddress': '',
              'device_unique_value': '',
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
      Get.offAll(
        () => MainHomeScreen(),
      );
    }
  }
}
