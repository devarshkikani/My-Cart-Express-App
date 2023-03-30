// // ignore_for_file: prefer_mixin

// import 'package:finder/constant/default_images.dart';
// import 'package:finder/constant/sizedbox.dart';
// import 'package:finder/screens/user_info_screen/location/location_screen_contorller.dart';
// import 'package:finder/theme/colors.dart';
// import 'package:finder/theme/text_style.dart';
// import 'package:finder/utils/progress_indicator.dart';
// import 'package:finder/widget/elevated_button.dart';
// import 'package:finder/widget/show_banner_ads.dart';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';

// class LocationPermissionScreen extends StatefulWidget {
//   const LocationPermissionScreen({super.key});

//   @override
//   State<LocationPermissionScreen> createState() =>
//       _LocationPermissionScreenState();
// }

// class _LocationPermissionScreenState extends State<LocationPermissionScreen>
//     with WidgetsBindingObserver {
//   static Circle processIndicator = Circle();

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
//   }

//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//   }

//   @override
//   Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
//     super.didChangeAppLifecycleState(state);
//     if (state == AppLifecycleState.resumed) {
//       processIndicator.show(context);
//       final Future<bool> isLocationGet = Get.find<LocationScreenController>()
//           .getCurrentPosition(isNavigate: false);
//       if (await isLocationGet) {
//         Get.back();
//         processIndicator.hide(context);
//       } else {
//         processIndicator.hide(context);
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: lightBlack,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: <Widget>[
//                 Center(
//                   child: Text(
//                     'Add Your \nCurrent Location',
//                     textAlign: TextAlign.center,
//                     style: boldText34.copyWith(
//                       color: primary,
//                       fontFamily: 'source_serif_pro',
//                     ),
//                   ),
//                 ),
//                 height10,
//                 Text(
//'''Location services permission is required to suggest you matches nearby.''',
//                   style: lightText14,
//                   textAlign: TextAlign.center,
//                 ),
//                 Image.asset(locationRequired),
//                 height20,
//                 Column(
//                   children: <Widget>[
//                     elevatedButton(
//                       title: 'Open Settings',
//                       onTap: () async {
//                         await Geolocator.openAppSettings();
//                       },
//                     ),
//                     height30,
//                     TextButton(
//                       style: TextButton.styleFrom(
//                         shape: const RoundedRectangleBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(12)),
//                         ),
//                         maximumSize: Size(Get.width / 2, 50),
//                       ),
//                       onPressed: () {
//                         Get.back();
//                       },
//                       child: Center(
//                         child: Text(
//                           'Close',
//                           style: mediumText16.copyWith(
//                             color: whiteColor,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       bottomNavigationBar: const ShowBannerAds(),
//     );
//   }
// }
