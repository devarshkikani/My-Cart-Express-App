import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_cart_express/theme/colors.dart';
import 'package:my_cart_express/theme/text_style.dart';
import 'package:my_cart_express/constant/sizedbox.dart';
import 'package:my_cart_express/utils/network_dio.dart';
import 'package:my_cart_express/constant/app_endpoints.dart';
import 'package:my_cart_express/constant/default_images.dart';
import 'package:my_cart_express/screens/home/main_home_screen.dart';
import 'package:my_cart_express/screens/more_screen/faqs_screen.dart';
import 'package:my_cart_express/screens/more_screen/upload_screen.dart';
import 'package:my_cart_express/screens/more_screen/feedback_screen.dart';
import 'package:my_cart_express/screens/authentication/welcome_screen.dart';
import 'package:my_cart_express/screens/more_screen/my_rewards_screen.dart';
import 'package:my_cart_express/screens/more_screen/transaction_screen.dart';
import 'package:my_cart_express/screens/more_screen/available_packages.dart';
import 'package:my_cart_express/screens/messages_screen/messages_screen.dart';
import 'package:my_cart_express/screens/more_screen/support_index_screen.dart';
import 'package:my_cart_express/screens/notification_screen/notifications_screen.dart';
import 'package:my_cart_express/screens/more_screen/auth_pickup/auth_pickup_screen.dart';
import 'package:my_cart_express/screens/more_screen/account_settings/account_settings_screen.dart';
import 'package:my_cart_express/screens/more_screen/shipping_calculator_screen/shipping_calculator_screen.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => MoreScreenState();
}

class MoreScreenState extends State<MoreScreen> {
  GetStorage box = GetStorage();
  static RxMap userDetails = {}.obs;

  final List categoryList = [
    'Available Packages',
    'Shopping Calculator',
    'Transaction',
    "FAQ's",
    'Support Index',
    'Feedback',
    'My Rewards',
    'Auth Pickup',
    'Upload File',
  ];

  final List imageList = [
    shippingIcon,
    calcultorIcon,
    transactionIcon,
    faqsIcon,
    supportMailIcon,
    feedbackIcon,
    myRewardIcon,
    pickupIcon,
    uploadFileIcon
  ];

  void categoryOntap(int index) {
    if (index == 0) {
      Get.to(() => const AvailablePackagesScreen());
    } else if (index == 1) {
      Get.to(
        () => const ShippingCalculatorScreen(),
      );
    } else if (index == 2) {
      Get.to(() => const TransactionScreen());
    } else if (index == 3) {
      Get.to(() => const FAQSScreen());
    } else if (index == 4) {
      Get.to(() => const SupportIndexScreen());
    } else if (index == 5) {
      Get.to(() => const FeedbackScreen());
    } else if (index == 6) {
      Get.to(() => const MyRewardsScreen());
    } else if (index == 7) {
      Get.to(() => const AuthPickUpScreen());
    } else if (index == 8) {
      Get.to(() => const UploadFileScreen());
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

  Future<void> logOutOnTap(BuildContext context) async {
    box.erase();
    MainHomeScreen.selectedIndex.value = 0;
    Get.offAll(
      () => const WelcomeScreen(),
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
                leading: const SizedBox(),
                centerTitle: true,
                elevation: 0.0,
                title: const Text(
                  'MyCartExpress',
                ),
                actions: [
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const MessagesScreen());
                    },
                    child: const Icon(
                      Icons.mail_outline_rounded,
                    ),
                  ),
                  width15,
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const NotificationScreen());
                    },
                    child: const Icon(
                      Icons.notifications_active_outlined,
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
    return Column(
      children: [
        Row(
          children: [
            Text(
              'My Account',
              style: regularText18,
            ),
            const Spacer(),
            TextButton(
              onPressed: () async {
                await logOutOnTap(context);
              },
              style: ButtonStyle(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                minimumSize: MaterialStateProperty.all(
                  const Size(0, 0),
                ),
                padding: MaterialStateProperty.all(EdgeInsets.zero),
              ),
              child: Text(
                'Logout',
                style: regularText16,
              ),
            ),
            width15,
          ],
        ),
        height20,
        profileView(),
        Expanded(
          child: categoryView(),
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
            child: userDetails['image'].toString().isEmpty ||
                    userDetails['image'] == null
                ? Image.asset(
                    dummyProfileImage,
                    height: 100,
                    width: 100,
                  )
                : Image.network(
                    userDetails['image'].toString(),
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
            padding: const EdgeInsets.all(15),
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
                  imageList[index],
                  height: 40,
                  width: 40,
                ),
                const Spacer(),
                Text(
                  categoryList[index],
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
