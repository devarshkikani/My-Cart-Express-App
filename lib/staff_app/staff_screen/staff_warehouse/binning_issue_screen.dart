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
        'bin_code':  widget.binID,
      }),
    );
    pkg = BinIssuedDetailsModel.fromJson(response!).packageList ?? [];

    setState(() {});
  }

  Future<void> getSelectedPackageDetails(context, pkgId) async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
      context: context,
      url: ApiEndPoints.apiEndPoint +
         ApiEndPoints.getSelectedPackageDetails,
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
            color: blackColor.withOpacity(.1),
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
                        style: regularText16,
                      ),
                    ),
                    // Spacer(),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
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
                  style: regularText16,
                ),
                height5,
                Text(
                  'Bin :${pkg[i].code}',
                  style: regularText16,
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
        title: Row(
          children: [
            const Text('Details'),
            const Spacer(),
            InkWell(
              onTap: () {
                Navigator.pop(_);
              },
              child: const Icon(Icons.close_rounded),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Customer Name  : ${{pkgDet['package_data']['customer_name']}}',
              style: regularText16,
            ),
            height5,
            const Text(
              'PKG#  : PKG740912',
              style: regularText16,
            ),
            height5,
            const Text(
              'Bin Name  : Hope Road (Hope Business Place)',
              style: regularText16,
            ),
            height5,
            const Text(
              'Weight : 3',
              style: regularText16,
            ),
            height5,
            const Text(
              'Tracking# : dsfgs',
              style: regularText16,
            ),
            height5,
            const Text(
              'Manifest  : ',
              style: regularText16,
            ),
          ],
        ),
      ),
    );
  }
}
