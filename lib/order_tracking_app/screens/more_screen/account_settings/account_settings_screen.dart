// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cart_express/order_tracking_app/constant/default_images.dart';
import 'package:my_cart_express/order_tracking_app/constant/sizedbox.dart';
import 'package:my_cart_express/order_tracking_app/screens/more_screen/account_settings/change_email_address_screen.dart';
import 'package:my_cart_express/order_tracking_app/screens/more_screen/account_settings/change_name_screen.dart';
import 'package:my_cart_express/order_tracking_app/screens/more_screen/account_settings/change_number.dart';
import 'package:my_cart_express/order_tracking_app/screens/more_screen/account_settings/change_password_screen.dart';
import 'package:my_cart_express/order_tracking_app/screens/more_screen/more_screen.dart';
import 'package:my_cart_express/order_tracking_app/theme/colors.dart';
import 'package:my_cart_express/order_tracking_app/theme/text_style.dart';
import 'package:my_cart_express/order_tracking_app/widget/app_bar_widget.dart';
import 'package:my_cart_express/order_tracking_app/widget/network_image_handle.dart';

class AccountSettingsScreen extends StatefulWidget {
  const AccountSettingsScreen({super.key});

  @override
  State<AccountSettingsScreen> createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends State<AccountSettingsScreen> {
  RxMap userDetails = {}.obs;

  @override
  void initState() {
    userDetails.value = MoreScreenState.userDetails;
    super.initState();
  }

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
    return SingleChildScrollView(
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Account Setting',
              style: regularText18,
            ),
          ),
          height20,
          profileView(),
          height20,
          GestureDetector(
            onTap: () {
              Get.to(() => const ChangeNameScreen());
            },
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: greyColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: primary,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Icon(Icons.person, color: whiteColor),
                  ),
                  width10,
                  const Text(
                    'Change Name',
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
          height10,
          GestureDetector(
            onTap: () {
              Get.to(() => const ChangePasswordScreen());
            },
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: greyColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: primary,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Image.asset(settingLockIcon),
                  ),
                  width10,
                  const Text(
                    'Change Password',
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
          height10,
          GestureDetector(
            onTap: () {
              Get.to(() => const ChangeNumberScreen());
            },
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: greyColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: primary,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Icon(Icons.call, color: whiteColor, size: 18),
                  ),
                  width10,
                  const Text(
                    'Change Phone Numer',
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
          height10,
          GestureDetector(
            onTap: () {
              Get.to(() => const ChangeEmailAddressScreen());
            },
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: greyColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: primary,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Icon(
                      Icons.email_rounded,
                      color: whiteColor,
                      size: 18,
                    ),
                  ),
                  width10,
                  const Text(
                    'Change Email Address',
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget profileView() {
    return Obx(
      () => Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: userDetails['image'].toString() != ''
                ? networkImage(
                    userDetails['image'].toString(),
                    height: 100,
                    width: 100,
                  )
                : Image.asset(
                    dummyProfileImage,
                    height: 100,
                    width: 100,
                  ),
          ),
          height20,
          Text(
            userDetails.isEmpty ? '' : userDetails['name'].toString(),
            style: regularText18.copyWith(
              color: blackColor,
              letterSpacing: 0.3,
            ),
          ),
          height5,
          Text(
            'User Code : ${userDetails.isEmpty ? '' : userDetails['mce_number'] ?? ''}',
            style: lightText16,
          ),
          height5,
          Text(
            'Membership Type : ${userDetails.isEmpty ? '' : userDetails['price_group_name'] ?? ''}',
            style: lightText16,
          ),
          height5,
          Text(
            'Email : ${userDetails.isEmpty ? '' : userDetails['email'] ?? ''}',
            style: lightText16,
          ),
          height5,
          Text(
            'Phone : ${userDetails.isEmpty ? '' : userDetails['phone'] ?? ''}',
            style: lightText16,
          ),
        ],
      ),
    );
  }
}
