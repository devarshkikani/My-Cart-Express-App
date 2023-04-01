import 'package:get/get.dart';
import 'package:my_cart_express/e_commerce_app/e_routes/e_app_pages.dart';

class ESplashScreenController extends GetxController {
  @override
  void onInit() {
    Future<dynamic>.delayed(
      const Duration(
        seconds: 3,
      ),
      () => Get.toNamed(ERoutes.firstOnboarding),
    );
    super.onInit();
  }
}
