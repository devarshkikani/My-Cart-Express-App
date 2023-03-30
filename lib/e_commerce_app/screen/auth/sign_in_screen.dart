import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cart_express/e_commerce_app/constant/sizedbox.dart';
import 'package:my_cart_express/e_commerce_app/controller/auth/sign_in_controller.dart';
import 'package:my_cart_express/e_commerce_app/routes/app_pages.dart';
import 'package:my_cart_express/e_commerce_app/theme/app_colors.dart';
import 'package:my_cart_express/e_commerce_app/theme/app_text_theme.dart';
import 'package:my_cart_express/e_commerce_app/widget/elevated_button.dart';
import 'package:my_cart_express/e_commerce_app/widget/input_text_field.dart';

class SignInScreen extends GetView<SignInController> {
  const SignInScreen({super.key});

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
                  elevatedButton(
                    context: context,
                    title: 'Sign In',
                    onTap: () => controller.signInClick(),
                  ),
                  height20,
                  elevatedButton(
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
                            ..onTap = () => Get.toNamed(Routes.signUp),
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
