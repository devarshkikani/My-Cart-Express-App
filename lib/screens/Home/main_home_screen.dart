import 'package:flutter/material.dart';
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
        height: 60,
        decoration: BoxDecoration(
          color: greyColor.withOpacity(0.2),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              enableFeedback: false,
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: () {
                selectedIndex = 0;
                setState(() {});
              },
              icon: Icon(
                Icons.widgets_rounded,
                color: selectedIndex == 0 ? primary : Colors.grey,
                size: 25,
              ),
            ),
            IconButton(
              enableFeedback: false,
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: () {
                selectedIndex = 1;
                setState(() {});
              },
              icon: Icon(
                Icons.qr_code_scanner_outlined,
                color: selectedIndex == 1 ? primary : Colors.grey,
                size: 25,
              ),
            ),
            IconButton(
              enableFeedback: false,
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: () {
                selectedIndex = 2;
                setState(() {});
              },
              icon: Icon(
                Icons.local_shipping_rounded,
                color: selectedIndex == 2 ? primary : Colors.grey,
                size: 25,
              ),
            ),
            IconButton(
              enableFeedback: false,
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: () {
                selectedIndex = 3;
                setState(() {});
              },
              icon: Icon(
                Icons.delivery_dining_rounded,
                color: selectedIndex == 3 ? primary : Colors.grey,
                size: 25,
              ),
            ),
            IconButton(
              enableFeedback: false,
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: () {
                selectedIndex = 4;
                setState(() {});
              },
              icon: Icon(
                Icons.more_horiz_rounded,
                color: selectedIndex == 4 ? primary : Colors.grey,
                size: 25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
