import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as b;
import 'package:my_cart_express/order_tracking_app/screens/home/main_home_screen.dart';
import 'package:my_cart_express/order_tracking_app/screens/home_screen/home_screen.dart';
import 'package:my_cart_express/order_tracking_app/theme/colors.dart';
import 'package:my_cart_express/e_commerce_app/e_constant/e_sizedbox.dart';
import 'package:my_cart_express/e_commerce_app/e_theme/e_app_text_theme.dart';
import 'package:my_cart_express/order_tracking_app/constant/default_images.dart';
import 'package:my_cart_express/order_tracking_app/screens/more_screen/available_packages.dart';

class ScanSuccessScreen extends StatefulWidget {
  const ScanSuccessScreen({
    super.key,
    required this.barcode,
    required this.successMessage,
    required this.availablePackages,
    required this.availablePackagesData,
  });
  final String barcode;
  final String successMessage;
  final RxList availablePackages;
  final RxMap availablePackagesData;

  @override
  State<ScanSuccessScreen> createState() => _ScanSuccessScreenState();
}

class _ScanSuccessScreenState extends State<ScanSuccessScreen> {
  RxInt selectedIndex = 1.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.height,
        color: primary,
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
                child: bodyView(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 80,
        padding: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          color: greyColor.withOpacity(0.2),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  callInitState = false;
                  Get.offAll(
                    () => MainHomeScreen(selectedIndex: 0.obs),
                  );
                },
                child: Image.asset(
                  homeIcon,
                  color: selectedIndex.value == 0 ? null : Colors.grey,
                  height: 24,
                  width: 24,
                ),
              ),
              GestureDetector(
                onTap: () {
                  callInitState = false;
                  Get.offAll(
                    () => MainHomeScreen(selectedIndex: 1.obs),
                  );
                },
                child: Image.asset(
                  scannerIcon,
                  color: selectedIndex.value == 1 ? null : Colors.grey,
                  height: 24,
                  width: 24,
                ),
              ),
              GestureDetector(
                onTap: () {
                  callInitState = false;
                  Get.offAll(
                    () => MainHomeScreen(selectedIndex: 2.obs),
                  );
                },
                child: b.Badge(
                  showBadge: packageCounts.value > 0,
                  badgeStyle: const b.BadgeStyle(
                    shape: b.BadgeShape.instagram,
                  ),
                  badgeContent: Text(
                    '${packageCounts.value}',
                    style: lightText12.copyWith(
                      color: whiteColor,
                    ),
                  ),
                  child: Image.asset(
                    shippingIcon,
                    color: selectedIndex.value == 2 ? null : Colors.grey,
                    height: 24,
                    width: 24,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  callInitState = false;
                  Get.offAll(
                    () => MainHomeScreen(selectedIndex: 3.obs),
                  );
                },
                child: b.Badge(
                  showBadge: availablePackageCounts.value > 0,
                  badgeStyle: const b.BadgeStyle(
                    shape: b.BadgeShape.instagram,
                  ),
                  badgeContent: Text(
                    '${availablePackageCounts.value}',
                    style: lightText12.copyWith(
                      color: whiteColor,
                    ),
                  ),
                  child: Image.asset(
                    availablePackagesIcon,
                    color: selectedIndex.value == 3 ? null : Colors.grey,
                    height: 24,
                    width: 24,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  callInitState = false;
                  Get.offAll(
                    () => MainHomeScreen(selectedIndex: 4.obs),
                  );
                },
                child: b.Badge(
                  showBadge: overduePackageCounts.value > 0,
                  badgeStyle: const b.BadgeStyle(
                    shape: b.BadgeShape.instagram,
                  ),
                  badgeContent: Text(
                    '${overduePackageCounts.value}',
                    style: lightText12.copyWith(
                      color: whiteColor,
                    ),
                  ),
                  child: Image.asset(
                    deliveryIcon,
                    color: selectedIndex.value == 4 ? null : Colors.grey,
                    height: 24,
                    width: 24,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  callInitState = false;
                  Get.offAll(
                    () => MainHomeScreen(selectedIndex: 5.obs),
                  );
                },
                child: Icon(
                  Icons.more_horiz_rounded,
                  color: selectedIndex.value == 5 ? primary : Colors.grey,
                  size: 30,
                ),
              ),
            ],
          ),
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
            widget.successMessage.isNotEmpty
                ? widget.successMessage
                : 'Thank you for making it myCart Express! \nYour packages will be with you shortly.You may take a seat and listen out for your name.',
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
                title: 'Packages for pickup',
                barcode: widget.barcode,
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
