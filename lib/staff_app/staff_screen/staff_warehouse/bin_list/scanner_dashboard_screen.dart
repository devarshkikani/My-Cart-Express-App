import 'package:flutter/material.dart';
import 'package:my_cart_express/order_tracking_app/constant/default_images.dart';
import 'package:my_cart_express/order_tracking_app/constant/sizedbox.dart';
import 'package:my_cart_express/order_tracking_app/theme/colors.dart';
import 'package:my_cart_express/order_tracking_app/theme/text_style.dart';

class SannerDashboard extends StatefulWidget {
  const SannerDashboard({super.key});

  @override
  State<SannerDashboard> createState() => _SannerDashboardState();
}

class _SannerDashboardState extends State<SannerDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primarylite,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          height15,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 45),
            child: Text(
              "Go and scan all package for your bin",
              textAlign: TextAlign.center,
              style: mediumText20.copyWith(color: whiteColor),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Image.asset(
              scannerImage,
              height: 200,
              width: 200,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                'Get Start',
                style: mediumText18,
              ),
            ),
          )
        ],
      ),
    );
  }
}
