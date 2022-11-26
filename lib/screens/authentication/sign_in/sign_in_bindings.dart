import 'package:get/get.dart';
import 'package:my_cart_express/screens/authentication/sign_in/sign_in_controller.dart';

class SignInBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignInController>(() => SignInController());
  }
}
