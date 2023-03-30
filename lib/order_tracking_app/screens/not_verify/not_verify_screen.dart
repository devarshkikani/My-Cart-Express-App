// ignore_for_file: must_be_immutable

import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_cart_express/order_tracking_app/constant/app_endpoints.dart';
import 'package:my_cart_express/order_tracking_app/constant/default_images.dart';
import 'package:my_cart_express/order_tracking_app/theme/colors.dart';
import 'package:my_cart_express/order_tracking_app/theme/text_style.dart';
import 'package:my_cart_express/order_tracking_app/constant/sizedbox.dart';
import 'package:my_cart_express/order_tracking_app/utils/network_dio.dart';

class NotVerifyScreen extends StatefulWidget {
  NotVerifyScreen({super.key, required this.userDetails});
  Map userDetails;

  @override
  State<NotVerifyScreen> createState() => _NotVerifyScreenState();
}

class _NotVerifyScreenState extends State<NotVerifyScreen> {
  RxMap userDetails = {}.obs;
  GetStorage box = GetStorage();

  @override
  void initState() {
    super.initState();
    if (widget.userDetails.isEmpty) {
      getUserDetails();
    } else {
      userDetails.value = widget.userDetails;
    }
  }

  Future<void> getUserDetails() async {
    Map<String, dynamic>? response = await NetworkDio.getDioHttpMethod(
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.userInfo,
      context: context,
    );

    if (response != null) {
      userDetails.value = response['data'];
    }
  }

  Future<void> resendVerificationEmail() async {
    final data = dio.FormData.fromMap(
      {
        'user_id': userDetails['user_id'],
      },
    );
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.resendVerificationEmail,
      context: context,
      data: data,
    );

    if (response != null) {
      NetworkDio.showSuccess(
        title: "Success",
        sucessMessage: response['message'],
      );
    }
  }

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
                leading: const SizedBox(),
                centerTitle: true,
                elevation: 0.0,
                title: const Text(
                  'MyCartExpress',
                ),
              ),
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
    return SingleChildScrollView(
      child: Column(
        children: [
          profileView(),
          height10,
          Text(
            'Congratulations,',
            style: mediumText24.copyWith(
              color: error,
            ),
          ),
          height10,
          Text(
            'You are one step closer to start \nshipping with us!',
            textAlign: TextAlign.center,
            style: regularText18.copyWith(
              color: Colors.grey.shade700,
            ),
          ),
          height30,
          Text(
            'Verify your email for your free USA shipping Address',
            textAlign: TextAlign.center,
            style: regularText20.copyWith(
                // color: Colors.grey.shade700,
                ),
          ),
          height30,
          Text(
            'Visit your mail inbox',
            textAlign: TextAlign.center,
            style: regularText18.copyWith(
              color: Colors.grey.shade700,
            ),
          ),
          height10,
          Obx(
            () => Text(
              userDetails.isEmpty ? '' : userDetails['email'].toString(),
              textAlign: TextAlign.center,
              style: regularText18,
            ),
          ),
          height30,
          Text(
            'Email Verification needed',
            textAlign: TextAlign.center,
            style: regularText18.copyWith(
              color: secondary,
            ),
          ),
          height10,
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(Get.width / 2, 50),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
            ),
            onPressed: () async {
              await resendVerificationEmail();
            },
            child: const Text(
              'Resend Verification Email',
              style: TextStyle(
                letterSpacing: 1,
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
            child: userDetails['image'].toString().isEmpty ||
                    userDetails['image'] == null
                ? Image.asset(
                    dummyProfileImage,
                    height: 100,
                    width: 100,
                  )
                : Image.network(
                    userDetails['image'].toString(),
                    fit: BoxFit.cover,
                    height: 100,
                    width: 100,
                  ),
          ),
          height10,
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
          height5,
          const Divider(),
        ],
      ),
    );
  }
}
