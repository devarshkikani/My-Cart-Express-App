// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:just_audio/just_audio.dart';
import 'package:my_cart_express/order_tracking_app/constant/default_images.dart';
import 'package:my_cart_express/order_tracking_app/screens/home_screen/home_screen_controller.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:my_cart_express/order_tracking_app/theme/colors.dart';
import 'package:my_cart_express/order_tracking_app/theme/text_style.dart';
import 'package:my_cart_express/order_tracking_app/constant/sizedbox.dart';
import 'package:my_cart_express/order_tracking_app/utils/network_dio.dart';
import 'package:my_cart_express/order_tracking_app/constant/app_endpoints.dart';
import 'package:my_cart_express/order_tracking_app/screens/scanner_screen/scan_success_screen.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

Position? currentPosition;

class _ScannerScreenState extends State<ScannerScreen> {
  CarouselController carouselController = CarouselController();

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  RxBool isAPICalling = false.obs;
  RxList availablePackages = [].obs;
  RxMap availablePackagesData = {}.obs;
  RxBool showPermissionDialog = true.obs;
  final player = AudioPlayer();
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
          if (showLocation.value == '1') {
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
              NetworkDio.showError(
                title: 'Wait',
                errorMessage: 'We fetching your current location',
              );
            }
          } else if (scanData.code!.contains('BRANCH')) {
            getAvailablePackages(scanData.code!);
          } else {
            NetworkDio.showError(
              title: 'Failed',
              errorMessage: 'Invalid QR Code',
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
  }

  Future<void> getAvailablePackages(String barcode) async {
    isAPICalling.value = true;
    Map<String, dynamic> mapData = {
      "offset": 0,
      "limit": 10,
      "branch_qr_code": barcode,
    };
    if (showLocation.value == '1') {
      mapData["latitude"] = currentPosition?.latitude;
      mapData["longitude"] = currentPosition?.longitude;
    }
    dio.FormData data = dio.FormData.fromMap(mapData);
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.availableShipping,
      context: context,
      data: data,
    );
    if (response != null) {
      await player.setUrl(response['scan_success_music']);
      player.play();
      availablePackages.value = response['list'];
      availablePackagesData.value = {
        "counts": response['counts'],
        "due": response['due'],
      };
      Get.to(
        ScanSuccessScreen(
          barcode: barcode,
          availablePackages: availablePackages,
          availablePackagesData: availablePackagesData,
        ),
      );
    }
    isAPICalling.value = false;
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
                leading: const SizedBox(),
                centerTitle: true,
                elevation: 0.0,
                title: const Text(
                  'Store Check In',
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
        Obx(
          () => imageList.isNotEmpty
              ? Stack(
                  alignment: Alignment.center,
                  children: [
                    CarouselSlider.builder(
                      itemCount: imageList.length,
                      carouselController: carouselController,
                      options: CarouselOptions(
                        enlargeCenterPage: true,
                        padEnds: true,
                        viewportFraction: 1.0,
                        height: 200,
                        autoPlay: imageList.length > 1,
                        scrollPhysics: imageList.length > 1
                            ? const AlwaysScrollableScrollPhysics()
                            : const NeverScrollableScrollPhysics(),
                        autoPlayInterval: const Duration(seconds: 6),
                      ),
                      itemBuilder: (context, i, id) {
                        return InkWell(
                          onTap: () {
                            redirectHome(i);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: Colors.white,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                imageList[i]['image_url'],
                                width: Get.width,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    if (imageList.length > 1)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 10),
                            height: 200,
                            width: 100,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                topLeft: Radius.circular(15),
                              ),
                            ),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    carouselController.previousPage();
                                  },
                                  child: Image.asset(
                                    arrowLeft,
                                    height: 24,
                                    width: 24,
                                    color: whiteColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 200,
                            width: 100,
                            padding: const EdgeInsets.only(right: 10),
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () {
                                    carouselController.nextPage();
                                  },
                                  child: Image.asset(
                                    arrowRight,
                                    height: 24,
                                    width: 24,
                                    color: whiteColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                  ],
                )
              : const SizedBox(),
        ),
        Obx(() => imageList.isNotEmpty ? height10 : const SizedBox()),
        Text(
          'Picking up your packages?',
          style: lightText14.copyWith(
            color: primary,
          ),
        ),
        height5,
        Text(
          'Scan the QR code for Express Checkout',
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
