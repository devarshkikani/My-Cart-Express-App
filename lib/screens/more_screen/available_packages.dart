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
  RxList availablePackages = [].obs;
  RxBool isLoading = true.obs;
  RxMap availablePackagesData = {}.obs;

  @override
  void initState() {
    getAvailablePackages();
    super.initState();
  }

  Future<void> getAvailablePackages() async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
        url: ApiEndPoints.apiEndPoint + ApiEndPoints.availableShipping,
        context: context,
        data: null);
    if (response != null) {
      isLoading.value = false;
      availablePackages.value = response['list'];
      availablePackagesData.value = {
        "counts": response['counts'],
        "due": response['due'],
      };
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
        Text(
          'Available Packages',
          style: regularText18,
        ),
        height10,
        Obx(() => isLoading.value
            ? const SizedBox()
            : Text(
                'TOTAL PACKAGES AVAILABLE : ${availablePackagesData['counts']}',
                style: regularText14.copyWith(
                  color: Colors.grey,
                ),
              )),
        height10,
        Obx(() => isLoading.value
            ? const SizedBox()
            : Text(
                'TOTAL DUE : ${availablePackagesData['due']}',
                style: regularText14.copyWith(
                  color: Colors.grey,
                ),
              )),
        height15,
        Expanded(
          child: shippingList(),
        ),
      ],
    );
  }

  Widget shippingList() {
    return Obx(
      () => isLoading.value
          ? Row(
              children: const <Widget>[
                SizedBox(),
              ],
            )
          : availablePackages.isEmpty
              ? Center(
                  child: Image.asset(
                    emptyList,
                    height: 200,
                  ),
                )
              : ListView.separated(
                  itemCount: availablePackages.length,
                  padding: EdgeInsets.zero,
                  separatorBuilder: (BuildContext context, int index) =>
                      height20,
                  itemBuilder: (BuildContext context, int index) => InkWell(
                    onTap: () {
                      Get.to(() => MyPackagesDetailsScreen(
                            packagesDetails: availablePackages[index],
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
                                          availablePackages[index]
                                              ['package_status'],
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
                                          availablePackages[index]
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
                                        availablePackages[index]['img_url'],
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
                                        availablePackages[index]
                                            ['pkg_shipging_code'],
                                        style: regularText14.copyWith(
                                          color: primary,
                                        ),
                                      ),
                                      height10,
                                      Text(
                                        availablePackages[index]['pkg_id'],
                                        overflow: TextOverflow.ellipsis,
                                        style: regularText14.copyWith(),
                                      ),
                                      height10,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            availablePackages[index]
                                                ['weight_label'],
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
                                        "TOTAL COST : ${availablePackages[index]['total_cost']}",
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
                                              availablePackages[index]
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
