import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:my_cart_express/e_commerce_app/e_screen/e_cart/e_cart_screen.dart';
import 'package:my_cart_express/e_commerce_app/e_screen/e_category/e_category_screen.dart';
import 'package:my_cart_express/e_commerce_app/e_screen/e_home/e_home_page.dart';
import 'package:my_cart_express/e_commerce_app/e_screen/e_favorites/e_favorites_screen.dart';
import 'package:my_cart_express/e_commerce_app/e_screen/e_profile/e_profile_screen.dart';

class EMainHomeController extends GetxController {
  GlobalKey<CurvedNavigationBarState> bottomNavigationKey = GlobalKey();
  List<Widget> pageList = <Widget>[
    const EHomePage(),
    const ECategoryScreen(),
    const EFavoritesScreen(),
    const ECartScreen(),
    const EProfileScreen(),
  ];

  RxInt page = 0.obs;

  void navIconTap(int index) {
    page.value = index;
  }
}
