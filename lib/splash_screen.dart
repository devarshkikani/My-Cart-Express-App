import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_cart_express/constant/app_endpoints.dart';
import 'package:my_cart_express/constant/storage_key.dart';
import 'package:my_cart_express/screens/authentication/welcome_screen.dart';
import 'package:my_cart_express/constant/default_images.dart';
import 'package:my_cart_express/screens/home/main_home_screen.dart';
import 'package:my_cart_express/screens/not_verify/not_verify_screen.dart';
import 'package:my_cart_express/utils/network_dio.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  GetStorage box = GetStorage();
  RxMap userDetails = {}.obs;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () async {
      if (box.read(StorageKey.isLogedIn) == true) {
        if (box.read(StorageKey.isRegister) == false) {
          await getUserDetails();
        } else {
          Get.offAll(
            () => MainHomeScreen(),
          );
        }
      } else {
        Get.offAll(() => const WelcomeScreen());
      }
    });
    firebaseNotificationSetup();
  }

  Future<void> getUserDetails() async {
    Map<String, dynamic>? response = await NetworkDio.getDioHttpMethod(
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.userInfo,
    );

    if (response != null) {
      userDetails.value = response['data'];
      if (response['data']['verify_email'] == '0') {
        Get.offAll(
          () => NotVerifyScreen(
            userDetails: response['data'],
          ),
        );
      } else {
        box.write(StorageKey.isRegister, true);
        Get.offAll(
          () => MainHomeScreen(),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
      body: Center(
        child: Image.asset(
          appLogo,
        ),
      ),
    );
  }

  Future<void> firebaseNotificationSetup() async {
    await Firebase.initializeApp();

    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    var initSetttings = const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: IOSInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      ),
    );

    flutterLocalNotificationsPlugin.initialize(initSetttings,
        onSelectNotification: onSelectNotification);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage? message) async {
      log('${message?.notification?.title}+++++');
      if (Platform.isIOS) {
        await showNotification(
          message!.notification!.title.toString(),
          message.notification!.body.toString(),
          json.encode(message.data),
        );
      }
      if (Platform.isAndroid) {
        String? title = message!.notification?.title;
        String? body = message.notification?.body;
        if (title != null && body != null) {
          await showNotification(
            title,
            body,
            json.encode(message.data),
          );
        }
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? message) {
      log('${message?.notification?.title}-----');

      if (Platform.isIOS) {
        onSelectNotification(json.encode(message!.data));
      } else {
        onSelectNotification(json.encode(message!.data));
      }
    });
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }

  Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await showNotification(
      message.notification!.title.toString(),
      message.notification!.body.toString(),
      json.encode(message.data),
    );
    log("Handling a background message ${message.notification?.title}");
  }

  Future showNotification(String title, String message, dynamic payload) async {
    AndroidNotificationDetails android = const AndroidNotificationDetails(
      'channel id',
      'channel NAME',
      channelDescription: 'CHANNEL DESCRIPTION',
      priority: Priority.high,
      importance: Importance.max,
      playSound: true,
    );

    var iOS = const IOSNotificationDetails();

    var platform = NotificationDetails(iOS: iOS, android: android);
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      message,
      platform,
      payload: payload,
    );
  }

  Future onSelectNotification(String? payloadData) async {
    dynamic payload = await json.decode(payloadData ?? '');
    log(payload.toString());
  }
}
