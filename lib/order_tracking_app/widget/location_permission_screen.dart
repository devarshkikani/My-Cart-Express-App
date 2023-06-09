// ignore_for_file: use_build_context_synchronously

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:my_cart_express/order_tracking_app/theme/text_style.dart';
import 'package:my_cart_express/order_tracking_app/utils/progress_indicator.dart';
import 'package:my_cart_express/order_tracking_app/screens/scanner_screen/scanner_screen.dart';

class LocationPermissionScreen extends StatefulWidget {
  const LocationPermissionScreen({super.key});

  @override
  State<LocationPermissionScreen> createState() =>
      _LocationPermissionScreenState();
}

class _LocationPermissionScreenState extends State<LocationPermissionScreen>
    with WidgetsBindingObserver {
  static Circle processIndicator = Circle();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      processIndicator.show(context);
      final Future<bool> isLocationGet = getCurrentPosition();
      if (await isLocationGet) {
        Navigator.pop(context);
        processIndicator.hide(context);
      } else {
        processIndicator.hide(context);
      }
    }
  }

  Future<bool> getCurrentPosition() async {
    final bool hasPermission = await handleLocationPermission();

    if (!hasPermission) {
      return false;
    }
    try {
      final Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      currentPosition = position;
      return true;
    } on Position catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  Future<bool> handleLocationPermission() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return currentPosition != null;
      },
      child: Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Add Your Current Location',
                style: mediumText24,
              ),
              const SizedBox(
                height: 60,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Center(
                  child: Text(
                    '''Location services permission is required to find outlets nearby.''',
                    style: regularText18,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      maximumSize: Size(Get.width, 50),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      await Geolocator.openAppSettings();
                    },
                    child: const Text(
                      'Open Settings',
                      style: TextStyle(
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
