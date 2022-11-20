import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cart_express/constant/sizedbox.dart';
import 'package:my_cart_express/theme/colors.dart';
import 'package:my_cart_express/theme/text_style.dart';
import 'package:timelines/timelines.dart';

class MyPackagesDetailsScreen extends StatefulWidget {
  const MyPackagesDetailsScreen({super.key});

  @override
  State<MyPackagesDetailsScreen> createState() =>
      _MyPackagesDetailsScreenState();
}

class _MyPackagesDetailsScreenState extends State<MyPackagesDetailsScreen> {
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
                leading: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Platform.isAndroid
                        ? Icons.arrow_back_rounded
                        : Icons.arrow_back_ios_rounded,
                  ),
                ),
                centerTitle: false,
                elevation: 0.0,
                title: const Text(
                  'My Packages > More',
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
        Container(
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
                        'Collected',
                        style: regularText14.copyWith(
                          color: primary,
                        ),
                      ),
                      const VerticalDivider(
                        color: primary,
                      ),
                      Row(
                        children: [
                          Text(
                            'Ontime : ',
                            style: regularText14.copyWith(
                              color: success,
                            ),
                          ),
                          const Text(
                            '06 Jun',
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
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.shopping_bag_rounded,
                          size: 50,
                        ),
                        width15,
                        Column(
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
                      ],
                    ),
                    height15,
                    Text(
                      "TOTAL COST : ",
                      style: mediumText14.copyWith(
                        color: blackColor,
                      ),
                    ),
                    height5,
                    Text(
                      "\$5468.00",
                      style: mediumText14.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        height25,
        Text(
          'Timeline',
          style: regularText16,
        ),
        height25,
        Expanded(
          child: Timeline.tileBuilder(
            padding: EdgeInsets.zero,
            theme: TimelineThemeData(nodePosition: -10.0),
            builder: TimelineTileBuilder.fromStyle(
              contentsAlign: ContentsAlign.basic,
              contentsBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  timeline[index],
                ),
              ),
              itemCount: 5,
            ),
          ),
        )
      ],
    );
  }

  List timeline = [
    'Recevied in Florida',
    'Airline Boked',
    'Custooms Booked',
    'Available for Pickup',
    'Collected',
  ];
}
