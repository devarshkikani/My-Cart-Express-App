import 'package:get/get.dart';
import 'package:my_cart_express/order_tracking_app/screens/authentication/register/register_controller.dart';

class RegisterBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(() => RegisterController());
  }
}
