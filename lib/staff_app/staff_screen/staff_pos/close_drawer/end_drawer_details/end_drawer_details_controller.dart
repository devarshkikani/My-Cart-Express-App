// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:my_cart_express/order_tracking_app/constant/app_endpoints.dart';
import 'package:my_cart_express/order_tracking_app/utils/network_dio.dart';
import 'package:my_cart_express/staff_app/staff_model/drawer_end_details_model.dart';

class EndDrawerDetailsController extends GetxController {
  TextEditingController bagHashController = TextEditingController();
  TextEditingController cashsummedController = TextEditingController();
  TextEditingController cardreceiptsummedController = TextEditingController();
  Rx<StaffList>? dropdownValue;
  Rx<DrawerEndDetailsData> drawerDetailsData = DrawerEndDetailsData().obs;
  Rx<String> baghasImagePath = ''.obs;
  Rx<String> varifiedByImagePath = ''.obs;
  Future<void> drawerDetails(
      BuildContext context, String drawerId, String initalAmount) async {
    final data = dio.FormData.fromMap(
        {'is_init_amount_returned': initalAmount, 'cash_drawer_id': drawerId});

    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
        url: ApiEndPoints.apiEndPoint + ApiEndPoints.drawerEnd,
        context: context,
        data: data);
    if (response != null && response['success'] == 200) {
      drawerDetailsData.value = DrawerEndDetailsModel.fromJson(response).data!;
      bagHashController.text =
          drawerDetailsData.value.drawerDetails!.bagHash.toString();
      update();
    } else {
      NetworkDio.showError(title: "Error", errorMessage: response!['message']);
    }
  }

  Future<void> closedDrawerApi(
      BuildContext context,
      String bagHash,
      String verifiedby,
      String cashdrwerId,
      String cashsummed,
      String cardreceiptsummed) async {
    final data = dio.FormData.fromMap({
      "bag_hash": bagHash,
      "cash_summed": cashsummed,
      'card_receipt_summed': cardreceiptsummed,
      "verified_by": verifiedby,
      "cash_drawer_id": cashdrwerId,
      "bag_hash_image": await dio.MultipartFile.fromFile(
        baghasImagePath.value,
      ),
      "verified_by_image":
          await dio.MultipartFile.fromFile(varifiedByImagePath.value),
    });

    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
        url: ApiEndPoints.apiEndPoint + ApiEndPoints.closedDrawer,
        context: context,
        data: data);
    if (response != null && response['status'] == 200) {
      NetworkDio.showSuccess(
          title: "Success", sucessMessage: response['message']);
      Future.delayed(const Duration(seconds: 5), () {
        Get.back();
        Get.back();
      });
      //  {"status":200,"message":"Drawer closed successfully"}
    } else {
      NetworkDio.showError(title: "Error", errorMessage: response!['message']);
    }
  }
}
