import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:my_cart_express/e_commerce_app/e_theme/e_app_text_theme.dart';
import 'package:my_cart_express/order_tracking_app/constant/app_endpoints.dart';
import 'package:my_cart_express/order_tracking_app/constant/sizedbox.dart';
import 'package:my_cart_express/order_tracking_app/theme/colors.dart';
import 'package:my_cart_express/order_tracking_app/utils/network_dio.dart';
import 'package:my_cart_express/staff_app/staff_model/staff_bin_issued__list_model.dart';

class BinningIssueScreen extends StatefulWidget {
  final String binID;
  const BinningIssueScreen({super.key, required this.binID});

  @override
  State<BinningIssueScreen> createState() => _BinningIssueScreenState();
}

class _BinningIssueScreenState extends State<BinningIssueScreen> {
  List<PackageList> pkg = <PackageList>[];
  Map<String, dynamic> pkdDetails = {};

  @override
  void initState() {
    super.initState();
    getScannerPackgeList(context);
  }

  Future<void> getScannerPackgeList(context) async {
    print(widget.binID);
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
      context: context,
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.getBinIssue,
      data: dio.FormData.fromMap({
        'bin_code': widget.binID,
      }),
    );
    pkg = BinIssuedDetailsModel.fromJson(response!).packageList ?? [];

    setState(() {});
  }

  Future<void> getSelectedPackageDetails(context, pkgId) async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
      context: context,
      url: ApiEndPoints.apiEndPoint +
          ApiEndPoints.getSelectedPackageIssueDetails,
      data: dio.FormData.fromMap({
        'package_id': pkgId,
      }),
    );
    pkdDetails = response ?? {};
    if (pkdDetails.isNotEmpty) {
      customDialog(pkdDetails);
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
                  'Binning Issuses',
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
    return ListView.builder(
      itemCount: pkg.length,
      itemBuilder: (context, i) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.only(left: 12, top: 12, bottom: 12),
          decoration: BoxDecoration(
            color: pkg[i].colorCode != null
                ? _getColorFromHex(pkg[i].colorCode.toString())
                : blackColor.withOpacity(.5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: InkWell(
            onTap: () {
              getSelectedPackageDetails(context, pkg[i].packageId);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Assigned : ${pkg[i].firstname} ${pkg[i].lastname}',
                        style: regularText16.copyWith(color: whiteColor),
                      ),
                    ),
                    // Spacer(),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: whiteColor,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                height5,
                Text(
                  'PKG# : ${pkg[i].shippingMcecode}',
                  style: regularText16.copyWith(color: whiteColor),
                ),
                height5,
                Text(
                  'Bin :${pkg[i].code}',
                  style: regularText16.copyWith(color: whiteColor),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void customDialog(pkgDet) async {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: _getColorFromHex(pkgDet['package_data']['color_code']),
        title: Row(
          children: [
            const Text(
              'Details',
              style: TextStyle(color: whiteColor),
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                Navigator.pop(_);
              },
              child: const Icon(
                Icons.close_rounded,
                color: whiteColor,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Customer : ${pkgDet['package_data']['customer_name']}',
              style: regularText16.copyWith(color: whiteColor),
            ),
            height5,
            Text(
              'PKG# : ${pkgDet['package_data']['shipping_mcecode']}',
              style: regularText16.copyWith(color: whiteColor),
            ),
            height5,
            Text(
              'Bin Name : ${pkgDet['package_data']['branch_code']}',
              style: regularText16.copyWith(color: whiteColor),
            ),
            height5,
            Text(
              'Weight : ${pkgDet['package_data']['weight']}',
              style: regularText16.copyWith(color: whiteColor),
            ),
            height5,
            Text(
              'Tracking# : ${pkgDet['package_data']['tracking']}',
              style: regularText16.copyWith(color: whiteColor),
            ),
            height5,
            Text(
              'Manifest : ${pkgDet['package_data']['manifest_code'] ?? ""}',
              style: regularText16.copyWith(color: whiteColor),
            ),
          ],
        ),
      ),
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
