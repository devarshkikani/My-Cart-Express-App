// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:my_cart_express/order_tracking_app/constant/app_endpoints.dart';
import 'package:my_cart_express/order_tracking_app/constant/default_images.dart';
import 'package:my_cart_express/order_tracking_app/constant/sizedbox.dart';
import 'package:my_cart_express/order_tracking_app/models/scanned_package_details.dart';
import 'package:my_cart_express/order_tracking_app/theme/colors.dart';
import 'package:my_cart_express/order_tracking_app/theme/text_style.dart';
import 'package:my_cart_express/order_tracking_app/utils/network_dio.dart';
import 'package:my_cart_express/staff_app/staff_screen/staff_pos/customer_available_packages.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class StaffCustomerPosScreen extends StatefulWidget {
  const StaffCustomerPosScreen({
    super.key,
  });

  @override
  State<StaffCustomerPosScreen> createState() => _StaffCustomerPosScreenState();
}

class _StaffCustomerPosScreenState extends State<StaffCustomerPosScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'Scan QR');
  QRViewController? controller;
  String? scannedPkgId;
  final player = AudioPlayer();
  Map<String, dynamic> pkdDetails = {};

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

  Future<void> getPackageCustomerDetailsApi(context, pkgId) async {
    final data = dio.FormData.fromMap({
      'shipping_mcecode': pkgId,
    });
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
        context: context,
        url: ApiEndPoints.apiEndPoint + ApiEndPoints.scanPosPackage,
        data: data);
    if (response != null && response['status'] == 200) {
      ScanPosPackageModel res = ScanPosPackageModel.fromJson(response);
      Get.to(() => CustomerAvailablePackages(
                data: res.data!,
              ))!
          .then((value) async => {await controller!.resumeCamera()});
    } else {
      await controller!.resumeCamera();
      NetworkDio.showSuccess(
          title: 'Error', sucessMessage: response!['message']);
    }
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
        child: SafeArea(
          child: Column(
            children: [
              AppBar(
                centerTitle: true,
                elevation: 0.0,
                title: const Text(
                  'Add New Package to Drawer',
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
        InkWell(
          onTap: () {
            // PKG871576
            getPackageCustomerDetailsApi(context, 'PKG871576');
          },
          child: Text(
            'Scan package',
            style: lightText14.copyWith(
              color: primary,
            ),
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
      ],
    );
  }
}
