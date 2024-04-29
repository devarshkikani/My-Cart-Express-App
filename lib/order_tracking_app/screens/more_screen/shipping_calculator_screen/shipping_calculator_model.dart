import 'package:flutter/material.dart';

class ShippingCalculatorModel {
  late TextEditingController category;
  late TextEditingController value;
  late TextEditingController estimated;
  late String? catId;
  late List rateGroupList;
  late List categoriesList;
  late Map? resultData;
  late int? categoryIndex;
  ShippingCalculatorModel({
    this.catId,
    required this.category,
    this.categoryIndex,
    required this.estimated,
    this.resultData,
    required this.value,
    required this.rateGroupList,
    required this.categoriesList,
  });
}
