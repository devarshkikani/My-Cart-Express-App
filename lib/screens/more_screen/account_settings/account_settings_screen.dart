// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cart_express/constant/default_images.dart';
import 'package:my_cart_express/constant/sizedbox.dart';
import 'package:my_cart_express/screens/more_screen/account_settings/change_password_screen.dart';
import 'package:my_cart_express/screens/more_screen/more_screen.dart';
import 'package:my_cart_express/theme/colors.dart';
import 'package:my_cart_express/theme/text_style.dart';
import 'package:my_cart_express/widget/app_bar_widget.dart';

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
    return Column(
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
        // GestureDetector(
        //   onTap: () {
        //     Get.to(() => const EditProfileScreen())?.then((value) {
        //       if (value != null) {
        //         userDetails.value = value;
        //       }
        //     });
        //   },
        //   child: Container(
        //     padding: const EdgeInsets.all(15),
        //     decoration: BoxDecoration(
        //       color: greyColor.withOpacity(0.2),
        //       borderRadius: BorderRadius.circular(10),
        //     ),
        //     child: Row(
        //       children: [
        //         Container(
        //           height: 30,
        //           width: 30,
        //           decoration: BoxDecoration(
        //             color: primary,
        //             borderRadius: BorderRadius.circular(50),
        //           ),
        //           child: Image.asset(settingUserIcon),
        //         ),
        //         width10,
        //         const Text(
        //           'Edit Profile',
        //         ),
        //         const Spacer(),
        //         const Icon(
        //           Icons.arrow_forward_ios_rounded,
        //           size: 18,
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        // height10,
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
      ],
    );
  }

  Widget profileView() {
    return Obx(
      () => Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: userDetails['image'].toString() != ''
                ? Image.network(
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
            'User Code : ${userDetails.isEmpty ? '' : userDetails['mce_number'].toString()}',
            style: lightText16,
          ),
          height5,
          Text(
            'Email : ${userDetails.isEmpty ? '' : userDetails['email'].toString()}',
            style: lightText16,
          ),
          height5,
          Text(
            'Phone : ${userDetails.isEmpty ? '' : userDetails['phone'].toString()}',
            style: lightText16,
          ),
        ],
      ),
    );
  }
}
