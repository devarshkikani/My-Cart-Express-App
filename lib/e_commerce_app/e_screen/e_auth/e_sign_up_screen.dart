// ignore_for_file: avoid_print

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cart_express/e_commerce_app/e_constant/e_sizedbox.dart';
import 'package:my_cart_express/e_commerce_app/e_controller/e_auth/e_sign_up_contorller.dart';
import 'package:my_cart_express/e_commerce_app/e_routes/e_app_pages.dart';
import 'package:my_cart_express/e_commerce_app/e_theme/e_app_colors.dart';
import 'package:my_cart_express/e_commerce_app/e_theme/e_app_text_theme.dart';
import 'package:my_cart_express/e_commerce_app/e_widget/e_elevated_button.dart';
import 'package:my_cart_express/e_commerce_app/e_widget/e_input_text_field.dart';
import 'package:my_cart_express/e_commerce_app/e_widget/e_validator.dart';

class ESignUpScreen extends GetView<ESignUpController> {
  const ESignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Form(
                key: controller.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Welcome',
                      style: mediumText24,
                    ),
                    height10,
                    Text(
                      '''Please provide following details for your \nnew account''',
                      textAlign: TextAlign.center,
                      style: lightText14.copyWith(
                        color: tertiary,
                      ),
                    ),
                    height30,
                    TextFormFieldWidget(
                      hintText: 'Name',
                      controller: controller.name,
                      validator: (String? value) => Validators.validateText(
                        value,
                        'Name',
                      ),
                    ),
                    height15,
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
                    height10,
                    Row(
                      children: <Widget>[
                        Obx(
                          () => Checkbox(
                            value: controller.isCheck.value,
                            onChanged: (bool? value) {
                              controller.isCheck.value = value ?? false;
                            },
                          ),
                        ),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              text:
                                  '''By creating your account, you have to agree with our ''',
                              style: lightText14.copyWith(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Term and condition',
                                  style: regularText14.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    decoration: TextDecoration.underline,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => print('Tap Here onTap'),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    height10,
                    height30,
                    eElevatedButton(
                      context: context,
                      title: 'Sign Up',
                      onTap: () => controller.signUpClick(),
                    ),
                    height20,
                    eElevatedButton(
                      context: context,
                      backgroundColor: Theme.of(context).colorScheme.tertiary,
                      title: 'Sign up with facebook',
                      onTap: () => controller.signUpWithFacebookClick(),
                    ),
                    height30,
                    RichText(
                      text: TextSpan(
                        text: 'Already have an account? ',
                        style: lightText14.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Sign in',
                            style: regularText14.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Get.toNamed(ERoutes.signIn),
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
      ),
    );
  }
}
