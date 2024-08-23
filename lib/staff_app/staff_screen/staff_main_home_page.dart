import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cart_express/staff_app/staff_controller/staff_main_home_controller.dart';

import '../../e_commerce_app/e_theme/e_app_colors.dart';

class StaffMainHome extends GetView<StaffMainHomeController> {
  const StaffMainHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => controller.pageList[controller.page.value]),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          key: controller.bottomNavigationKey,
          currentIndex: controller.page.value,
          items: controller.getNavigationBarItems(),
          backgroundColor: Theme.of(context).colorScheme.background,
          unselectedIconTheme: const IconThemeData(color: blackColor),
          unselectedLabelStyle: const TextStyle(color: blackColor),
          unselectedItemColor: blackColor,
          showUnselectedLabels: true,
          onTap: (int index) {
            controller.navIconTap(index);
          },
        ),
      ),
    );
  }

  Color iconColor(int index) {
    return controller.page.value == index ? whiteColor : blackColor;
  }
}
