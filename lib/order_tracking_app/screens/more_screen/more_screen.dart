// ignore_for_file: use_build_context_synchronously, body_might_complete_normally_catch_error

import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_cart_express/order_tracking_app/screens/home_screen/home_screen_controller.dart';
import 'package:my_cart_express/order_tracking_app/theme/colors.dart';
import 'package:my_cart_express/order_tracking_app/theme/text_style.dart';
import 'package:my_cart_express/order_tracking_app/constant/sizedbox.dart';
import 'package:my_cart_express/order_tracking_app/utils/network_dio.dart';
import 'package:my_cart_express/order_tracking_app/constant/app_endpoints.dart';
import 'package:my_cart_express/order_tracking_app/constant/default_images.dart';
import 'package:my_cart_express/order_tracking_app/screens/more_screen/faqs_screen.dart';
import 'package:my_cart_express/order_tracking_app/screens/more_screen/feedback_screen.dart';
import 'package:my_cart_express/order_tracking_app/screens/authentication/welcome_screen.dart';
import 'package:my_cart_express/order_tracking_app/screens/more_screen/my_rewards_screen.dart';
import 'package:my_cart_express/order_tracking_app/screens/more_screen/transaction_screen.dart';
import 'package:my_cart_express/order_tracking_app/screens/messages_screen/messages_screen.dart';
import 'package:my_cart_express/order_tracking_app/screens/more_screen/support/support_index_screen.dart';
import 'package:my_cart_express/order_tracking_app/screens/notification_screen/notifications_screen.dart';
import 'package:my_cart_express/order_tracking_app/screens/more_screen/auth_pickup/auth_pickup_screen.dart';
import 'package:my_cart_express/order_tracking_app/screens/more_screen/account_settings/account_settings_screen.dart';
import 'package:my_cart_express/order_tracking_app/screens/more_screen/shipping_calculator_screen/shipping_calculator_screen.dart';
import 'package:permission_handler/permission_handler.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => MoreScreenState();
}

class MoreScreenState extends State<MoreScreen> {
  CarouselController carouselController = CarouselController();

  GetStorage box = GetStorage();
  static RxMap userDetails = {}.obs;
  final ImagePicker picker = ImagePicker();
  String? profilePicture = '';
  final List categoryList = [
    'Shipping Calculator',
    'Transaction',
    "FAQ's",
    'Support Center',
    'Feedback',
    'My Rewards',
    'Auth Pickup',
  ];

  final List iconList = [
    calcultorIcon,
    transactionIcon,
    faqsIcon,
    supportMailIcon,
    feedbackIcon,
    myRewardIcon,
    pickupIcon,
  ];

  void categoryOntap(int index) {
    if (index == 0) {
      Get.to(
        () => const ShippingCalculatorScreen(),
      );
    } else if (index == 1) {
      Get.to(() => const TransactionScreen());
    } else if (index == 2) {
      Get.to(() => const FAQSScreen());
    } else if (index == 3) {
      Get.to(() => const SupportIndexScreen());
    } else if (index == 4) {
      Get.to(() => const FeedbackScreen());
    } else if (index == 5) {
      Get.to(() => const MyRewardsScreen());
    } else if (index == 6) {
      Get.to(() => const AuthPickUpScreen());
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

  Future<void> logOutOnTap() async {
    box.erase();
    Get.offAll(
      () => const WelcomeScreen(),
    );
  }

  Future<void> deleteOnTap(BuildContext ctttx) async {
    final data = dio.FormData.fromMap({
      'email': userDetails['email'],
    });
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.accountDelete,
      data: data,
      context: ctttx,
    );
    if (response != null) {
      box.erase();
      Get.offAll(
        () => const WelcomeScreen(),
      );
    }
  }

  Future getImageUrl(File file) async {
    final data = dio.FormData.fromMap({
      'file': await dio.MultipartFile.fromFile(
        file.path,
        filename: file.path.split('/').last,
      )
    });
    final Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
      context: context,
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.uploadProfilePicture,
      data: data,
    );
    if (response != null) {
      Get.back();
      NetworkDio.showSuccess(
          title: 'Success', sucessMessage: response['message']);
      getUserDetails();
    }
  }

  showAlertDialog(BuildContext ctx) {
    showDialog(
      context: ctx,
      builder: (BuildContext ctttx) {
        return AlertDialog(
          title: const Text("Are you sure?"),
          content: const Text(
              "Are you sure you want delete the account if you tap on delete your account is permanently delete."),
          actions: [
            TextButton(
              child: const Text("cancel"),
              onPressed: () {
                Navigator.pop(ctttx);
              },
            ),
            TextButton(
              child: const Text("delete"),
              onPressed: () async {
                Navigator.pop(ctttx);
                await deleteOnTap(ctttx);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getUserDetails();
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
                backgroundColor: Colors.transparent,
                leading: const SizedBox(),
                centerTitle: true,
                elevation: 0.0,
                title: Text(
                  'My Account',
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
          Obx(
            () => imageList.isNotEmpty
                ? Stack(
                    alignment: Alignment.center,
                    children: [
                      CarouselSlider.builder(
                        itemCount: imageList.length,
                        carouselController: carouselController,
                        options: CarouselOptions(
                          enlargeCenterPage: true,
                          padEnds: true,
                          viewportFraction: 1.0,
                          height: 200,
                          autoPlay: imageList.length > 1,
                          scrollPhysics: imageList.length > 1
                              ? const AlwaysScrollableScrollPhysics()
                              : const NeverScrollableScrollPhysics(),
                          autoPlayInterval: const Duration(seconds: 6),
                        ),
                        itemBuilder: (context, i, id) {
                          return InkWell(
                            onTap: () {
                              redirectHome(i);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: Colors.white,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                  imageList[i]['image_url'],
                                  width: Get.width,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      if (imageList.length > 1)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 10),
                              height: 200,
                              width: 100,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15),
                                  topLeft: Radius.circular(15),
                                ),
                              ),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      carouselController.previousPage();
                                    },
                                    child: Image.asset(
                                      arrowLeft,
                                      height: 24,
                                      width: 24,
                                      color: whiteColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 200,
                              width: 100,
                              padding: const EdgeInsets.only(right: 10),
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      carouselController.nextPage();
                                    },
                                    child: Image.asset(
                                      arrowRight,
                                      height: 24,
                                      width: 24,
                                      color: whiteColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                    ],
                  )
                : const SizedBox(),
          ),
          Obx(() => imageList.isNotEmpty ? height10 : const SizedBox()),
          profileView(),
          categoryView(),
        ],
      ),
    );
  }

  Widget profileView() {
    return Obx(
      () => Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0, bottom: 8.0),
                child: ClipRRect(
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
              ),
              InkWell(
                onTap: () async {
                  final PermissionStatus status =
                      await Permission.camera.request();
                  if (status.isDenied || status.isPermanentlyDenied) {
                    await openAppSettings();
                  } else {
                    imageSelect();
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.add_a_photo_outlined,
                    color: whiteColor,
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
          height10,
          if (userDetails['image'].toString().isEmpty ||
              userDetails['image'] == null)
            Text(
              'Upload a selfie for collecting\nyour packages',
              textAlign: TextAlign.center,
              style: lightText12.copyWith(
                color: Colors.red,
              ),
            ),
          height10,
          if (userDetails.isNotEmpty)
            Text(
              userDetails['name'].toString(),
              style: regularText18.copyWith(
                color: blackColor,
                letterSpacing: 0.3,
              ),
            ),
          if (userDetails.isNotEmpty) height5,
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
          TextButton(
            onPressed: () {
              Get.to(
                () => const AccountSettingsScreen(),
              );
            },
            child: const Text(
              'Edit Profile',
            ),
          ),
        ],
      ),
    );
  }

  Widget categoryView() {
    return GridView.builder(
      itemCount: categoryList.length,
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1,
      ),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            categoryOntap(index);
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.all(8),
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              color: offWhite,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: blackColor.withOpacity(0.05),
                  spreadRadius: 0.5,
                  blurRadius: 2,
                  offset: const Offset(0.0, 2.0),
                ),
              ],
            ),
            child: Column(
              children: [
                Image.asset(
                  iconList[index],
                  height: 40,
                  width: 40,
                ),
                const Spacer(),
                Text(
                  categoryList[index],
                  style: lightText13,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showThreeDotDialog(BuildContext context) {
    showModalBottomSheet<int>(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext ctx) {
        return SafeArea(
          child: Container(
            height: 100,
            margin: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      Navigator.pop(ctx);
                      await logOutOnTap();
                    },
                    child: Center(
                      child: Text(
                        'Logout',
                        style: regularText16,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 1,
                  color: Colors.grey,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      Navigator.pop(ctx);
                      showAlertDialog(context);
                    },
                    child: Center(
                      child: Text(
                        'Delete',
                        style: regularText16.copyWith(color: primary),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> imageSelect() async {
    final XFile? image = await picker
        .pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.front,
    )
        .catchError((e) {
      if (kDebugMode) {
        print(e);
      }
    });
    if (image != null) {
      final CroppedFile? croppedImage = await ImageCropper().cropImage(
        sourcePath: image.path,
        maxWidth: 1080,
        maxHeight: 1080,
      );
      if (croppedImage != null) {
        await getImageUrl(File(croppedImage.path));
      }
    }
  }

  Widget imagePickerDecoration({
    required String type,
    required Function() onTap,
  }) {
    return InkWell(
      onTap: onTap,
      splashColor: primary,
      hoverColor: primary,
      highlightColor: primary,
      focusColor: primary,
      child: Container(
        height: 110,
        width: 110,
        padding: const EdgeInsets.symmetric(
          vertical: 10,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              type == 'Gallery'
                  ? Icons.photo_library_outlined
                  : Icons.add_a_photo_rounded,
            ),
            height15,
            Text(
              type,
              style: regularText16,
            ),
          ],
        ),
      ),
    );
  }
}
