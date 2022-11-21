import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cart_express/constant/sizedbox.dart';
import 'package:my_cart_express/theme/colors.dart';
import 'package:my_cart_express/theme/text_style.dart';

class DeliveryScreen extends StatefulWidget {
  const DeliveryScreen({super.key});

  @override
  State<DeliveryScreen> createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.height,
        color: primary,
        child: SafeArea(
          child: Column(
            children: [
              AppBar(
                leading: const SizedBox(),
                centerTitle: true,
                elevation: 0.0,
                title: const Text(
                  'MyCartExpress',
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: const BoxDecoration(
                    color: offWhite,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: bodyView(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget bodyView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Overdue Packages',
              style: regularText18,
            ),
            const Spacer(),
            Text(
              'All',
              style: lightText14.copyWith(
                color: Colors.grey,
              ),
            ),
            width15,
            Text(
              'Sort by',
              style: lightText14.copyWith(
                color: Colors.grey,
              ),
            ),
          ],
        ),
        height10,
        Text(
          'TOTAL PACKAGES AVAILABLE :',
          style: regularText14.copyWith(
            color: Colors.grey,
          ),
        ),
        height10,
        duePackagesView(),
      ],
    );
  }

  Widget duePackagesView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'TOTAL DUE :',
          style: regularText14.copyWith(
            color: Colors.grey,
          ),
        ),
        height25,
        Center(
          child: Text(
            'No overdue packages found.',
            style: lightText14.copyWith(
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
