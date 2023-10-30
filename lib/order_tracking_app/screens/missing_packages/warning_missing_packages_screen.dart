import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cart_express/order_tracking_app/constant/sizedbox.dart';
import 'package:my_cart_express/order_tracking_app/screens/messages_screen/messages_screen.dart';
import 'package:my_cart_express/order_tracking_app/screens/missing_packages/missing_packages_screen.dart';
import 'package:my_cart_express/order_tracking_app/screens/notification_screen/notifications_screen.dart';
import 'package:my_cart_express/order_tracking_app/theme/colors.dart';
import 'package:my_cart_express/order_tracking_app/theme/text_style.dart';

class WarningMissingPackagesScreen extends StatelessWidget {
  const WarningMissingPackagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.height,
        color: primary,
        child: SafeArea(
          child: Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                centerTitle: true,
                elevation: 0.0,
                leading: const SizedBox(),
                title: Text(
                  'MyCartExpress',
                  style: regularText20.copyWith(
                    color: whiteColor,
                  ),
                ),
                actions: [
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const MessagesScreen());
                    },
                    child: const Icon(
                      Icons.mail_outline_rounded,
                      color: whiteColor,
                    ),
                  ),
                  width15,
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const NotificationScreen());
                    },
                    child: const Icon(
                      Icons.notifications_active_outlined,
                      color: whiteColor,
                    ),
                  ),
                  width15,
                ],
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(
                    left: 15,
                    top: 15,
                    right: 15,
                  ),
                  width: Get.width,
                  decoration: const BoxDecoration(
                    color: offWhite,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: bodyView(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget bodyView(BuildContext context) {
    return Column(
      children: [
        Text(
          'Missing Package',
          style: mediumText18.copyWith(color: error),
        ),
        height30,
        Text(
          "A Package is deemed missing only if more than 3 Business days have passed without an update in the Mycart Express App.",
          style: regularText16.copyWith(color: error),
        ),
        height10,
        Text(
          "The most common reasons for missing packages are incorrectly addressed packages and your merchant/shipper not including your MCE number on your package.",
          style: regularText16.copyWith(color: error),
        ),
        height10,
        Text(
          "Please ensure all packages are addressed corectly and your MCE# is placed on all future packages.",
          style: regularText16.copyWith(color: error),
        ),
        height30,
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: Size(Get.width / 2, 50),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
          ),
          onPressed: () {
            Get.to(() => const MissingPackagesScreen());
          },
          child: const Text(
            'Continue',
            style: TextStyle(
              letterSpacing: 1,
            ),
          ),
        ),
        height15,
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: Size(Get.width / 2, 50),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
          ),
          onPressed: () {
            Get.back();
          },
          child: const Text(
            'Back',
            style: TextStyle(
              letterSpacing: 1,
            ),
          ),
        ),
      ],
    );
  }
}
