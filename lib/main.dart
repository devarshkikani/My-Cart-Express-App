// ignore_for_file: depend_on_referenced_packages
// import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/formatters/phone_input_formatter.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_cart_express/my_cart_express_app.dart';
import 'package:my_cart_express/order_tracking_app/utils/global_singleton.dart';
import 'package:my_cart_express/order_tracking_app/utils/network_dio.dart';
import 'package:package_info_plus/package_info_plus.dart';
// import 'package:flutter_windowmanager/flutter_windowmanager.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  NetworkDio.setDynamicHeader();
  await Firebase.initializeApp();
  GlobalSingleton.packageInfo = await PackageInfo.fromPlatform();
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  
  PhoneInputFormatter.addAlternativePhoneMasks(
    countryCode: 'US',
    alternativeMasks: [
      '+0 (000) 000-0000',
    ],
  );
  runApp(const MyCartExpressApp());
}

// Future<void> _disableScreenshotsAndroid() async {
//   try {
//     await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
//   } on PlatformException catch (e) {
//     if (kDebugMode) {
//       print("Error disabling screenshots on Android: ${e.message}");
//     }
//   }
// }
