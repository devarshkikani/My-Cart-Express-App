import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cart_express/constant/app_endpoints.dart';
import 'package:my_cart_express/constant/default_images.dart';
import 'package:my_cart_express/constant/sizedbox.dart';
import 'package:my_cart_express/screens/shipping_screen/packages_details_screen.dart';
import 'package:my_cart_express/theme/colors.dart';
import 'package:my_cart_express/theme/text_style.dart';
import 'package:my_cart_express/utils/network_dio.dart';
import 'package:my_cart_express/widget/input_text_field.dart';

class ShippingScreen extends StatefulWidget {
  const ShippingScreen({super.key, required this.isFromeHome});
  final bool isFromeHome;
  @override
  State<ShippingScreen> createState() => _ShippingScreenState();
}

class _ShippingScreenState extends State<ShippingScreen> {
  RxList shippmentsList = [].obs;
  RxString searchData = ''.obs;

  @override
  void initState() {
    getShippments(null);
    debounce<String>(searchData, validations,
        time: const Duration(milliseconds: 700));
    super.initState();
  }

  validations(String string) async {
    await getShippments(string);
  }

  Future<void> getShippments(String? value) async {
    final data = dio.FormData.fromMap({
      'search_text': value,
      'offset': null,
    });
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
        url: ApiEndPoints.apiEndPoint + ApiEndPoints.shippingList,
        context: context,
        data: value != null ? data : null);
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
            const SizedBox(
              width: 100,
            ),
            Expanded(
              child: TextFormFieldWidget(
                hintText: 'Search',
                onChanged: (String? value) {
                  searchData.value = value ?? '';
                },
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
    return Obx(
      () => shippmentsList.isEmpty
          ? Image.asset(emptyList)
          : ListView.separated(
              itemCount: shippmentsList.length,
              padding: EdgeInsets.zero,
              separatorBuilder: (BuildContext context, int index) => height20,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
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
                                  'Button',
                                  style: regularText14.copyWith(
                                    color: primary,
                                  ),
                                ),
                                const VerticalDivider(
                                  color: primary,
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      'Value : ',
                                    ),
                                    Text(
                                      shippmentsList[index]['amount'],
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
                                  child: Image.network(
                                    shippmentsList[index]['package_image'],
                                  ),
                                ),
                              ),
                              width20,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      shippmentsList[index]['shipping_mcecode'],
                                      style: regularText14.copyWith(
                                        color: primary,
                                      ),
                                    ),
                                    height10,
                                    Text(
                                      shippmentsList[index]['tracking'],
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
                                          shippmentsList[index]['weight_label'],
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
                          decoration: const BoxDecoration(
                            color: greyColor,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          child: IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "TOTAL COST : ${shippmentsList[index]['amount']}",
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
                );
              },
            ),
    );
  }
}
