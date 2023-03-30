import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:my_cart_express/order_tracking_app/constant/app_endpoints.dart';
import 'package:my_cart_express/order_tracking_app/screens/authentication/sign_in/sign_in_screen.dart';
import 'package:my_cart_express/order_tracking_app/utils/network_dio.dart';
import 'package:my_cart_express/order_tracking_app/widget/validator.dart';
import 'package:my_cart_express/order_tracking_app/theme/text_style.dart';
import 'package:my_cart_express/order_tracking_app/constant/sizedbox.dart';
import 'package:my_cart_express/order_tracking_app/widget/app_bar_widget.dart';
import 'package:my_cart_express/order_tracking_app/widget/input_text_field.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({
    super.key,
  });

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final TextEditingController code = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarWidget(title: 'Change Password'),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  height20,
                  PasswordWidget(
                    labelText: 'Password',
                    passType: 'Password',
                    hintText: 'Enter password here',
                    controller: password,
                    textInputAction: TextInputAction.next,
                    showsuffixIcon: true,
                  ),
                  height20,
                  PasswordWidget(
                    labelText: 'Confirm Password',
                    passType: 'Confirm Password',
                    hintText: 'Enter confirm password here',
                    textInputAction: TextInputAction.next,
                    controller: confirmPassword,
                    showsuffixIcon: true,
                    validator: (value) =>
                        Validators.validatePassword(
                          value!.trim(),
                          'Confirm password',
                        ) ??
                        (value != password.text
                            ? 'Confirm Password does not match with password'
                            : null),
                  ),
                  height20,
                  TextFormFieldWidget(
                    labelText: 'Enter Authentication Code',
                    hintText: 'Enter authentication code here',
                    controller: code,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                  ),
                  height20,
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      maximumSize: Size(Get.width, 50),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        changePasswordOntap(context: context);
                      }
                    },
                    child: const Text(
                      'CHANGE PASSWORD',
                      style: TextStyle(
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.to(() => SignInScreen());
                    },
                    child: Text(
                      'Existing User Login Here',
                      style: lightText14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> changePasswordOntap({required BuildContext context}) async {
    final data = dio.FormData.fromMap({
      'code': code.text,
      'password': password.text,
      'password_confirm': confirmPassword.text,
    });
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.resetPassword,
      context: context,
      data: data,
    );
    if (response != null) {
      Get.back();
      Get.back();
      NetworkDio.showSuccess(
          title: 'Suceess', sucessMessage: response['message']);
    }
  }
}
