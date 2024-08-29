import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cart_express/e_commerce_app/e_theme/e_app_text_theme.dart';
import 'package:my_cart_express/order_tracking_app/constant/default_images.dart';
import 'package:my_cart_express/order_tracking_app/theme/colors.dart';
import 'package:my_cart_express/staff_app/staff_model/staff_scanned_bin_list_model.dart';
import 'package:my_cart_express/staff_app/staff_screen/staff_warehouse/add_new_package_to_bin.dart';
import 'package:my_cart_express/staff_app/staff_screen/staff_warehouse/bin_list/bin_issue_list_screen.dart';
import 'package:my_cart_express/staff_app/staff_screen/staff_warehouse/binning_issue_screen.dart';

class ReferAllPackagesScreen extends StatefulWidget {
  final List<PackageList> dataList;
  final String binId;
  const ReferAllPackagesScreen(
      {super.key, required this.binId, required this.dataList});

  @override
  State<ReferAllPackagesScreen> createState() => _ReferAllPackagesScreenState();
}

class _ReferAllPackagesScreenState extends State<ReferAllPackagesScreen> {
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
        const Text(
          'Bin Name: P-A1, Portmore',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                      // physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      if (widget.dataList[index].checkOffScan ==
                                          1)
                                        Image.asset(
                                          doubleTick,
                                          height: 20,
                                          width: 20,
                                        ),
                                      Text(
                                        widget.dataList[index].shippingMcecode
                                            .toString(),
                                        style: const TextStyle(
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ],
                                  ),
                                  _buildStatusIndicator(
                                      widget.dataList[index].status.toString(),
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
                                  if (widget.dataList[index].isFlagged == "1")
                                    Image.asset(
                                      flag,
                                      height: 20,
                                      width: 20,
                                    ),
                                  if (widget.dataList[index].isDetained == "1")
                                    const SizedBox(
                                      width: 4,
                                    ),
                                  if (widget.dataList[index].isDetained == "1")
                                    Image.asset(
                                      letterc,
                                      height: 20,
                                      width: 20,
                                    ),
                                  if (widget.dataList[index].isDamaged == "1")
                                    const SizedBox(
                                      width: 4,
                                    ),
                                  if (widget.dataList[index].isDamaged == "1")
                                    Image.asset(
                                      letterd,
                                      height: 20,
                                      width: 20,
                                    ),
                                ],
                              ),
                              const Divider(),
                            ],
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
            Get.to(() => const AddNewPackageToBinScreen());
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
}
