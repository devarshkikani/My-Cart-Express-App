import 'package:flutter/material.dart';
import 'package:my_cart_express/constant/default_images.dart';
import 'package:my_cart_express/screens/delivery_screen/delivery_screen.dart';
import 'package:my_cart_express/screens/home_screen/home_screen.dart';
import 'package:my_cart_express/screens/more_screen/more_screen.dart';
import 'package:my_cart_express/screens/scanner_screen/scanner_screen.dart';
import 'package:my_cart_express/screens/shipping_screen/shipping_screen.dart';
import 'package:my_cart_express/theme/colors.dart';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  int selectedIndex = 0;
  final pages = [
    const HomeScreen(),
    const ScannerScreen(),
    const ShippingScreen(
      isFromeHome: false,
    ),
    const DeliveryScreen(),
    const MoreScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
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
                  selectedIndex = 0;
                  setState(() {});
                },
                child: Image.asset(
                  homeIcon,
                  color: selectedIndex == 0 ? null : Colors.grey,
                  height: 24,
                  width: 24,
                ),
              ),
              GestureDetector(
                onTap: () {
                  selectedIndex = 1;
                  setState(() {});
                },
                child: Image.asset(
                  scannerIcon,
                  color: selectedIndex == 1 ? null : Colors.grey,
                  height: 24,
                  width: 24,
                ),
              ),
              GestureDetector(
                onTap: () {
                  selectedIndex = 2;
                  setState(() {});
                },
                child: Image.asset(
                  shippingIcon,
                  color: selectedIndex == 2 ? null : Colors.grey,
                  height: 24,
                  width: 24,
                ),
              ),
              GestureDetector(
                onTap: () {
                  selectedIndex = 3;
                  setState(() {});
                },
                child: Image.asset(
                  deliveryIcon,
                  color: selectedIndex == 3 ? null : Colors.grey,
                  height: 24,
                  width: 24,
                ),
              ),
              GestureDetector(
                onTap: () {
                  selectedIndex = 4;
                  setState(() {});
                },
                child: Icon(
                  Icons.more_horiz_rounded,
                  color: selectedIndex == 4 ? primary : Colors.grey,
                  size: 30,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
