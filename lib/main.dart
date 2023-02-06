// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/phone_input_formatter.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_cart_express/my_cart_express_app.dart';
import 'package:my_cart_express/utils/network_dio.dart';

void main() async {
  await GetStorage.init();
  NetworkDio.setDynamicHeader();
  PhoneInputFormatter.addAlternativePhoneMasks(
    countryCode: 'US',
    alternativeMasks: [
      '+0 (000) 000-0000',
    ],
  );
  runApp(const MyCartExpressApp());
}
