// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:my_cart_express/order_tracking_app/constant/sizedbox.dart';
import 'package:my_cart_express/order_tracking_app/models/user_model.dart';
import 'package:my_cart_express/order_tracking_app/screens/authentication/otp/otp_screen.dart';
import 'package:my_cart_express/order_tracking_app/screens/home_screen/home_screen_controller.dart';
import 'package:my_cart_express/order_tracking_app/theme/colors.dart';
import 'package:my_cart_express/e_commerce_app/e_routes/e_app_pages.dart';
import 'package:my_cart_express/order_tracking_app/utils/dynamic_linking_service.dart';
import 'package:my_cart_express/order_tracking_app/utils/global_singleton.dart';
import 'package:my_cart_express/order_tracking_app/utils/network_dio.dart';
import 'package:my_cart_express/order_tracking_app/constant/storage_key.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:my_cart_express/order_tracking_app/constant/app_endpoints.dart';
import 'package:my_cart_express/order_tracking_app/constant/default_images.dart';
import 'package:my_cart_express/order_tracking_app/screens/home/main_home_screen.dart';
import 'package:my_cart_express/order_tracking_app/screens/not_verify/not_verify_screen.dart';
import 'package:my_cart_express/order_tracking_app/screens/authentication/welcome_screen.dart';
import 'package:my_cart_express/order_tracking_app/screens/more_screen/support/support_chat_screen.dart';
import 'package:my_cart_express/staff_app/staff_binding/staff_main_home_binding..dart';
import 'package:my_cart_express/staff_app/staff_screen/staff_main_home_page.dart';
import 'package:url_launcher/url_launcher.dart';

import 'order_tracking_app/screens/home_screen/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  GetStorage boxx = GetStorage();
  boxx.write(StorageKey.notificationResponse, message.data);
  log('${message.data}++++++++++++');
  await _SplashScreenState.showNotification(
    message.notification!.title.toString(),
    message.notification!.body.toString(),
    json.encode(message.data),
  );
  log("Handling a background message ${message.notification?.title}");
}

class _SplashScreenState extends State<SplashScreen> {
  static GetStorage box = GetStorage();

  @override
  void initState() {
    super.initState();
    callCommonAPI();
    firebaseNotificationSetup();
    box.remove(StorageKey.notificationResponse);
  }

  Future<void> callCommonAPI() async {
    await DynamicRepository().initDynamicLinks();
    Map<String, dynamic>? commonSettings = await NetworkDio.getDioHttpMethod(
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.commonSettings,
    );
    if (commonSettings != null) {
      showLocation.value = commonSettings['show_location'];
      if (Platform.isAndroid) {
        if (GlobalSingleton.packageInfo?.version !=
            commonSettings['android_version']) {
          showUpdateApp(context, commonSettings['force_update'] == "0");
        } else {
          redirectScreen();
        }
      } else {
        if (GlobalSingleton.packageInfo?.version !=
            commonSettings['app_version']) {
          showUpdateApp(context, commonSettings['force_update'] == "0");
        } else {
          redirectScreen();
        }
      }
    } else {
      redirectScreen();
    }
  }

  void showUpdateApp(BuildContext context, bool showLaterButton) {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) {
          return CupertinoAlertDialog(
            title: const Text(
              'New Update Available',
            ),
            content: const Text(
              'There is newer version of app available please update it now.',
            ),
            actions: [
              if (showLaterButton)
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                    redirectScreen();
                  },
                  child: const Text(
                    'Later',
                  ),
                ),
              if (showLaterButton) width10,
              TextButton(
                onPressed: () async {
                  String url =
                      "https://apps.apple.com/us/app/mycart-express/id1624277416";
                  if (await canLaunchUrl(Uri.parse(url))) {
                    await launchUrl(Uri.parse(url),
                        mode: LaunchMode.externalApplication);
                  }
                },
                child: const Text(
                  'Update Now',
                ),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) {
          return AlertDialog(
            title: const Text(
              'New Update Available',
            ),
            content: const Text(
              'There is newer version of app available please update it now.',
            ),
            actions: [
              if (showLaterButton)
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                    redirectScreen();
                  },
                  child: const Text(
                    'Later',
                  ),
                ),
              TextButton(
                onPressed: () async {
                  String url =
                      "https://play.google.com/store/apps/details?id=com.app.MyCartExpress";
                  if (await canLaunchUrl(Uri.parse(url))) {
                    await launchUrl(Uri.parse(url),
                        mode: LaunchMode.externalApplication);
                  }
                },
                child: const Text(
                  'Update Now',
                ),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> redirectScreen() async {
    if (box.read(StorageKey.isECommerce) == true) {
      Get.offAndToNamed(ERoutes.firstOnboarding); //e commerce
    } else {
      // order tracking app
      if (box.read(StorageKey.isLogedIn) == true) {
        await getUserDetails();
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
      GlobalSingleton.userDetails = response['data'];
      if (box.read(StorageKey.currentUser) != null) {
        GlobalSingleton.userLoginDetails =
            UserModel.fromJson(box.read(StorageKey.currentUser));
      }

      // if (GlobalSingleton.userLoginDetails != null &&
      //     GlobalSingleton.userLoginDetails!.isStaff == 1) {
      //   box.write(StorageKey.isRegister, true);
      //   // Get.to(() => OtpScreen());

      //   Get.offAll(
      //     () => const StaffMainHome(),
      //     binding: StaffMainHomeBinding(),
      //   );
      // } else
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
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
      ],
    );
    return Scaffold(
      backgroundColor: primary,
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
        defaultPresentAlert: true,
        defaultPresentBadge: true,
        defaultPresentSound: true,
        requestCriticalPermission: true,
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
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          sound: 'default',
          presentSound: true,
        ),
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
        callInitState = false;
        if (payloadData['page_id'] == '1') {
          Get.offAll(
            () => MainHomeScreen(selectedIndex: 2.obs),
          );
        } else if (payloadData['page_id'] == '2') {
          Get.offAll(
            () => MainHomeScreen(
              selectedIndex: 0.obs,
              id: payloadData['ref_id'],
              staffFirstname: payloadData['staff_firstname'],
              staffImage: payloadData['staff_image'],
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
