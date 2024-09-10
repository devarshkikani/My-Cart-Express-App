import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cart_express/e_commerce_app/e_constant/e_sizedbox.dart';
import 'package:my_cart_express/e_commerce_app/e_theme/e_app_text_theme.dart';
import 'package:my_cart_express/order_tracking_app/constant/app_endpoints.dart';
import 'package:my_cart_express/order_tracking_app/constant/default_images.dart';
import 'package:my_cart_express/order_tracking_app/theme/colors.dart';
import 'package:dio/dio.dart' as dio;
import 'package:my_cart_express/order_tracking_app/utils/network_dio.dart';
import 'package:my_cart_express/staff_app/staff_model/get_selected_bin_details_model.dart';
import 'package:my_cart_express/staff_app/staff_model/staff_scanned_bin_list_model.dart';
import 'package:my_cart_express/staff_app/staff_screen/staff_warehouse/add_new_package_to_bin.dart';
import 'package:my_cart_express/staff_app/staff_screen/staff_warehouse/bin_list/scanner_dashboard_screen.dart';
import 'package:my_cart_express/staff_app/staff_screen/staff_warehouse/binning_issue_screen.dart';

class ReferAllPackagesScreen extends StatefulWidget {
  List<PackageList> dataList;
  final String binId;
  ReferAllPackagesScreen(
      {super.key, required this.binId, required this.dataList});

  @override
  State<ReferAllPackagesScreen> createState() => _ReferAllPackagesScreenState();
}

class _ReferAllPackagesScreenState extends State<ReferAllPackagesScreen> {
  PackageData? packageData;

  Future<void> getScannerPackgeData(context, binID) async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
      context: context,
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.getScannedBinData,
      data: dio.FormData.fromMap({
        'bin_code': binID, // "BIN-37851496"
      }),
    );
    GetAllScannedPackagesModel res =
        GetAllScannedPackagesModel.fromJson(response!);

    widget.dataList = res.packageList ?? [];

    setState(() {});

    // log(response.toString());
  }

  Future<void> getSelectedPackageDetails(context, pkgId) async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
      context: context,
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.getSelectedPackageDetails,
      data: dio.FormData.fromMap({
        'package_id': pkgId,
      }),
    );

    log(response.toString());
    if (response != null && response["status"] == 20) {
      packageData = GetSelectedBinDetailsModel.fromJson(response!).packageData;
      customDialog(packageData!);
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
              AppBar(
                centerTitle: true,
                elevation: 0.0,
                title: const Text(
                  'Add To Bin',
                ),
              ),
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'BIN Name: ${widget.binId}',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 20,
        ),
        buttons(),
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: whiteColor, borderRadius: BorderRadius.circular(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                  ),
                  child: const Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Scan',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Status',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                Expanded(
                  child: ListView.builder(
                      itemCount: widget.dataList.length,
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            getSelectedPackageDetails(
                                context, widget.dataList[index].packageId);
                          },
                          child: Card(
                            elevation: 1.5,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          if (widget.dataList[index]
                                                  .checkOffScan ==
                                              1)
                                            Image.asset(
                                              doubleTick,
                                              height: 20,
                                              width: 20,
                                            ),
                                          Text(
                                            widget
                                                .dataList[index].shippingMcecode
                                                .toString(),
                                            style: const TextStyle(
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ],
                                      ),
                                      _buildStatusIndicator(
                                          widget.dataList[index].status
                                              .toString(),
                                          widget.dataList[index].status
                                                      .toString() ==
                                                  "ISSUE"
                                              ? Colors.red
                                              : Colors.green),
                                    ],
                                  ),
                                  if (widget.dataList[index].internalNote == 1)
                                    Image.asset(
                                      letterm,
                                      height: 20,
                                      width: 20,
                                    ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  _buildTag(
                                      widget.dataList[index].binnedLocation
                                          .toString(),
                                      Colors.purple),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Row(
                                    children: [
                                      if (widget.dataList[index].isFlagged ==
                                          "1")
                                        Image.asset(
                                          flag,
                                          height: 20,
                                          width: 20,
                                        ),
                                      if (widget.dataList[index].isDetained ==
                                          "1")
                                        const SizedBox(
                                          width: 4,
                                        ),
                                      if (widget.dataList[index].isDetained ==
                                          "1")
                                        Image.asset(
                                          letterc,
                                          height: 20,
                                          width: 20,
                                        ),
                                      if (widget.dataList[index].isDamaged ==
                                          "1")
                                        const SizedBox(
                                          width: 4,
                                        ),
                                      if (widget.dataList[index].isDamaged ==
                                          "1")
                                        Image.asset(
                                          letterd,
                                          height: 20,
                                          width: 20,
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                )

                // Expanded(
                //   child: ListView(
                //     children: [
                //       _buildPackageRow('PKG740912', 'ISSUE', Colors.red),
                //       const Divider(),
                //       _buildPackageRow('PKG369433', 'AVAILABLE', Colors.green),
                //       const Divider(),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buttons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          onPressed: () {
            // Get.to(() => const SannerDashboard());
            Get.to(
              () => AddNewPackageToBinScreen(
                binCode: widget.binId,
              ),
            )!
                .then((value) {
              getScannerPackgeData(context, widget.binId);
            });
          },
          child: const Text(
            'Add New Package to Bin',
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Get.to(() => BinningIssueScreen(
                  binID: widget.binId,
                ));
          },
          child: const Text(
            'Binning Issues',
          ),
        ),
      ],
    );
  }

  Widget _buildPackageRow(String packageId, String status, Color statusColor) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Text(
                  packageId,
                  style: const TextStyle(
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(width: 10),
                _buildTag('POR', Colors.purple),
              ],
            ),
          ),
          Expanded(
            child: _buildStatusIndicator(status, statusColor),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildStatusIndicator(String status, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            status,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  void customDialog(PackageData pkgDet) async {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text('Shipping Details'),
                const Spacer(),
                InkWell(
                  onTap: () {
                    Navigator.pop(_);
                  },
                  child: const Icon(Icons.close_rounded),
                ),
              ],
            ),
            height20,
            Text(
              pkgDet.customerName.toString(),
              style: boldText16.copyWith(fontSize: 14),
            ),
            height5,
            Text(
              pkgDet.packageList!['code'].toString(),
              style: boldText16.copyWith(fontSize: 14),
            ),
            height5,
            Text(
              pkgDet.priceGroupName.toString(),
              style: boldText16.copyWith(fontSize: 14),
            ),
          ],
        ),
        content: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleList(
                  title1: "Tracking#",
                  isdiderShow: false,
                  title2: pkgDet.packageList!['tracking'],
                  style: regularText14.copyWith(color: Colors.blue)),
              height10,
              titleList(
                  title1: "PKG#",
                  isdiderShow: false,
                  title2: pkgDet.packageList!['shipping_mcecode']),
              height10,
              titleList(
                title1: "Collection",
                isdiderShow: false,
                title2: pkgDet.packageList!['insert_timestamp'],
              ),

              height10,
              titleList(
                  title1: "Ttype",
                  title2: pkgDet.packageList!["shipping_type"]),
              height10,
              titleList(
                  title1: "Wegiht", title2: pkgDet.packageList!["weight"]),
              height10,
              titleList(
                  title1: "Sender",
                  title2: pkgDet.packageList!["sender_other_name"]),
              height10,
              titleList(
                  title1: "Merchant",
                  title2: pkgDet.packageList!["vendor_name"]),
              height10,
              titleList(
                  title1: "Shipping Method",
                  title2: pkgDet.packageList!["shipping_method"]),
              height10,
              titleList(
                  title1: "Package Rank",
                  title2: pkgDet.packageList!['package_rank'] ?? "--"),
              height10,
              titleList(title1: "Package Age", title2: pkgDet.packageAge),
              // height20,
              // const Text(
              //   "Internal Notes",
              //   style: boldText16,
              // ),
              height10,
              Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: greyColor)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Short Description",
                      style: boldText16,
                    ),
                    const Divider(),
                    titleList(title1: "Received", title2: pkgDet.daysAgo),
                    const Divider(),
                    titleList(title1: "Manifest", title2: pkgDet.manifestCode),
                  ],
                ),
              ),
              // height10,
              Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: greyColor)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    titleList(
                        title1: "Package Value",
                        isdiderShow: false,
                        title2: pkgDet.packagePriceDetails!.packageCost,
                        style: boldText16),
                    const Divider(),
                    titleList(title1: "Value Aquistion", title2: "0"),
                    const Divider(),
                    titleList(
                        title1: "Freight Charges",
                        title2: pkgDet.packagePriceDetails!.freightCharges),
                    const Divider(),
                    titleList(
                        title1: "Inbound Charge",
                        title2: pkgDet.packagePriceDetails!.inboundCharge),
                    const Divider(),
                    titleList(
                        title1: "Storage Fees",
                        title2: pkgDet.packagePriceDetails!.storageFees),
                    const Divider(),
                    titleList(
                        title1: "GCT", title2: pkgDet.packagePriceDetails!.gct),
                    const Divider(),
                    titleList(
                        title1: "Duty Tax",
                        title2: pkgDet.packagePriceDetails!.dutyTax),
                    const Divider(),
                    titleList(
                        title1: "Delivery Cost",
                        title2: pkgDet.packagePriceDetails!.deliveryCost),
                    const Divider(),
                    titleList(
                        title1: "Third Party Delivery Cost",
                        title2:
                            pkgDet.packagePriceDetails!.thirdPartyDeliveryCost),
                    const Divider(),
                    titleList(
                        title1: "Bad Address Fees",
                        title2: pkgDet.packagePriceDetails!.badAddressFees),
                    const Divider(),
                    titleList(
                        title1: "Estimate Total Due",
                        isdiderShow: false,
                        title2: pkgDet.packagePriceDetails!.estimateTotalDue,
                        style: boldText16),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row titleList({title1, title2, color, style, bool? isdiderShow}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          // width: 120,
          child: Text(
            title1,
            style: style ??
                const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
        width10,
        if (isdiderShow != false) const Text(":"),
        width5,
        Expanded(
          child: Text(title2,
              textAlign: TextAlign.end,
              style: style ??
                  TextStyle(
                    fontSize: 14,
                    color: color,
                    fontWeight: FontWeight.w400,
                  )),
        ),
      ],
    );
  }

  Color _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor; // Adding FF for full opacity
    }
    return Color(int.parse(hexColor, radix: 16));
  }
}
