import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_cart_express/order_tracking_app/constant/app_endpoints.dart';
import 'package:my_cart_express/order_tracking_app/constant/sizedbox.dart';
import 'package:my_cart_express/order_tracking_app/theme/colors.dart';
import 'package:my_cart_express/order_tracking_app/theme/text_style.dart';
import 'package:my_cart_express/order_tracking_app/utils/network_dio.dart';
import 'package:my_cart_express/order_tracking_app/widget/app_bar_widget.dart';
import 'package:my_cart_express/order_tracking_app/widget/network_image_handle.dart';

class PackagesMissingListScreen extends StatefulWidget {
  const PackagesMissingListScreen({super.key});

  @override
  State<PackagesMissingListScreen> createState() =>
      _PackagesMissingListScreenState();
}

class _PackagesMissingListScreenState extends State<PackagesMissingListScreen> {
  List? openMissingPackages;

  @override
  void initState() {
    super.initState();
    getMissingPackagesList();
  }

  void getMissingPackagesList() async {
    Map<String, dynamic>? packagesResponse = await NetworkDio.getDioHttpMethod(
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.openMissingPackages,
      context: context,
    );
    openMissingPackages = [];
    if (packagesResponse != null) {
      openMissingPackages = packagesResponse['data'];
    }
    setState(() {});
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
              appBarWithAction(),
              Expanded(
                child: Container(
                  width: Get.width,
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
        Expanded(
          child: openMissingPackages == null
              ? const SizedBox()
              : openMissingPackages!.isEmpty
                  ? Center(
                      child: Text(
                        'No missing packages found',
                        style: regularText16.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                    )
                  : ListView.separated(
                      itemCount: openMissingPackages!.length,
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 10,
                        );
                      },
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: greyColor.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Date Submitted',
                                          style: regularText16),
                                      Text('Delivery Date',
                                          style: regularText16),
                                      Text('Addition Info',
                                          style: regularText16),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(' : ', style: regularText16),
                                      Text(' : ', style: regularText16),
                                      Text(' : ', style: regularText16),
                                    ],
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          DateFormat('dd MMM yyyy').format(
                                              DateTime.parse(
                                                  openMissingPackages![index]
                                                      ['insert_timestamp'])),
                                          style: regularText16,
                                        ),
                                        Text(
                                          DateFormat('dd MMM yyyy').format(
                                              DateTime.parse(
                                                  openMissingPackages![index]
                                                      ['delivery_date'])),
                                          style: regularText16,
                                        ),
                                        Text(
                                          '${openMissingPackages![index]['additional_info']}',
                                          style: regularText16,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              height10,
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Attachments     :',
                                  style: regularText16,
                                ),
                              ),
                              height5,
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      textButton(
                                        title: 'Delivery Address',
                                        img: openMissingPackages![index][
                                            'proof_delivery_address_used_file'],
                                      ),
                                      width10,
                                      textButton(
                                        title: 'Proof Of Delivery',
                                        img: openMissingPackages![index][
                                            'proof_of_successful_delivery_file'],
                                      ),
                                    ],
                                  ),
                                  height5,
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      textButton(
                                        title: 'Tracking #',
                                        img: openMissingPackages![index]
                                            ['tracking_file'],
                                      ),
                                      width10,
                                      textButton(
                                        title: 'Invoice/Order Details',
                                        img: openMissingPackages![index][
                                            'package_invoice_order_details_file'],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
        )
      ],
    );
  }

  Widget textButton({
    required String title,
    required String img,
  }) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text(title),
            content: networkImage(
              img,
              fit: BoxFit.cover,
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Close',
                ),
              )
            ],
          ),
        );
      },
      child: Text(
        title,
        style: regularText16.copyWith(
          color: primary,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
