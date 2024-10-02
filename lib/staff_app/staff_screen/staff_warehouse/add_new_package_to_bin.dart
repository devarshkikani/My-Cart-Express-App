// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:my_cart_express/order_tracking_app/constant/app_endpoints.dart';
import 'package:my_cart_express/order_tracking_app/constant/default_images.dart';
import 'package:my_cart_express/order_tracking_app/constant/sizedbox.dart';
import 'package:my_cart_express/order_tracking_app/theme/colors.dart';
import 'package:my_cart_express/order_tracking_app/theme/text_style.dart';
import 'package:my_cart_express/order_tracking_app/utils/network_dio.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class AddNewPackageToBinScreen extends StatefulWidget {
  final String binCode;
  const AddNewPackageToBinScreen({super.key, required this.binCode});

  @override
  State<AddNewPackageToBinScreen> createState() =>
      _AddNewPackageToBinScreenState();
}

class _AddNewPackageToBinScreenState extends State<AddNewPackageToBinScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'Scan QR');
  QRViewController? controller;
  String? scannedPkgId;
  final player = AudioPlayer();
  Map<String, dynamic> pkdDetails = {};

  bool isFroDashboard = true;

  void _onQRViewCreated(QRViewController controller) async {
    setState(() {
      this.controller = controller;
    });
    if (Platform.isAndroid) {
      await this.controller!.resumeCamera();
    }

    controller.scannedDataStream.listen((Barcode scanData) async {
      // if (!Get.isSnackbarOpen) {
      if (scanData.code != null) {
        scannedPkgId = scanData.code;
        controller.pauseCamera();

        await player.setAsset(scannerBeep);
        player.play();

        getPackageCustomerDetailsApi(context, scanData.code);
        // NetworkDio.showSuccess(
        //     title: 'Package QR code Scan successfully', sucessMessage: '');
      }
    });
    setState(() {});
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    // if (!p && !showPermissionDialog.value) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(content: Text('Turn on permissions')),
    //   );
    //   showPermissionDialog.value = true;
    // }
  }

  Future<void> getScannerPackgeList(context, binID, pkgId) async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
      context: context,
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.addToBin,
      data: dio.FormData.fromMap({
        'bin_code': binID, // "BIN-37851496"
        'shipping_mcecode': pkgId,
      }),
    );
    if (response != null &&
        response['status'] == 20 &&
        response['message'] != "Getting issue whiile binning package.") {
      NetworkDio.showSuccess(
          title: 'Success', sucessMessage: response['message']);
    } else {
      NetworkDio.showSuccess(
          title: 'Error', sucessMessage: response!['message']);
    }
    Navigator.pop(context);
    // await controller!.resumeCamera();
  }

  Future<void> getPackageCustomerDetailsApi(context, pkgId) async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
      context: context,
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.getPackageCustomerDetails,
      data: dio.FormData.fromMap({
        'shipping_mcecode': pkgId,
      }),
    );
    if (response != null && response['status'] == 200) {
      pkdDetails = response ?? {};
      if (pkdDetails.isNotEmpty) {
        customDialog(pkdDetails);
      }
    } else {
      NetworkDio.showError(
          title: 'Error', errorMessage: response!['message']);
    }
    await controller!.resumeCamera();
  }

  @override
  void dispose() {
    controller?.dispose();
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.height,
        color: primary,
        child: isFroDashboard == true
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  height15,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 45),
                    child: Text(
                      "Go and scan all package for your bin",
                      textAlign: TextAlign.center,
                      style: mediumText20.copyWith(color: whiteColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Image.asset(
                      scannerImage,
                      height: 200,
                      width: 200,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      isFroDashboard = false;
                      setState(() {});
                    },
                    child: Container(
                      height: 50,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 30),
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'Get Start',
                          style: mediumText18,
                        ),
                      ),
                    ),
                  )
                ],
              )
            : SafeArea(
                child: Column(
                  children: [
                    AppBar(
                      centerTitle: true,
                      elevation: 0.0,
                      title: const Text(
                        'Add New Package to Bin',
                      ),
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
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              QRView(
                key: qrKey,
                onPermissionSet: (ctrl, p) =>
                    _onPermissionSet(context, ctrl, p),
                overlay: QrScannerOverlayShape(
                  borderColor: Colors.red,
                  borderRadius: 8,
                ),
                onQRViewCreated: _onQRViewCreated,
              ),
              Positioned(
                top: 10,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                  margin:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 30),
                  decoration: BoxDecoration(
                      color: primary, borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      widget.binCode,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: whiteColor,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  void customDialog(pkgDet) async {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Row(
          children: [
            const Text(
              'Package Details',
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                Navigator.pop(_);
              },
              child: const Icon(
                Icons.close_rounded,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            titleList(
                title1: "Customer",
                title2: "${pkgDet['package_data']['customer_name']}"),
            height5,
            titleList(
                title1: "PKG#",
                title2: "${pkgDet['package_data']['shipping_mcecode']}"),
            height5,
            titleList(
                title1: "Branch",
                title2: "${pkgDet['package_data']['branch_code']}"),
            height5,
            titleList(
                title1: "Weight",
                title2: "${pkgDet['package_data']['weight']}"),
            height5,
            titleList(
                title1: "Tracking#",
                title2: "${pkgDet['package_data']['tracking']}"),
            height5,
            titleList(
                title1: "Manifest",
                title2: "${pkgDet['package_data']['manifest_code'] ?? ""}"),
            height10,
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(200, 40),
                maximumSize: const Size(200, 50),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
              ),
              onPressed: () async {
                getScannerPackgeList(context, widget.binCode, scannedPkgId);
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Text(
                  'Scan Package',
                  style: TextStyle(
                    letterSpacing: 1,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Row titleList({
    title1,
    title2,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 70,
          child: Text(
            title1,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        width10,
        const Text(":"),
        width5,
        Expanded(
          child: Text(title2,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              )),
        ),
      ],
    );
  }

  Color _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor"; // Adding FF for full opacity
    }
    return Color(int.parse(hexColor, radix: 16));
  }
}
