import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
}
