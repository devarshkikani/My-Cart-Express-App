import 'package:get/get.dart';
import 'package:my_cart_express/screens/authentication/sign_up/sign_up_controller.dart';

class SignUpBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpController>(() => SignUpController());
  }
}
