import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cart_express/constant/app_endpoints.dart';
import 'package:my_cart_express/utils/network_dio.dart';

RxList rateGroupList = [].obs;

RxList categoriesList = [].obs;

class ShippingCalculatorController extends GetxController {
  TextEditingController rate = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController value = TextEditingController();
  TextEditingController estimated = TextEditingController();
  RxString rateId = ''.obs;
  RxString catId = ''.obs;
  RxMap resultData = {}.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> getGropDetails(context) async {
    Map<String, dynamic>? response = await NetworkDio.getDioHttpMethod(
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.calculatorProduct,
      context: context,
    );
    if (response != null) {
      rateGroupList.value = response['data']['rate_groups'];
      categoriesList.value = response['data']['categories'];
    }
  }

  Future<void> calculateData(context) async {
    Map<String, dynamic>? response = await NetworkDio.getDioHttpMethod(
      url:
          '${ApiEndPoints.apiEndPoint}${ApiEndPoints.calculateRate}rate_group_id=$rateId&category_id=$catId&value_cost=${value.text}&weight=${estimated.text}',
      context: context,
    );
    if (response != null) {
      resultData.value = {
        "freight_cost": response['freight_cost'],
        "clearance_fee_jmd": response["clearance_fee_jmd"],
        "processing_fee": response["processing_fee"],
        "tax": response["tax"],
        "amount": response["amount"]
      };
    }
  }
}
