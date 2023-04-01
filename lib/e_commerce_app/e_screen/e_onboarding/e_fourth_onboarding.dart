import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cart_express/e_commerce_app/e_constant/e_default_image.dart';
import 'package:my_cart_express/e_commerce_app/e_constant/e_sizedbox.dart';
import 'package:my_cart_express/e_commerce_app/e_routes/e_app_pages.dart';
import 'package:my_cart_express/e_commerce_app/e_theme/e_app_colors.dart';
import 'package:my_cart_express/e_commerce_app/e_theme/e_app_text_theme.dart';
import 'package:my_cart_express/e_commerce_app/e_widget/e_elevated_button.dart';

class EFourthOnboarding extends StatelessWidget {
  const EFourthOnboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Image.asset(
              securePayment,
              height: 300,
            ),
          ),
          height20,
          Text(
            'Secure Payment',
            style: mediumText24.copyWith(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              '''Neque porro quisquam est qui dolorem ipsum quia dolor sit adipisci velit...''',
              textAlign: TextAlign.center,
              style: regularText16.copyWith(
                color: tertiary,
              ),
            ),
          ),
          height10,
          SizedBox(
            width: 300,
            child: eElevatedButton(
              context: context,
              title: 'Continue',
              onTap: () {
                Get.offAllNamed(ERoutes.signUp);
              },
            ),
          ),
        ],
      ),
    );
  }
}
