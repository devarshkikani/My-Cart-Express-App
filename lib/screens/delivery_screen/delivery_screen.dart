import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cart_express/constant/app_endpoints.dart';
import 'package:my_cart_express/constant/sizedbox.dart';
import 'package:my_cart_express/screens/shipping_screen/packages_details_screen.dart';
import 'package:my_cart_express/theme/colors.dart';
import 'package:my_cart_express/theme/text_style.dart';
import 'package:my_cart_express/utils/network_dio.dart';

class DeliveryScreen extends StatefulWidget {
  const DeliveryScreen({super.key});

  @override
  State<DeliveryScreen> createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  RxList duePackages = [].obs;
  RxBool isLoading = true.obs;

  RxMap duePackagesData = {}.obs;
  @override
  void initState() {
    getShippingOverdue();
    super.initState();
  }

  Future<void> getShippingOverdue() async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.shippingOverdue,
      data: null,
      context: context,
    );
    if (response != null) {
      isLoading.value = false;
      duePackages.value = response['list'];
      duePackagesData.value = {
        "counts": response['counts'],
        "storage": response['storage'],
      };
    }
  }

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
        Text(
          'Overdue Packages',
          style: regularText18,
        ),
        height10,
        Obx(
          () => isLoading.value
              ? const SizedBox()
              : Text(
                  'TOTAL PACKAGES AVAILABLE : ${duePackagesData['counts']}',
                  style: regularText14.copyWith(
                    color: Colors.grey,
                  ),
                ),
        ),
        height10,
        Obx(
          () => isLoading.value
              ? const SizedBox()
              : Text(
                  'TOTAL DUE : ${duePackagesData['storage']}',
                  style: regularText14.copyWith(
                    color: Colors.grey,
                  ),
                ),
        ),
        height25,
        duePackagesView(),
      ],
    );
  }

  Widget duePackagesView() {
    return Obx(
      () => isLoading.value
          ? const SizedBox()
          : duePackages.isEmpty
              ? Center(
                  child: Text(
                    'No overdue packages found.',
                    style: lightText14.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                )
              : ListView.separated(
                  itemCount: duePackages.length,
                  padding: EdgeInsets.zero,
                  separatorBuilder: (BuildContext context, int index) =>
                      height20,
                  itemBuilder: (BuildContext context, int index) => InkWell(
                    onTap: () {
                      Get.to(() => MyPackagesDetailsScreen(
                            packagesDetails: duePackages[index],
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.check_circle,
                                          color: primary,
                                        ),
                                        width5,
                                        Text(
                                          duePackages[index]['package_status'],
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'value : ',
                                          style: lightText12,
                                        ),
                                        Text(
                                          duePackages[index]
                                              ['amount'], //'\$48.0',
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
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: SizedBox(
                                      height: 60,
                                      width: 60,
                                      child: Image.network(
                                        duePackages[index]['img_url'],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                width20,
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        duePackages[index]['pkg_shipging_code'],
                                        style: regularText14.copyWith(
                                          color: primary,
                                        ),
                                      ),
                                      height10,
                                      Text(
                                        duePackages[index]['pkg_id'],
                                        overflow: TextOverflow.ellipsis,
                                        style: regularText14.copyWith(),
                                      ),
                                      height10,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            duePackages[index]['weight_label'],
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
                                        "TOTAL COST : ${duePackages[index]['total_cost']}",
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              duePackages[index]
                                                  ['invoice_btn_text'],
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
