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
import 'package:my_cart_express/e_commerce_app/e_routes/e_app_pages.dart';
import 'package:my_cart_express/order_tracking_app/constant/app_endpoints.dart';
import 'package:my_cart_express/order_tracking_app/constant/storage_key.dart';
import 'package:my_cart_express/order_tracking_app/screens/authentication/welcome_screen.dart';
import 'package:my_cart_express/order_tracking_app/constant/default_images.dart';
import 'package:my_cart_express/order_tracking_app/screens/home/main_home_screen.dart';
import 'package:my_cart_express/order_tracking_app/screens/more_screen/add_feedback_screen.dart';
import 'package:my_cart_express/order_tracking_app/screens/more_screen/support/support_chat_screen.dart';
import 'package:my_cart_express/order_tracking_app/screens/not_verify/not_verify_screen.dart';
import 'package:my_cart_express/order_tracking_app/utils/network_dio.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static GetStorage box = GetStorage();
  RxMap userDetails = {}.obs;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), redirectScreen);
    firebaseNotificationSetup();
  }

  Future<void> redirectScreen() async {
    if (box.read(StorageKey.isECommerce) == true) {
      Get.offAndToNamed(ERoutes.firstOnboarding); //e commerce
    } else {
      // order tracking app
      if (box.read(StorageKey.isLogedIn) == true) {
        if (box.read(StorageKey.isRegister) == false) {
          await getUserDetails();
        } else {
          Get.offAll(
            () => MainHomeScreen(
              selectedIndex: 0.obs,
            ),
          );
        }
      } else {
        Get.offAll(() => const WelcomeScreen());
      }
    }
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
          () => MainHomeScreen(selectedIndex: 0.obs),
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

    var initSetttings = InitializationSettings(
      android: const AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {},
      ),
    );

    await FlutterLocalNotificationsPlugin().initialize(
      initSetttings,
      onDidReceiveBackgroundNotificationResponse: receiveNotification,
      onDidReceiveNotificationResponse: receiveNotification,
    );

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage? message) async {
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

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(onMessageOpenedApp);
  }

  static Future<void> receiveNotification(NotificationResponse response) async {
    await onSelectNotification(json.decode(response.payload!));
  }

  static Future<void> onMessageOpenedApp(RemoteMessage? message) async {
    await onSelectNotification(message?.data);
  }

  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await showNotification(
      message.notification!.title.toString(),
      message.notification!.body.toString(),
      json.encode(message.data),
    );
    log("Handling a background message ${message.notification?.title}");
  }

  static Future showNotification(
      String title, String message, dynamic payload) async {
    await FlutterLocalNotificationsPlugin().show(
      0,
      title,
      message,
      const NotificationDetails(
        iOS: DarwinNotificationDetails(),
        android: AndroidNotificationDetails(
          'channel id',
          'channel NAME',
          channelDescription: 'CHANNEL DESCRIPTION',
          priority: Priority.high,
          importance: Importance.max,
          playSound: true,
          fullScreenIntent: true,
          enableVibration: true,
        ),
      ),
      payload: payload,
    );
  }

  static Future onSelectNotification(Map<String, dynamic>? payloadData) async {
    if (payloadData != null) {
      log(payloadData.toString());
      if (box.read(StorageKey.isLogedIn) ?? false) {
        if (payloadData['page_id'] == '1') {
          Get.offAll(
            () => MainHomeScreen(selectedIndex: 2.obs),
          );
        } else if (payloadData['page_id'] == '2') {
          Get.offAll(
            () => AddFeedbackScreen(
              id: payloadData['ref_id'],
            ),
          );
        } else if (payloadData['page_id'] == '3') {
          Get.offAll(
            () => SupportChatScreen(
              isFromHome: false,
              data: {
                'title': 'Support Chat',
                'ticket_id': payloadData['ref_id'],
              },
            ),
          );
        } else if (payloadData['page_id'] == '4') {
          Get.offAll(
            () => MainHomeScreen(selectedIndex: 4.obs),
          );
        } else {
          Get.offAll(
            () => MainHomeScreen(selectedIndex: 0.obs),
          );
        }
      } else {
        Get.offAll(() => const WelcomeScreen());
      }
    }
  }
}
