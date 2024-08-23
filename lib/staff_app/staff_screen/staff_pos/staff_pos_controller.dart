import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:my_cart_express/order_tracking_app/constant/app_endpoints.dart';
import 'package:my_cart_express/order_tracking_app/models/branches_model.dart';
import 'package:my_cart_express/order_tracking_app/utils/network_dio.dart';

class StaffPosController extends GetxController {
  RxList<Branches> branchesList = <Branches>[].obs;
  RxInt branchIndex = 0.obs;
  RxString branchId = '0'.obs;
  TextEditingController branchName = TextEditingController();

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
  }
}
