import 'dart:developer';
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
  ScrollController scrollController = ScrollController();
  RxList shippmentsList = [].obs;
  RxString searchData = ''.obs;
  RxBool isLoading = true.obs;
  RxInt offSet = 0.obs;

  @override
  void initState() {
    getShippments(null);
    debounce<String>(searchData, validations,
        time: const Duration(milliseconds: 700));
    scrollController = ScrollController()..addListener(_scrollListener);
    super.initState();
  }

  validations(String string) async {
    await getShippments(string);
  }

  Future<void> _scrollListener() async {
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      await getShippments(searchData.value != '' ? searchData.value : null);
    }
  }

  Future<void> getShippments(String? value) async {
    final data = dio.FormData.fromMap({
      'search_text': value,
      'offset': value == null ? offSet.value : 0,
    });
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
        url: ApiEndPoints.apiEndPoint + ApiEndPoints.shippingList,
        context: context,
        data: data);
    if (response != null) {
      isLoading.value = false;
      if (shippmentsList.isEmpty) {
        shippmentsList.value = response['list'];
      } else if (value != null) {
        shippmentsList.value = response['list'];
      } else {
        for (var i = 0; i < response['list'].length; i++) {
          shippmentsList.add(response['list'][i]);
        }
      }
      offSet.value = response['offset'];
      log(offSet.value.toString());
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
          child: Obx(() {
            return isLoading.value
                ? const SizedBox()
                : shippmentsList.isEmpty
                    ? Image.asset(emptyList)
                    : shippingList();
          }),
        ),
      ],
    );
  }

  Widget shippingList() {
    return ListView.separated(
      itemCount: shippmentsList.length,
      padding: EdgeInsets.zero,
      controller: scrollController,
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
              color: shippmentsList[index]['status'] == 'Available for Pickup'
                  ? Colors.green.shade200
                  : Colors.white,
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
                          shippmentsList[index]['status'],
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
                              shippmentsList[index]['value_cost'],
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
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: SizedBox(
                            height: 60,
                            width: 60,
                            child: Image.network(
                              shippmentsList[index]['package_image'],
                              fit: BoxFit.cover,
                            ),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          'TOTAL COST : ${shippmentsList[index]['amount']}',
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
    );
  }
}
