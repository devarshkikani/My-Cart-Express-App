import 'package:flutter/material.dart';
import 'package:my_cart_express/order_tracking_app/constant/app_endpoints.dart';
import 'package:my_cart_express/order_tracking_app/screens/more_screen/shipping_calculator_screen/shipping_calculator_model.dart';
import 'package:my_cart_express/order_tracking_app/screens/more_screen/shipping_calculator_screen/shipping_calculator_view.dart';
import 'package:my_cart_express/order_tracking_app/utils/network_dio.dart';

class ShippingCalculatorPresenter {
  Future<void> getGropDetails(BuildContext context) async {}
  Future<void> calculateData(BuildContext context) async {}
  void catagoryName(int index) {}
  void onSelectedItemChanged(int index) {}
  void resetClick() {}
  void selectCategory(BuildContext context) {}
  set updateView(ShippingCalculatorView value) {}
}

class BasicShippingCalculatorPresenter implements ShippingCalculatorPresenter {
  late ShippingCalculatorModel _model;
  late ShippingCalculatorView _view;

  BasicShippingCalculatorPresenter() {
    _model = ShippingCalculatorModel(
      category: TextEditingController(),
      estimated: TextEditingController(),
      value: TextEditingController(),
      categoriesList: [],
      rateGroupList: [],
    );
    _view = ShippingCalculatorView();
  }

  @override
  set updateView(ShippingCalculatorView value) {
    _view = value;
    _view.refreshModel(_model);
  }

  @override
  Future<void> getGropDetails(BuildContext context) async {
    Map<String, dynamic>? response = await NetworkDio.getDioHttpMethod(
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.calculatorProduct,
      context: context,
    );
    if (response != null) {
      _model.categoriesList = response['data']['categories'];
    }
    _view.refreshModel(_model);
  }

  @override
  Future<void> calculateData(context) async {
    Map<String, dynamic>? response = await NetworkDio.getDioHttpMethod(
      url:
          '${ApiEndPoints.apiEndPoint}${ApiEndPoints.calculateRate}category_id=${_model.catId}&value_cost=${_model.value.text}&weight=${_model.estimated.text}',
      context: context,
    );
    if (response != null) {
      _model.resultData = {
        "freight_cost": response['freight_cost'],
        "clearance_fee_jmd": response["clearance_fee_jmd"],
        "processing_fee": response["processing_fee"],
        "tax": response["tax"],
        "amount": response["amount"]
      };
    }
    _view.refreshModel(_model);
  }

  @override
  void catagoryName(int index) {
    _model.categoryIndex = index;
    _view.refreshModel(_model);
  }

  @override
  void selectCategory(BuildContext context) {
    _model.category.text =
        _model.categoriesList[_model.categoryIndex ?? 0]['cat_name'];
    _model.catId = _model.categoriesList[_model.categoryIndex ?? 0]['id'];
    _view.refreshModel(_model);
    Navigator.pop(context);
  }

  @override
  void resetClick() {
    _model.category.clear();
    _model.value.clear();
    _model.estimated.clear();
    _model.resultData?.clear();
    _view.refreshModel(_model);
  }

  @override
  void onSelectedItemChanged(int index) {
    _model.categoryIndex = index;
    _view.refreshModel(_model);
  }
}
