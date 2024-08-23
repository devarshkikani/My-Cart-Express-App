import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_cart_express/e_commerce_app/e_constant/e_storage_key.dart';
import 'package:my_cart_express/e_commerce_app/e_routes/e_app_pages.dart';
import 'package:my_cart_express/e_commerce_app/e_widget/bottom_navigation/c_curved_navigation_bar.dart';
import 'package:my_cart_express/order_tracking_app/constant/default_images.dart';
import 'package:my_cart_express/order_tracking_app/constant/storage_key.dart';
import 'package:my_cart_express/staff_app/staff_screen/staff_warehouse/staff_warehouse_screen.dart';
import 'package:my_cart_express/staff_app/staff_screen/staff_pos/staff_pos_screen.dart';
import 'package:my_cart_express/staff_app/staff_screen/staff_pickup_request/staff_pickup_request_screen.dart';

class StaffMainHomeController extends GetxController {
  GlobalKey<CurvedNavigationBarState> bottomNavigationKey = GlobalKey();
  GetStorage box = GetStorage();
  List pageList = [];

  @override
  void onInit() {
    box.read(StorageKey.staffBottomModual).forEach((key, value) {
      pageList.add(allPages[key]);
    });
    super.onInit();
  }

  final Map<String, Widget> allPages = {
    "pickup_request": const StaffPickupRequestScreen(),
    "customer_pos": const StaffPosScreen(),
    "warehouse_add_to_bin": const StaffWarehouseScreen(),
    "transit_scan": Container(),
    "customer_lookup": Container(),
    "kiosk": Container(),
  };

  RxInt page = 0.obs;

  final moduleIcons = {
    "pickup_request": Image.asset(pickupRequest),
    "customer_pos": Image.asset(helpandSupport),
    "warehouse_add_to_bin": Image.asset(wareHouse),
    "kiosk": Image.asset(kiosk),
    "customer_lookup": Image.asset(customerLookup),
    "transit_scan": Image.asset(wareHouse),
  };

  final moduleLabels = {
    "pickup_request": 'Pickup Request',
    "customer_pos": 'POS',
    "warehouse_add_to_bin": 'Warehouse Add to Bin',
    "kiosk": 'Kiosk',
    "customer_lookup": 'Customer Lookup',
    "transit_scan": 'Transit Scan',
  };

  void logoutPressed() {
    box.write(EStorageKey.eIsLogedIn, false);
    Get.offAllNamed(ERoutes.signUp);
  }

  List<BottomNavigationBarItem> getNavigationBarItems() {
    List<BottomNavigationBarItem> items = [];

    // print(box.read(StorageKey.staffBottomModual));
    box.read(StorageKey.staffBottomModual).forEach((key, value) {
      if (value == 1) {
        items.add(
          BottomNavigationBarItem(
            icon: moduleIcons[key]!,
            label: "",
          ),
        );
      }
    });
    return items;
  }

  void navIconTap(int index) {
    page.value = index;
    update();
  }
}
