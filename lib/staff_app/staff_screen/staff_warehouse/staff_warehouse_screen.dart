import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_cart_express/e_commerce_app/e_constant/e_storage_key.dart';
import 'package:my_cart_express/order_tracking_app/constant/app_endpoints.dart';
import 'package:my_cart_express/order_tracking_app/constant/sizedbox.dart';
import 'package:my_cart_express/order_tracking_app/screens/authentication/login/login_screen.dart';
import 'package:my_cart_express/order_tracking_app/theme/colors.dart';
import 'package:my_cart_express/order_tracking_app/theme/text_style.dart';
import 'package:my_cart_express/order_tracking_app/utils/global_singleton.dart';
import 'package:my_cart_express/order_tracking_app/utils/network_dio.dart';
import 'package:my_cart_express/staff_app/staff_binding/staff_main_home_binding..dart';
import 'package:my_cart_express/staff_app/staff_model/staff_scanned_bin_list_model.dart';
import 'package:my_cart_express/staff_app/staff_screen/staff_main_home_page.dart';
import 'package:my_cart_express/staff_app/staff_screen/staff_warehouse/refer_all_packages_screen.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:dio/dio.dart' as dio;

class StaffWarehouseScreen extends StatefulWidget {
  const StaffWarehouseScreen({super.key});

  @override
  State<StaffWarehouseScreen> createState() => _StaffWarehouseScreenState();
}

class _StaffWarehouseScreenState extends State<StaffWarehouseScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR Scanner');
  QRViewController? controller;
  GetStorage box = GetStorage();
  void _onQRViewCreated(QRViewController controller) async {
    setState(() {
      this.controller = controller;
    });
    if (Platform.isAndroid) {
      await this.controller!.resumeCamera();
    }

    controller.scannedDataStream.listen((scanData) async {
      // if (!Get.isSnackbarOpen) {
      if (scanData.code != null) {
        if (scanData.code!.startsWith('BIN')) {
          NetworkDio.showSuccess(
              title: 'BIN QR code successfully', sucessMessage: '');
          controller.pauseCamera();
          // print(scanData.code);
          getScannerPackgeList(context, scanData.code);
        } else {
          controller.pauseCamera();
          NetworkDio.showError(
            title: 'Invalid Bin QR code',
            errorMessage: '',
          );
          Future.delayed(
            const Duration(seconds: 3),
            () {
              controller.resumeCamera();
            },
          );
        }
      }
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    // if (!p && !showPermissionDialog.value) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(content: Text('Turn on permissions')),
    //   );
    //   showPermissionDialog.value = true;
    // }
  }

  Future<void> getScannerPackgeList(context, binID) async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
      context: context,
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.getScannedBinPackageList,
      data: dio.FormData.fromMap({
        'bin_code': binID, // "BIN-37851496"
      }),
    );
    GetAllScannedPackagesModel res =
        GetAllScannedPackagesModel.fromJson(response!);
    Get.to(() => ReferAllPackagesScreen(
          dataList: res.packageList ?? [],
          binId: binID,
        ))?.then((value) {
      controller!.resumeCamera();
    });

    // log(response.toString());
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
                leading: const SizedBox(),
                centerTitle: true,
                elevation: 0.0,
                title: const Text(
                  'Scan Bin QR',
                ),
                actions: [
                  width5,
                  GestureDetector(
                    onTap: () {
                      showThreeDotDialog(context);
                    },
                    child: const Icon(
                      Icons.more_vert_outlined,
                    ),
                  ),
                ],
              ),
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
      ),
    );
  }

  Future<void> logOutOnTap() async {
    box.write(EStorageKey.eIsLogedIn, false);
    Get.offAll(
      () => LoginScreen(),
    );
  }

  void showThreeDotDialog(BuildContext context) {
    showModalBottomSheet<int>(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext ctx) {
        return SafeArea(
          child: Container(
            height: 100,
            margin: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      Navigator.pop(ctx);
                      GlobalSingleton.page = null;
                      Get.offAll(
                        () => const StaffMainHome(),
                        binding: StaffMainHomeBinding(),
                      );
                    },
                    child: Center(
                      child: Text(
                        'Dashboard',
                        style: regularText16.copyWith(color: primary),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 1,
                  color: Colors.grey,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      Navigator.pop(ctx);
                      await logOutOnTap();
                    },
                    child: Center(
                      child: Text(
                        'Logout',
                        style: regularText16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget bodyView() {
    return Column(
      children: [
        // Obx(
        //   () => imageList.isNotEmpty
        //       ? Stack(
        //           alignment: Alignment.center,
        //           children: [
        //             CarouselSlider.builder(
        //               itemCount: imageList.length,
        //               carouselController: carouselController,
        //               options: CarouselOptions(
        //                 enlargeCenterPage: true,
        //                 padEnds: true,
        //                 viewportFraction: 1.0,
        //                 height: 200,
        //                 autoPlay: imageList.length > 1,
        //                 scrollPhysics: imageList.length > 1
        //                     ? const AlwaysScrollableScrollPhysics()
        //                     : const NeverScrollableScrollPhysics(),
        //                 autoPlayInterval: const Duration(seconds: 6),
        //               ),
        //               itemBuilder: (context, i, id) {
        //                 return InkWell(
        //                   onTap: () {
        //                     redirectHome(i);
        //                   },
        //                   child: Container(
        //                     decoration: BoxDecoration(
        //                       color: greyColor.withOpacity(.2),
        //                       borderRadius: BorderRadius.circular(15),
        //                       border: Border.all(
        //                         color: Colors.white,
        //                       ),
        //                     ),
        //                     child: ClipRRect(
        //                       borderRadius: BorderRadius.circular(15),
        //                       child: networkImage(
        //                         imageList[i]['image_url'],
        //                         width: Get.width,
        //                         fit: BoxFit.cover,
        //                       ),
        //                     ),
        //                   ),
        //                 );
        //               },
        //             ),
        //             if (imageList.length > 1)
        //               Row(
        //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                 children: [
        //                   Container(
        //                     padding: const EdgeInsets.only(left: 10),
        //                     height: 200,
        //                     width: 100,
        //                     decoration: const BoxDecoration(
        //                       borderRadius: BorderRadius.only(
        //                         bottomLeft: Radius.circular(15),
        //                         topLeft: Radius.circular(15),
        //                       ),
        //                     ),
        //                     child: Row(
        //                       children: [
        //                         InkWell(
        //                           onTap: () {
        //                             carouselController.previousPage();
        //                           },
        //                           child: Image.asset(
        //                             arrowLeft,
        //                             height: 24,
        //                             width: 24,
        //                             color: whiteColor,
        //                           ),
        //                         ),
        //                       ],
        //                     ),
        //                   ),
        //                   Container(
        //                     height: 200,
        //                     width: 100,
        //                     padding: const EdgeInsets.only(right: 10),
        //                     decoration: const BoxDecoration(
        //                       borderRadius: BorderRadius.only(
        //                         bottomRight: Radius.circular(15),
        //                         topRight: Radius.circular(15),
        //                       ),
        //                     ),
        //                     child: Row(
        //                       mainAxisAlignment: MainAxisAlignment.end,
        //                       children: [
        //                         InkWell(
        //                           onTap: () {
        //                             carouselController.nextPage();
        //                           },
        //                           child: Image.asset(
        //                             arrowRight,
        //                             height: 24,
        //                             width: 24,
        //                             color: whiteColor,
        //                           ),
        //                         ),
        //                       ],
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //           ],
        //         )
        //       : const SizedBox(),
        // ),
        // Obx(() => imageList.isNotEmpty ? height10 : const SizedBox()),
        Text(
          'Scan the QR code of the Bin',
          style: lightText14.copyWith(
            color: primary,
          ),
        ),
        // height5,
        // Text(
        //   'Scan the QR code for package add to bin',
        //   style: lightText14.copyWith(
        //     color: primary,
        //   ),
        // ),
        // height10,
        Expanded(
          flex: 5,
          child: QRView(
            key: qrKey,
            onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
            overlay: QrScannerOverlayShape(
              borderColor: Colors.red,
              borderRadius: 8,
            ),
            onQRViewCreated: _onQRViewCreated,
          ),
        ),
        // height10,
        // const Icon(Icons.arrow_drop_up_rounded),
        // height5,
        // Text(
        //   'Scan QR code to check in',
        //   style: regularText14.copyWith(
        //     color: primary,
        //   ),
        // ),
      ],
    );
  }
}
