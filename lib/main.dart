// ignore_for_file: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/phone_input_formatter.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_cart_express/my_cart_express_app.dart';
import 'package:my_cart_express/utils/network_dio.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  NetworkDio.setDynamicHeader();
  await Firebase.initializeApp(
      // options: DefaultFirebaseOptions.currentPlatform,
      );
  PhoneInputFormatter.addAlternativePhoneMasks(
    countryCode: 'US',
    alternativeMasks: [
      '+0 (000) 000-0000',
    ],
  );
  runApp(const MyCartExpressApp());
}
