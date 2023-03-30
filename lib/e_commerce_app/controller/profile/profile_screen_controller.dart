import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_cart_express/e_commerce_app/routes/app_pages.dart';

class ProfileScreenController extends GetxController {
  GetStorage box = GetStorage();

  void accountInfo() {
    Get.toNamed(Routes.accountInfo);
  }

  void logoutPressed() {
    box.erase();
    Get.offAllNamed(Routes.signUp);
  }
}
