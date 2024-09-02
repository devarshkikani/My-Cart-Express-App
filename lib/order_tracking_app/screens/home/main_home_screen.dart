// ignore_for_file: must_be_immutable, avoid_print

import 'dart:async';

import 'package:badges/badges.dart' as b;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_cart_express/e_commerce_app/e_widget/e_input_text_field.dart';
import 'package:my_cart_express/order_tracking_app/constant/app_endpoints.dart';
import 'package:my_cart_express/order_tracking_app/constant/default_images.dart';
import 'package:my_cart_express/order_tracking_app/constant/storage_key.dart';
import 'package:my_cart_express/order_tracking_app/screens/overdue_screen/overdue_screen.dart';
import 'package:my_cart_express/order_tracking_app/screens/home_screen/home_screen.dart';
import 'package:my_cart_express/order_tracking_app/screens/more_screen/more_screen.dart';
import 'package:my_cart_express/order_tracking_app/screens/more_screen/available_packages.dart';
import 'package:my_cart_express/order_tracking_app/screens/scanner_screen/scanner_screen.dart';
import 'package:my_cart_express/order_tracking_app/screens/shipping_screen/shipping_screen.dart';
import 'package:my_cart_express/order_tracking_app/theme/colors.dart';
import 'package:my_cart_express/order_tracking_app/theme/text_style.dart';
import 'package:my_cart_express/order_tracking_app/utils/global_singleton.dart';
import 'package:my_cart_express/order_tracking_app/utils/network_dio.dart';
import 'package:my_cart_express/order_tracking_app/widget/show_feedback_popup.dart';

import '../../../e_commerce_app/e_constant/e_sizedbox.dart';

RxInt packageCounts = 0.obs;
RxInt availablePackageCounts = 0.obs;
RxInt overduePackageCounts = 0.obs;

class MainHomeScreen extends StatefulWidget {
  MainHomeScreen({
    super.key,
    required this.selectedIndex,
    this.id,
    this.staffFirstname,
    this.staffImage,
  });

  final String? id;
  final String? staffFirstname;
  final String? staffImage;

  RxInt selectedIndex;

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  late Timer _timer;
  GetStorage box = GetStorage();
  TextEditingController trnController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 20), (Timer t) async {
      if (!isPopShown.value) {
        print('FEEDBACK SHOW FROM TIMER');
        ShowFeedBackPopup feedBackPopup = ShowFeedBackPopup();
        await feedBackPopup.callApi(context: context);
      }
    });
    if (box.read(StorageKey.isTrnEnter) != "1") {
      if (GlobalSingleton.userLoginDetails!.showTrnPopup == 1) {
        Future.delayed(Duration.zero, () {
          trnDialog(context);
        });
      }
    }
  }

  void showADialog() {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          actions: [
            TextButton(
              onPressed: () {
                isPopShown.value = false;
                Navigator.pop(ctx);
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        HomeScreen(
          id: widget.id,
          staffFirstname: widget.staffFirstname,
          staffImage: widget.staffImage,
        ),
        const ScannerScreen(),
        const ShippingScreen(
          isFromeHome: false,
        ),
        const AvailablePackagesScreen(fromHome: true),
        const OverdueScreen(),
        const MoreScreen(),
      ][widget.selectedIndex.value],
      bottomNavigationBar: Obx(
        () => Container(
          height: 80,
          padding: const EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            color: greyColor.withOpacity(0.2),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.selectedIndex.value = 0;
                    });
                  },
                  child: Image.asset(
                    homeIcon,
                    color: widget.selectedIndex.value == 0 ? null : Colors.grey,
                    height: 24,
                    width: 24,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.selectedIndex.value = 1;
                    });
                  },
                  child: Image.asset(
                    scannerIcon,
                    color: widget.selectedIndex.value == 1 ? null : Colors.grey,
                    height: 24,
                    width: 24,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.selectedIndex.value = 2;
                    });
                  },
                  child: b.Badge(
                    showBadge: packageCounts.value > 0,
                    badgeStyle: const b.BadgeStyle(
                      shape: b.BadgeShape.instagram,
                    ),
                    badgeContent: Text(
                      '${packageCounts.value}',
                      style: lightText12.copyWith(
                        color: whiteColor,
                      ),
                    ),
                    child: Image.asset(
                      shippingIcon,
                      color:
                          widget.selectedIndex.value == 2 ? null : Colors.grey,
                      height: 24,
                      width: 24,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.selectedIndex.value = 3;
                    });
                  },
                  child: b.Badge(
                    showBadge: availablePackageCounts.value > 0,
                    badgeStyle: const b.BadgeStyle(
                      shape: b.BadgeShape.instagram,
                    ),
                    badgeContent: Text(
                      '${availablePackageCounts.value}',
                      style: lightText12.copyWith(
                        color: whiteColor,
                      ),
                    ),
                    child: Image.asset(
                      availablePackagesIcon,
                      color:
                          widget.selectedIndex.value == 3 ? null : Colors.grey,
                      height: 24,
                      width: 24,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.selectedIndex.value = 4;
                    });
                  },
                  child: b.Badge(
                    showBadge: overduePackageCounts.value > 0,
                    badgeStyle: const b.BadgeStyle(
                      shape: b.BadgeShape.instagram,
                    ),
                    badgeContent: Text(
                      '${overduePackageCounts.value}',
                      style: lightText12.copyWith(
                        color: whiteColor,
                      ),
                    ),
                    child: Image.asset(
                      deliveryIcon,
                      color:
                          widget.selectedIndex.value == 4 ? null : Colors.grey,
                      height: 24,
                      width: 24,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.selectedIndex.value = 5;
                    });
                  },
                  child: Icon(
                    Icons.more_horiz_rounded,
                    color:
                        widget.selectedIndex.value == 5 ? primary : Colors.grey,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void trnDialog(
    BuildContext context,
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: StatefulBuilder(builder: (ctx, set) {
          return Dialog(
            insetPadding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  height15,
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15.0,
                    ),
                    child: Text(
                      'TRN',
                      style: mediumText18,
                    ),
                  ),
                  const Divider(),
                  height10,
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      GlobalSingleton.userLoginDetails!.trnPopupMessage
                          .toString(),
                      style: regularText14,
                    ),
                  ),
                  height10,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 280,
                          height: 90,
                          child: TextFormFieldWidget(
                            maxLines: 1,
                            controller: trnController,
                            hintText: "Enter TRN",
                            contentPadding: const EdgeInsets.all(10),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "";
                              } else if (value.length < 9) {
                                return "Enter Valid TRN";
                              } else {
                                return null;
                              }
                            },
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(9),
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            saveTrn(ctx);
                          }
                        },
                        child: const Text(
                          'Done',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Future<void> saveTrn(BuildContext context) async {
    final data = dio.FormData.fromMap({
      'trn_number': trnController.text,
    });
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
        url: ApiEndPoints.apiEndPoint + ApiEndPoints.trnNumberSave,
        data: data,
        context: context);

    if (response != null && response['status'] == 200) {
      box.write(StorageKey.isTrnEnter, "1");
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } else {
      NetworkDio.showError(
        title: 'Error',
        errorMessage: response!['message'],
      );
    }
  }
}
