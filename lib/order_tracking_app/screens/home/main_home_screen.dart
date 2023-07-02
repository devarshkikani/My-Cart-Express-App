// ignore_for_file: must_be_immutable

import 'package:badges/badges.dart' as b;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cart_express/order_tracking_app/constant/default_images.dart';
import 'package:my_cart_express/order_tracking_app/screens/overdue_screen/overdue_screen.dart';
import 'package:my_cart_express/order_tracking_app/screens/home_screen/home_screen.dart';
import 'package:my_cart_express/order_tracking_app/screens/more_screen/more_screen.dart';
import 'package:my_cart_express/order_tracking_app/screens/more_screen/available_packages.dart';
import 'package:my_cart_express/order_tracking_app/screens/scanner_screen/scanner_screen.dart';
import 'package:my_cart_express/order_tracking_app/screens/shipping_screen/shipping_screen.dart';
import 'package:my_cart_express/order_tracking_app/theme/colors.dart';
import 'package:my_cart_express/order_tracking_app/theme/text_style.dart';

RxInt packageCounts = 0.obs;
RxInt availablePackageCounts = 0.obs;
RxInt overduePackageCounts = 0.obs;

class MainHomeScreen extends GetView {
  MainHomeScreen({
    super.key,
    required this.selectedIndex,
  });

  RxInt selectedIndex;
  final pages = [
    const HomeScreen(),
    const ScannerScreen(),
    const ShippingScreen(
      isFromeHome: false,
    ),
    const AvailablePackagesScreen(fromHome: true),
    const OverdueScreen(),
    const MoreScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: pages[selectedIndex.value],
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
                    selectedIndex.value = 0;
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
                    selectedIndex.value = 1;
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
                    selectedIndex.value = 2;
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
                    selectedIndex.value = 3;
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
                    selectedIndex.value = 4;
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
                    selectedIndex.value = 5;
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
      ),
    );
  }
}
