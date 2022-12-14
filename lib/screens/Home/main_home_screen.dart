import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cart_express/constant/default_images.dart';
import 'package:my_cart_express/screens/delivery_screen/delivery_screen.dart';
import 'package:my_cart_express/screens/home_screen/home_screen.dart';
import 'package:my_cart_express/screens/more_screen/more_screen.dart';
import 'package:my_cart_express/screens/more_screen/more_screen_controller.dart';
import 'package:my_cart_express/screens/scanner_screen/scanner_screen.dart';
import 'package:my_cart_express/screens/shipping_screen/shipping_screen.dart';
import 'package:my_cart_express/theme/colors.dart';

class MainHomeScreen extends GetView {
  MainHomeScreen({super.key});

  static RxInt selectedIndex = 0.obs;
  final pages = [
    const HomeScreen(),
    const ScannerScreen(),
    const ShippingScreen(
      isFromeHome: false,
    ),
    const DeliveryScreen(),
    GetBuilder(
      init: MoreScreenController(),
      builder: (moreController) => MoreScreen(),
    ),
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
                  child: Image.asset(
                    shippingIcon,
                    color: selectedIndex.value == 2 ? null : Colors.grey,
                    height: 24,
                    width: 24,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    selectedIndex.value = 3;
                  },
                  child: Image.asset(
                    deliveryIcon,
                    color: selectedIndex.value == 3 ? null : Colors.grey,
                    height: 24,
                    width: 24,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    selectedIndex.value = 4;
                  },
                  child: Icon(
                    Icons.more_horiz_rounded,
                    color: selectedIndex.value == 4 ? primary : Colors.grey,
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
