// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:my_cart_express/order_tracking_app/theme/colors.dart';
import 'package:my_cart_express/order_tracking_app/theme/text_style.dart';
import 'package:my_cart_express/order_tracking_app/constant/sizedbox.dart';
import 'package:my_cart_express/order_tracking_app/utils/network_dio.dart';
import 'package:my_cart_express/order_tracking_app/constant/app_endpoints.dart';
import 'package:my_cart_express/order_tracking_app/widget/location_permission_screen.dart';
import 'package:my_cart_express/order_tracking_app/screens/scanner_screen/scan_success_screen.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

Position? currentPosition;

class _ScannerScreenState extends State<ScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  RxBool isAPICalling = false.obs;
  RxList availablePackages = [].obs;
  RxMap availablePackagesData = {}.obs;
  RxBool showPermissionDialog = true.obs;
  @override
  void initState() {
    super.initState();
    getCameraPermission();
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.resumeCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  void _onQRViewCreated(QRViewController controller) async {
    setState(() {
      this.controller = controller;
    });
    if (Platform.isAndroid) {
      await this.controller!.resumeCamera();
    }

    controller.scannedDataStream.listen((scanData) async {
      if (!Get.isSnackbarOpen && !isAPICalling.value) {
        if (scanData.code != null) {
          if (currentPosition != null) {
            if (scanData.code!.contains('BRANCH')) {
              getAvailablePackages(scanData.code!);
            } else {
              NetworkDio.showError(
                title: 'Failed',
                errorMessage: 'Invalid QR Code',
              );
            }
          } else {
            await getCurrentPosition();
            NetworkDio.showError(
              title: 'Wait',
              errorMessage: 'We fetching your current location',
            );
          }
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

  Future<bool> handleLocationPermission() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.to(() => const LocationPermissionScreen());
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Get.to(() => const LocationPermissionScreen());
      return false;
    }
    return true;
  }

  Future getCameraPermission() async {
    final PermissionStatus status = await Permission.camera.request();
    if (status.isPermanentlyDenied || status.isDenied) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Turn on camera permission'),
          action: SnackBarAction(
            label: 'Open Setting',
            textColor: blackColor,
            onPressed: () {
              openAppSettings().then((value) {
                setState(() {});
              });
            },
          ),
        ),
      );
    }
    await getCurrentPosition();
  }

  Future<void> getCurrentPosition() async {
    final bool hasPermission = await handleLocationPermission();

    if (!hasPermission) {
      return;
    }
    try {
      final Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      currentPosition = position;
      return;
    } on Position catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> getAvailablePackages(String barcode) async {
    isAPICalling.value = true;
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.availableShipping,
      context: context,
      data: dio.FormData.fromMap({
        "offset": 0,
        "limit": 10,
        "branch_qr_code": barcode,
        "latitude": currentPosition?.latitude,
        "longitude": currentPosition?.longitude,
      }),
    );
    isAPICalling.value = false;
    if (response != null) {
      availablePackages.value = response['list'];
      availablePackagesData.value = {
        "counts": response['counts'],
        "due": response['due'],
      };
      Get.to(ScanSuccessScreen(
        availablePackages: availablePackages,
        availablePackagesData: availablePackagesData,
      ));
    }
  }

  @override
  void dispose() {
    controller?.dispose();
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
                leading: const SizedBox(),
                centerTitle: true,
                elevation: 0.0,
                title: const Text(
                  'MyCartExpress',
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
        Row(
          children: [
            Text(
              'Store Check In',
              style: regularText18,
            ),
          ],
        ),
        height10,
        Text(
          'In Store?',
          style: lightText14.copyWith(
            color: primary,
          ),
        ),
        height5,
        Text(
          'Request your package',
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
        height10,
        const Icon(Icons.arrow_drop_up_rounded),
        height5,
        Text(
          'Scan QR code to check in',
          style: regularText14.copyWith(
            color: primary,
          ),
        ),
      ],
    );
  }
}
