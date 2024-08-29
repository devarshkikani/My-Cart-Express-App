import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_cart_express/e_commerce_app/e_theme/e_app_colors.dart';
import 'package:my_cart_express/e_commerce_app/e_theme/e_app_text_theme.dart';
import 'package:my_cart_express/order_tracking_app/constant/app_endpoints.dart';
import 'package:my_cart_express/order_tracking_app/utils/network_dio.dart';
import 'package:dio/dio.dart' as dio;
import 'package:my_cart_express/staff_app/staff_model/staff_bin_issued__list_model.dart';

class BinIssueListScreen extends StatefulWidget {
  final String binID;
  const BinIssueListScreen({super.key, required this.binID});

  @override
  State<BinIssueListScreen> createState() => _BinIssueListScreenState();
}

class _BinIssueListScreenState extends State<BinIssueListScreen> {
  List<PackageList> pkg = <PackageList>[];

  @override
  void initState() {
    super.initState();
    getScannerPackgeList(context);
  }

  Future<void> getScannerPackgeList(context) async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
      context: context,
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.getBinIssue,
      data: dio.FormData.fromMap({
        'bin_code': "BIN-37851496",
      }),
    );
    pkg = BinIssuedDetailsModel.fromJson(response!).packageList ?? [];

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: const Text(
          'Binning Issue',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                child: ListView.builder(
                    itemCount: pkg.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 5),
                        decoration: const BoxDecoration(color: surface),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    "${pkg[index].mceNumber}",
                                    style: mediumText16.copyWith(
                                        color: whiteColor),
                                  ),
                                ),
                                Text(
                                  pkg[index].shippingMcecode.toString(),
                                  style: const TextStyle(color: whiteColor),
                                ),
                              ],
                            ),
                            Text(
                              "(${pkg[index].firstname} ${pkg[index].lastname})",
                              style: const TextStyle(color: whiteColor),
                            ),
                            Text(
                              pkg[index].code.toString(),
                              style: const TextStyle(color: whiteColor),
                            ),
                          ],
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
