import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cart_express/e_commerce_app/e_widget/bottom_navigation/c_curved_navigation_bar.dart';
import 'package:my_cart_express/staff_app/staff_screen/staff_warehouse/staff_warehouse_screen.dart';
import 'package:my_cart_express/staff_app/staff_screen/staff_pos/staff_pos_screen.dart';
import 'package:my_cart_express/staff_app/staff_screen/staff_pickup_request/staff_pickup_request_screen.dart';

class StaffMainHomeController extends GetxController {
  GlobalKey<CurvedNavigationBarState> bottomNavigationKey = GlobalKey();
  List<Widget> pageList = <Widget>[
    const StaffWarehouseScreen(),
    const StaffPosScreen(),
    const StaffPickupRequestScreen(),
  ];

  RxInt page = 0.obs;

  void navIconTap(int index) {
    page.value = index;
  }
}
