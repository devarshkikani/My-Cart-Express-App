// import 'dart:developer';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:my_cart_express/constant/sizedbox.dart';
// import 'package:my_cart_express/theme/colors.dart';
// import 'package:my_cart_express/theme/text_style.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';

// class ScannerScreen extends StatefulWidget {
//   const ScannerScreen({super.key});

//   @override
//   State<ScannerScreen> createState() => _ScannerScreenState();
// }

// class _ScannerScreenState extends State<ScannerScreen> {
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//   Barcode? result;
//   QRViewController? controller;

//   // In order to get hot reload to work we need to pause the camera if the platform
//   // is android, or resume the camera if the platform is iOS.
//   @override
//   void reassemble() {
//     super.reassemble();
//     if (Platform.isAndroid) {
//       controller!.pauseCamera();
//     } else if (Platform.isIOS) {
//       controller!.resumeCamera();
//     }
//   }

//   void _onQRViewCreated(QRViewController controller) {
//     this.controller = controller;
//     controller.scannedDataStream.listen((scanData) {
//       setState(() {
//         result = scanData;
//       });
//     });
//   }

//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: Get.height,
//         color: primary,
//         child: SafeArea(
//           child: Column(
//             children: [
//               AppBar(
//                 leading: const SizedBox(),
//                 centerTitle: true,
//                 elevation: 0.0,
//                 title: const Text(
//                   'MyCartExpress',
//                 ),
//               ),
//               Expanded(
//                 child: Container(
//                   padding: const EdgeInsets.all(15),
//                   decoration: const BoxDecoration(
//                     color: offWhite,
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(20),
//                       topRight: Radius.circular(20),
//                     ),
//                   ),
//                   child: bodyView(),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget bodyView() {
//     return Column(
//       children: [
//         Row(
//           children: [
//             Text(
//               'Store Check In',
//               style: regularText18,
//             ),
//           ],
//         ),
//         height10,
//         Text(
//           'In Store?',
//           style: lightText14.copyWith(
//             color: primary,
//           ),
//         ),
//         height5,
//         Text(
//           'Request your package',
//           style: lightText14.copyWith(
//             color: primary,
//           ),
//         ),
//         height10,
//         Expanded(
//           flex: 5,
//           child: QRView(
//             key: qrKey,
//             onPermissionSet: (p0, p1) {
//               log('p0 ::: $p0 |||| p1 ::: $p1');
//             },
//             overlay: QrScannerOverlayShape(
//               borderColor: Colors.red,
//               borderRadius: 8,
//             ),
//             onQRViewCreated: _onQRViewCreated,
//           ),
//         ),
//         height10,
//         const Icon(Icons.arrow_drop_up_rounded),
//         height5,
//         Text(
//           'Scab QR code to check in',
//           style: regularText14.copyWith(
//             color: primary,
//           ),
//         ),
//       ],
//     );
//   }
// }
