import 'package:get/get.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_cart_express/theme/colors.dart';
import 'package:my_cart_express/theme/text_style.dart';
import 'package:my_cart_express/constant/sizedbox.dart';
import 'package:my_cart_express/constant/default_images.dart';
import 'package:my_cart_express/screens/authentication/sign_up/sign_up_screen.dart';
import 'package:my_cart_express/screens/authentication/sign_in/sign_in_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteMoke,
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Image.asset(
                      boxImage,
                    ),
                  ),
                  Text(
                    'Shopping online has never been easier with your preffered shipping partner',
                    style: regularText14.copyWith(
                      fontFamily: 'Montserrat',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: bottomView(),
          ),
        ],
      ),
    );
  }

  Widget bottomView() {
    return Container(
      padding: const EdgeInsets.all(20),
      width: Get.width,
      decoration: BoxDecoration(
        color: greyColor.withOpacity(0.15),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'Welcome to Mycart express 👋',
              style: regularText20,
            ),
            height20,
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
              ),
              onPressed: () {
                Get.to(
                  () => SignInScreen(),
                );
              },
              child: const Text(
                'LOG IN WITH EMAIL',
                style: TextStyle(
                  letterSpacing: 0.5,
                ),
              ),
            ),
            height20,
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Don't have an account? ",
                    style: lightText14,
                  ),
                  TextSpan(
                    text: 'Register',
                    style: regularText14.copyWith(
                      color: primary,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Get.to(
                          () => SignUpScreen(),
                        );
                      },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
