import 'package:get/get.dart';
import 'package:my_cart_express/e_commerce_app/routes/app_pages.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    Future<dynamic>.delayed(
      const Duration(
        seconds: 3,
      ),
      () => Get.toNamed(Routes.firstOnboarding),
    );
    super.onInit();
  }
}
