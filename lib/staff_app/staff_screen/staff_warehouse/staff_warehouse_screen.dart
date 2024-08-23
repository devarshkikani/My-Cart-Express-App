import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_cart_express/e_commerce_app/e_constant/e_storage_key.dart';
import 'package:my_cart_express/e_commerce_app/e_routes/e_app_pages.dart';
import 'package:my_cart_express/order_tracking_app/constant/sizedbox.dart';
import 'package:my_cart_express/order_tracking_app/screens/authentication/login/login_screen.dart';
import 'package:my_cart_express/order_tracking_app/theme/colors.dart';
import 'package:my_cart_express/order_tracking_app/theme/text_style.dart';
import 'package:my_cart_express/order_tracking_app/utils/network_dio.dart';
import 'package:my_cart_express/staff_app/staff_screen/staff_warehouse/refer_all_packages_screen.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

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
        NetworkDio.showSuccess(
            title: 'Success', sucessMessage: 'Qr code scan succefully');
        controller.pauseCamera();
        Get.to(() => const ReferAllPackagesScreen())?.then((value) {
          controller.resumeCamera();
        });
        //     if (showLocation.value == '1') {
        //       if (currentPosition != null) {
        //         if (scanData.code!.contains('BRANCH')) {
        //           getAvailablePackages(scanData.code!);
        //         } else {
        //           NetworkDio.showError(
        //             title: 'Failed',
        //             errorMessage: 'Invalid QR Code',
        //           );
        //         }
        //       } else {
        //         NetworkDio.showError(
        //           title: 'Wait',
        //           errorMessage: 'We fetching your current location',
        //         );
        //       }
        //     } else if (scanData.code!.contains('BRANCH')) {
        //       getAvailablePackages(scanData.code!);
        //     } else {
        //       NetworkDio.showError(
        //         title: 'Failed',
        //         errorMessage: 'Invalid QR Code',
        //       );
        //     }
      }
      // }
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
                  'Add To Bin',
                ),
                actions: [
                  InkWell(
                    onTap: () {
                      box.write(EStorageKey.eIsLogedIn, false);
                      Get.offAll(
                        () => LoginScreen(),
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(15),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Logout",
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 18,
                          ),
                        ],
                      ),
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
          'Scan package',
          style: lightText14.copyWith(
            color: primary,
          ),
        ),
        height5,
        Text(
          'Scan the QR code for package add to bin',
          style: lightText14.copyWith(
            color: primary,
          ),
        ),
        height10,
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
