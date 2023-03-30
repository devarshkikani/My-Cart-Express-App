import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:my_cart_express/e_commerce_app/screen/cart/cart_screen.dart';
import 'package:my_cart_express/e_commerce_app/screen/category/category_screen.dart';
import 'package:my_cart_express/e_commerce_app/screen/home/home_page.dart';
import 'package:my_cart_express/e_commerce_app/screen/favorites/favorites_screen.dart';
import 'package:my_cart_express/e_commerce_app/screen/profile/profile_screen.dart';

class MainHomeController extends GetxController {
  GlobalKey<CurvedNavigationBarState> bottomNavigationKey = GlobalKey();
  List<Widget> pageList = <Widget>[
    const HomePage(),
    const CategoryScreen(),
    const FavoritesScreen(),
    const CartScreen(),
    const ProfileScreen(),
  ];

  RxInt page = 0.obs;

  void navIconTap(int index) {
    page.value = index;
  }
}
