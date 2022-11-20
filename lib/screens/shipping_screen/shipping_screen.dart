import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cart_express/constant/sizedbox.dart';
import 'package:my_cart_express/screens/shipping_screen/packages_details_screen.dart';
import 'package:my_cart_express/theme/colors.dart';
import 'package:my_cart_express/theme/text_style.dart';

class ShippingScreen extends StatefulWidget {
  const ShippingScreen({super.key, required this.isFromeHome});
  final bool isFromeHome;
  @override
  State<ShippingScreen> createState() => _ShippingScreenState();
}

class _ShippingScreenState extends State<ShippingScreen> {
  String shortByString = 'Sort By';
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
                leading: widget.isFromeHome
                    ? IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          Platform.isAndroid
                              ? Icons.arrow_back_rounded
                              : Icons.arrow_back_ios_rounded,
                          color: whiteColor,
                        ),
                      )
                    : const SizedBox(),
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
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Shipments',
              style: regularText14,
            ),
            Text(
              shortByString,
              style: regularText14.copyWith(
                color: Colors.grey,
              ),
            ),
            GestureDetector(
              onTap: () {
                showBottomSheet(context);
              },
              child: Row(
                children: [
                  Text(
                    'Short by',
                    style: regularText14,
                  ),
                  const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: primary,
                  ),
                ],
              ),
            ),
          ],
        ),
        height15,
        Expanded(
          child: shippingList(),
        ),
      ],
    );
  }

  Widget shippingList() {
    return ListView.separated(
      itemCount: 10,
      separatorBuilder: (BuildContext context, int index) => height20,
      itemBuilder: (BuildContext context, int index) => InkWell(
        onTap: () {
          Get.to(() => const MyPackagesDetailsScreen());
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.10),
                offset: const Offset(0.0, 2.0),
                spreadRadius: 1,
                blurRadius: 5,
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.5),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Button',
                        style: regularText14.copyWith(
                          color: primary,
                        ),
                      ),
                      const VerticalDivider(
                        color: primary,
                      ),
                      Row(
                        children: const [
                          Text(
                            'Value : ',
                          ),
                          Text(
                            '0.0 ',
                            style: TextStyle(
                              color: primary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                color: greyColor.withOpacity(0.2),
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    const Expanded(
                      child: Icon(
                        Icons.shopping_bag_rounded,
                        size: 40,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'PKG8',
                            style: regularText14.copyWith(
                              color: primary,
                            ),
                          ),
                          height10,
                          Text(
                            '1234567867646464646546546469',
                            overflow: TextOverflow.ellipsis,
                            style: regularText14.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                          height10,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '8LB',
                                overflow: TextOverflow.ellipsis,
                                style: regularText14.copyWith(
                                  color: Colors.grey,
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.grey,
                                size: 14,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.5),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "TOTAL COST : 5468.00",
                        style: mediumText14.copyWith(
                          color: blackColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (BuildContext context) {
        return SizedBox(
          height: 250,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: CupertinoPicker(
                  itemExtent: 40,
                  magnification: 1.33,
                  squeeze: 1.2,
                  useMagnifier: true,
                  looping: true,
                  onSelectedItemChanged: (int value) {
                    setState(() {
                      shortByString = 'Hello';
                    });
                  },
                  children: List.generate(
                    10,
                    (index) => Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        'Hello',
                        style: mediumText18.copyWith(
                          color: primary,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    maximumSize: Size(Get.width, 50),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'SELECT',
                    style: TextStyle(
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
              height10,
            ],
          ),
        );
      },
    );
  }
}
