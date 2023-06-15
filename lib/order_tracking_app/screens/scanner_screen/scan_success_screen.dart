import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cart_express/e_commerce_app/e_constant/e_sizedbox.dart';
import 'package:my_cart_express/e_commerce_app/e_theme/e_app_text_theme.dart';
import 'package:my_cart_express/order_tracking_app/constant/default_images.dart';
import 'package:my_cart_express/order_tracking_app/screens/more_screen/available_packages.dart';
import 'package:my_cart_express/order_tracking_app/theme/colors.dart';
import 'package:my_cart_express/order_tracking_app/widget/app_bar_widget.dart';

class ScanSuccessScreen extends StatefulWidget {
  const ScanSuccessScreen({
    super.key,
    required this.availablePackages,
    required this.availablePackagesData,
  });
  final RxList availablePackages;
  final RxMap availablePackagesData;

  @override
  State<ScanSuccessScreen> createState() => _ScanSuccessScreenState();
}

class _ScanSuccessScreenState extends State<ScanSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.height,
        color: primary,
        child: Column(
          children: [
            appBarWithAction(),
            Expanded(
              child: Container(
                width: Get.width,
                padding: const EdgeInsets.all(15),
                decoration: const BoxDecoration(
                  color: offWhite,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: bodyView(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget bodyView() {
    return Column(
      children: [
        height30,
        height30,
        Image.asset(
          successCheck,
        ),
        height10,
        Text(
          'Success!',
          style: mediumText24.copyWith(letterSpacing: .5),
        ),
        height20,
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            'Thank you for making it myCart Express! \nYour packages will be with you shortly.You may take a seat and listen out for your name.',
            textAlign: TextAlign.center,
            style: regularText14.copyWith(letterSpacing: .5),
          ),
        ),
        height30,
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: Size(Get.width * .5, 50),
            maximumSize: Size(Get.width, 50),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
          ),
          onPressed: () {
            Get.to(
              AvailablePackagesScreen(
                fromHome: false,
                availablePackages: widget.availablePackages,
                availablePackagesData: widget.availablePackagesData,
              ),
            );
          },
          child: const Text(
            'Continue',
            style: TextStyle(
              letterSpacing: 1,
            ),
          ),
        ),
        height30,
      ],
    );
  }
}
