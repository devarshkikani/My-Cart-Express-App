// ignore_for_file: must_be_immutable

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cart_express/constant/app_endpoints.dart';
import 'package:my_cart_express/constant/sizedbox.dart';
import 'package:my_cart_express/theme/colors.dart';
import 'package:my_cart_express/theme/text_style.dart';
import 'package:my_cart_express/utils/network_dio.dart';
import 'package:timelines/timelines.dart';

class MyPackagesDetailsScreen extends StatefulWidget {
  Map packagesDetails = {}.obs;
  MyPackagesDetailsScreen({super.key, required this.packagesDetails});

  @override
  State<MyPackagesDetailsScreen> createState() =>
      _MyPackagesDetailsScreenState();
}

class _MyPackagesDetailsScreenState extends State<MyPackagesDetailsScreen> {
  @override
  void initState() {
    super.initState();
    getTrackingDetails();
  }

  getTrackingDetails() async {
    Map<String, dynamic>? response = await NetworkDio.getDioHttpMethod(
        url: ApiEndPoints.apiEndPoint +
            ApiEndPoints.shippingTracking +
            widget.packagesDetails['package_id'],
        context: context);
    if (response != null) {
      for (int i = 0; i < response['package_tracking'].length; i++) {
        timeline.add(response['package_tracking'][i]['package_status'] +
            ' ' +
            '(${response['package_tracking'][i]['date_time']})');
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.height,
        color: primary,
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
                decoration: const BoxDecoration(
                  color: greyColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        widget.packagesDetails['status'],
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
                            '${widget.packagesDetails['flight_eta_status']} : ',
                            style: regularText14.copyWith(
                              color: success,
                            ),
                          ),
                          Text(
                            widget.packagesDetails['flight_eta_date'],
                            style: const TextStyle(
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
                decoration: const BoxDecoration(
                  color: offWhite,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        width10,
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: SizedBox(
                            height: 60,
                            width: 60,
                            child: Image.network(
                              widget.packagesDetails['package_image'],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        width20,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.packagesDetails['shipping_mcecode'],
                                style: regularText14.copyWith(
                                  color: primary,
                                ),
                              ),
                              height10,
                              Text(
                                widget.packagesDetails['tracking'],
                                overflow: TextOverflow.ellipsis,
                                style: regularText14.copyWith(
                                  color: Colors.grey,
                                ),
                              ),
                              height10,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    widget.packagesDetails['weight_label'],
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
                    height15,
                    if (widget.packagesDetails['status'] ==
                            'Available for Pickup' &&
                        widget.packagesDetails['status'] == 'Collected')
                      Column(
                        children: [
                          Text(
                            "TOTAL COST : ",
                            style: mediumText14.copyWith(
                              color: blackColor,
                            ),
                          ),
                          height5,
                          Text(
                            "\$${widget.packagesDetails['amount']}",
                            style: mediumText14.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                        ],
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
              itemCount: timeline.length,
            ),
          ),
        )
      ],
    );
  }

  List timeline = [
    //   'Recevied in Florida',
    //   'Airline Boked',
    //   'Custooms Booked',
    //   'Available for Pickup',
    //   'Collected',
  ];
}
