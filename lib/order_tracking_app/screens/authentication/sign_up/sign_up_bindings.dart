import 'package:get/get.dart';
import 'package:my_cart_express/order_tracking_app/screens/authentication/sign_up/sign_up_controller.dart';

class SignupBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpController>(() => SignUpController());
  }
}
