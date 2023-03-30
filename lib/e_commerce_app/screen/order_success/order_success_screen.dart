import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cart_express/e_commerce_app/constant/default_image.dart';
import 'package:my_cart_express/e_commerce_app/constant/sizedbox.dart';
import 'package:my_cart_express/e_commerce_app/routes/app_pages.dart';
import 'package:my_cart_express/e_commerce_app/theme/app_text_theme.dart';
import 'package:my_cart_express/e_commerce_app/widget/elevated_button.dart';
import 'package:my_cart_express/e_commerce_app/widget/outline_button.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                orderBookedIcon,
                height: 300,
              ),
              const Text(
                'Your order hase been successful',
                style: regularText18,
              ),
              height10,
              const Text(
                '''Thank you for the order you have made, you can see the update in notification ''',
                style: lightText14,
                textAlign: TextAlign.center,
              ),
              height20,
              SizedBox(
                width: Get.width * 0.8,
                child: elevatedButton(
                  context: context,
                  title: 'Track Order',
                  onTap: () {
                    Get.toNamed(Routes.trackOrder);
                  },
                ),
              ),
              height20,
              SizedBox(
                width: Get.width * 0.6,
                child: outlinedButton(
                  title: 'Continue shopping',
                  onTap: () {
                    Get.offAllNamed(Routes.mainHome);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
