import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cart_express/constant/app_endpoints.dart';
import 'package:my_cart_express/constant/default_images.dart';
import 'package:my_cart_express/constant/sizedbox.dart';
import 'package:my_cart_express/screens/shipping_screen/packages_details_screen.dart';
import 'package:my_cart_express/theme/colors.dart';
import 'package:my_cart_express/theme/text_style.dart';
import 'package:my_cart_express/utils/network_dio.dart';
import 'package:my_cart_express/widget/app_bar_widget.dart';

class AvailablePackagesScreen extends StatefulWidget {
  const AvailablePackagesScreen({super.key});

  @override
  State<AvailablePackagesScreen> createState() =>
      _AvailablePackagesScreenState();
}

class _AvailablePackagesScreenState extends State<AvailablePackagesScreen> {
  RxList shippmentsList = [].obs;

  @override
  void initState() {
    getShippments();
    super.initState();
  }

  Future<void> getShippments() async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
        url: ApiEndPoints.apiEndPoint + ApiEndPoints.shippingList,
        context: context,
        data: null);
    if (response != null) {
      shippmentsList.value = response['list'];
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
            appBarWithAction(),
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
        Row(
          children: [
            Text(
              'Available Packages',
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
          'TOTAL PACKAGES AVAILABLE : 4',
          style: regularText14.copyWith(
            color: Colors.grey,
          ),
        ),
        height10,
        Text(
          'TOTAL DUE : \$3200',
          style: regularText14.copyWith(
            color: Colors.grey,
          ),
        ),
        height15,
        Expanded(
          child: shippingList(),
        ),
      ],
    );
  }

  Widget shippingList() {
    return Obx(
      () => shippmentsList.isEmpty
          ? Center(
              child: Image.asset(
                emptyList,
                height: 200,
              ),
            )
          : ListView.separated(
              itemCount: shippmentsList.length,
              padding: EdgeInsets.zero,
              separatorBuilder: (BuildContext context, int index) => height20,
              itemBuilder: (BuildContext context, int index) => InkWell(
                onTap: () {
                  Get.to(() => MyPackagesDetailsScreen(
                        packagesDetails: shippmentsList[index],
                      ));
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
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: primary.withOpacity(0.2),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        child: IntrinsicHeight(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.check_circle,
                                      color: primary,
                                    ),
                                    width5,
                                    Text(
                                      'Available for Pickup',
                                      style: lightText12.copyWith(
                                        color: primary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const VerticalDivider(
                                color: primary,
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'value : ',
                                      style: lightText12,
                                    ),
                                    Text(
                                      '\$48.0',
                                      style: regularText14,
                                    ),
                                  ],
                                ),
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
                            width20,
                            Center(
                              child: Container(
                                height: 60,
                                width: 60,
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: amazonColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Image.asset(
                                  unitedStateLogo,
                                ),
                              ),
                            ),
                            width20,
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
                                    style: regularText14.copyWith(),
                                  ),
                                  height10,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '8LB',
                                        overflow: TextOverflow.ellipsis,
                                        style: regularText14.copyWith(),
                                      ),
                                      const Icon(
                                        Icons.arrow_forward_ios_rounded,
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
                        decoration: BoxDecoration(
                          color: primary.withOpacity(0.2),
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                            Expanded(
                              child: Container(
                                color: success,
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Request Delivery',
                                          style: regularText14.copyWith(
                                            color: whiteColor,
                                            letterSpacing: 0.2,
                                          ),
                                        ),
                                        width5,
                                        const Icon(
                                          Icons.add_circle_outline_rounded,
                                          color: whiteColor,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
