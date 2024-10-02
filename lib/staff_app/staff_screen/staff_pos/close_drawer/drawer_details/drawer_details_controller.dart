import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cart_express/order_tracking_app/constant/app_endpoints.dart';
import 'package:my_cart_express/order_tracking_app/utils/network_dio.dart';

class DrawerDetailsController extends GetxController {
  Future<void> drawerDetails(BuildContext context) async {
    Map<String, dynamic>? response = await NetworkDio.getDioHttpMethod(
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.drawerDetails,
      context: context,
    );
    if (response != null && response['success'] == 200) {
      update();
    } else {
      NetworkDio.showError(title: "Error", errorMessage: response!['message']);
    }
  }
}
