import 'package:flutter/material.dart';
import 'package:my_cart_express/e_commerce_app/e_theme/e_app_colors.dart';
import 'package:my_cart_express/e_commerce_app/e_theme/e_app_text_theme.dart';
import 'package:my_cart_express/order_tracking_app/constant/default_images.dart';
import 'package:my_cart_express/staff_app/staff_model/staff_scanned_bin_list_model.dart';
import 'package:my_cart_express/staff_app/staff_screen/staff_warehouse/bin_list/bin_issue_list_screen.dart';

class ScannedBinListScreen extends StatefulWidget {
  final List<PackageList> dataList;
  const ScannedBinListScreen({super.key, required this.dataList});

  @override
  State<ScannedBinListScreen> createState() => _ScannedBinListScreenState();
}

class _ScannedBinListScreenState extends State<ScannedBinListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: const Text(
          'Bin List',
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BinIssueListScreen(),
                ),
              );
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.question_mark),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.close),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Bin Name: P-A1, Portmore",
                style: regularText16,
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                child: ListView.builder(
                    itemCount: widget.dataList.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue.shade100)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      style: mediumText14.copyWith(
                                          color: Colors.blue.shade400),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: error,
                                  ),
                                  child: Text(
                                    widget.dataList[index].status.toString(),
                                    style: const TextStyle(color: whiteColor),
                                  ),
                                ),
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
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.pink.shade200,
                              ),
                              child: Text(
                                widget.dataList[index].binnedLocation
                                    .toString(),
                                style: const TextStyle(color: whiteColor),
                              ),
                            ),
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
                            )
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
