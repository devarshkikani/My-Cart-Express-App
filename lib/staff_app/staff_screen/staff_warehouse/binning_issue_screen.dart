import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cart_express/e_commerce_app/e_theme/e_app_text_theme.dart';
import 'package:my_cart_express/order_tracking_app/constant/sizedbox.dart';
import 'package:my_cart_express/order_tracking_app/theme/colors.dart';

class BinningIssueScreen extends StatefulWidget {
  const BinningIssueScreen({super.key});

  @override
  State<BinningIssueScreen> createState() => _BinningIssueScreenState();
}

class _BinningIssueScreenState extends State<BinningIssueScreen> {
  @override
  .hashCode
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
      itemCount: 10,
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
              showDialog(
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
                      const Text(
                        'Assigned  : MCE80650 appteam developer',
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
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Text(
                      'Assigned  : MCE80650 appteam developer',
                      style: regularText16,
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 20,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
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
              ],
            ),
          ),
        );
      },
    );
  }
}
