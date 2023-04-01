import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cart_express/e_commerce_app/e_controller/e_main_home/e_main_home_contoller.dart';
import 'package:my_cart_express/e_commerce_app/e_theme/e_app_colors.dart';

class EMainHome extends GetView<EMainHomeController> {
  const EMainHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => controller.pageList[controller.page.value]),
      bottomNavigationBar: CurvedNavigationBar(
        key: controller.bottomNavigationKey,
        index: 0,
        height: 70,
        letIndexChange: (int index) => true,
        items: <Widget>[
          Obx(() => Icon(
                Icons.home,
                size: 30,
                color: controller.page.value == 0 ? whiteColor : blackColor,
              )),
          Obx(() => Icon(
                Icons.menu_rounded,
                size: 30,
                color: controller.page.value == 1 ? whiteColor : blackColor,
              )),
          Obx(() => Icon(
                Icons.favorite_rounded,
                size: 30,
                color: controller.page.value == 2 ? whiteColor : blackColor,
              )),
          Obx(() => Icon(
                Icons.shopping_cart_rounded,
                size: 30,
                color: controller.page.value == 3 ? whiteColor : blackColor,
              )),
          Obx(() => Icon(
                Icons.person,
                size: 30,
                color: controller.page.value == 4 ? whiteColor : blackColor,
              )),
        ],
        color: Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
        buttonBackgroundColor: Theme.of(context).colorScheme.primary,
        backgroundColor: Theme.of(context).colorScheme.background,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 400),
        onTap: (int index) {
          controller.navIconTap(index);
        },
      ),
    );
  }

  Color iconColor(int index) {
    return controller.page.value == index ? whiteColor : blackColor;
  }
}
