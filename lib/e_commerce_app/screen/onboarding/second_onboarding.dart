import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cart_express/e_commerce_app/constant/default_image.dart';
import 'package:my_cart_express/e_commerce_app/constant/sizedbox.dart';
import 'package:my_cart_express/e_commerce_app/routes/app_pages.dart';
import 'package:my_cart_express/e_commerce_app/screen/onboarding/third_onboarding.dart';
import 'package:my_cart_express/e_commerce_app/theme/app_colors.dart';
import 'package:my_cart_express/e_commerce_app/theme/app_text_theme.dart';
import 'package:my_cart_express/e_commerce_app/widget/elevated_button.dart';

class SecondOnboarding extends StatelessWidget {
  const SecondOnboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Image.asset(
              deliveryTruck,
              height: 300,
            ),
          ),
          height20,
          Text(
            'Fast Delivery',
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
            child: elevatedButton(
              context: context,
              title: 'Next',
              onTap: () {
                Get.to(() => const ThirdOnboarding());
              },
            ),
          ),
          height10,
          TextButton(
            onPressed: () {
              Get.toNamed(Routes.signUp);
            },
            child: Text(
              'Skip',
              style: regularText16.copyWith(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
