import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cart_express/e_commerce_app/e_constant/e_sizedbox.dart';
import 'package:my_cart_express/e_commerce_app/e_controller/e_auth/e_sign_in_controller.dart';
import 'package:my_cart_express/e_commerce_app/e_routes/e_app_pages.dart';
import 'package:my_cart_express/e_commerce_app/e_theme/e_app_colors.dart';
import 'package:my_cart_express/e_commerce_app/e_theme/e_app_text_theme.dart';
import 'package:my_cart_express/e_commerce_app/e_widget/e_elevated_button.dart';
import 'package:my_cart_express/e_commerce_app/e_widget/e_input_text_field.dart';

class ESignInScreen extends GetView<ESignInController> {
  const ESignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Form(
              key: controller.formKey,
              child: Column(
                children: <Widget>[
                  height30,
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Sign In\nTo Account',
                      style: mediumText24,
                    ),
                  ),
                  height10,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Sign in with email and password to use \nyour account.',
                      style: lightText14.copyWith(
                        color: tertiary,
                      ),
                    ),
                  ),
                  height30,
                  EmailWidget(
                    hintText: 'Email',
                    controller: controller.email,
                  ),
                  height15,
                  PasswordWidget(
                    hintText: 'Password',
                    passType: 'Password',
                    showsuffixIcon: true,
                  ),
                  height30,
                  eElevatedButton(
                    context: context,
                    title: 'Sign In',
                    onTap: () => controller.signInClick(),
                  ),
                  height20,
                  eElevatedButton(
                    context: context,
                    backgroundColor: Theme.of(context).colorScheme.tertiary,
                    title: 'Sign in with facebook',
                    onTap: () => controller.signUpWithFacebookClick(),
                  ),
                  height30,
                  RichText(
                    text: TextSpan(
                      text: "Don't have an account? ",
                      style: lightText14.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Sign up',
                          style: regularText14.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Get.toNamed(ERoutes.signUp),
                        )
                      ],
                    ),
                  ),
                  height15,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
