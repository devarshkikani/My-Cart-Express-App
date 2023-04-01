import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_cart_express/e_commerce_app/e_constant/e_storage_key.dart';
import 'package:my_cart_express/e_commerce_app/e_controller/e_theme_controller.dart';
import 'package:my_cart_express/e_commerce_app/e_routes/e_app_pages.dart';
import 'package:my_cart_express/order_tracking_app/constant/storage_key.dart';
import 'package:my_cart_express/order_tracking_app/screens/home/main_home_screen.dart';

class EProfileScreenController extends GetxController {
  GetStorage box = GetStorage();

  void accountInfo() {
    Get.toNamed(ERoutes.accountInfo);
  }

  void logoutPressed() {
    box.write(EStorageKey.eIsLogedIn, false);
    Get.offAllNamed(ERoutes.signUp);
  }

  Future<void> changeApp() async {
    Get.find<ThemeController>().isECommerce.value = false;
    box.write(StorageKey.isECommerce, false);
    Get.offAll(
      MainHomeScreen(
        selectedIndex: 0.obs,
      ),
    );
  }
}
