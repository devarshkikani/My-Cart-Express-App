// ignore_for_file: use_build_context_synchronously

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:my_cart_express/order_tracking_app/constant/app_endpoints.dart';
import 'package:my_cart_express/order_tracking_app/utils/network_dio.dart';
import 'package:dio/dio.dart' as dio;
import 'package:my_cart_express/staff_app/staff_model/get_staff_branches_model.dart';

class StaffPosController extends GetxController {
  // RxList<Branches> branchesList = <Branches>[].obs;
  RxInt branchIndex = 0.obs;
  RxString branchId = '0'.obs;
  TextEditingController initalAmount = TextEditingController();
  TextEditingController branchName = TextEditingController();
  List<StaffBranch> staffBranches = <StaffBranch>[].obs;
  Rx<DrawerDetails>? drawerDetails;

  // @override
  // void onInit() {
  //   getDrawerStatus();

  //   super.onInit();
  // }

  Future<void> getBranches(BuildContext context) async {
    Map<String, dynamic>? response = await NetworkDio.getDioHttpMethod(
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.getStaffBranches,
      context: context,
    );
    if (response != null) {
      staffBranches = GetStaffAllBranches.fromJson(response).staffBranches!;
    }
  }

  Future<void> getDrawerStatus(BuildContext context) async {
    Map<String, dynamic>? response = await NetworkDio.getDioHttpMethod(
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.getDrawerStatus,
      context: context,
    );
    if (response != null && response['message'] != "No drawer is opened") {
      drawerDetails =
          GetDrawerStatusModel.fromJson(response).drawerDetails!.obs;
    } else {
      getBranches(context);
    }

    update();
  }

  Future<void> startDrawer(
    BuildContext context,
    String initalAmount,
    String branchId,
  ) async {
    final data = dio.FormData.fromMap({
      "initial_amount": initalAmount,
      "branch_id": branchId,
    });
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.startDrawer,
      data: data,
      context: context,
    );
    if (response != null && response['status'] == 200) {
      getDrawerStatus(context);
      NetworkDio.showSuccess(
          title: "Success", sucessMessage: response['message']);
    } else {
      NetworkDio.showSuccess(
          title: "Error", sucessMessage: response!['message']);
    }
  }
}
