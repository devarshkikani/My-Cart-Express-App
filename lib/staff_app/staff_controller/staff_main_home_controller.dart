import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_cart_express/e_commerce_app/e_widget/bottom_navigation/c_curved_navigation_bar.dart';
import 'package:my_cart_express/order_tracking_app/constant/storage_key.dart';
import 'package:my_cart_express/order_tracking_app/models/user_model.dart';
import 'package:my_cart_express/staff_app/staff_screen/staff_pickup_request/staff_pickup_request_screen.dart';
import 'package:my_cart_express/staff_app/staff_screen/staff_pos/staff_pos_screen.dart';
import 'package:my_cart_express/staff_app/staff_screen/staff_warehouse_add_tobin/staff_warehouse_add_tobin_screen.dart';

class StaffMainHomeController extends GetxController {
  GlobalKey<CurvedNavigationBarState> bottomNavigationKey = GlobalKey();
  GetStorage box = GetStorage();
  List<Widget> pageList = <Widget>[
    Container(),
    Container(),
    Container(),
    Container(),
    Container(),
    Container(),
    Container(),
    Container(),
    // const StaffPickupRequestScreen(),
    // const StaffPosScreen(),
    // const StaffWarehouseAddTobinScreen(),
  ];

  RxInt page = 0.obs;
  var modules = {
    "warehouse_add_to_bin": 1,
    "customer_pos": 1,
    "pickup_request": 1,
    "kiosk": 0,
    "customer_lookup": 0,
    "transit_scan": 1
  }.obs;

  final moduleIcons = {
    "pickup_request": const Icon(Icons.qr_code),
    "customer_pos": const Icon(Icons.credit_card),
    "warehouse_add_to_bin": const Icon(Icons.favorite_rounded),
    "kiosk": const Icon(Icons.store),
    "customer_lookup": const Icon(Icons.search),
    "transit_scan": const Icon(Icons.local_shipping),
  };

  final moduleLabels = {
    "pickup_request": 'Pickup Request',
    "customer_pos": 'POS',
    "warehouse_add_to_bin": 'Warehouse Add to Bin',
    "kiosk": 'Kiosk',
    "customer_lookup": 'Customer Lookup',
    "transit_scan": 'Transit Scan',
  };

  List<BottomNavigationBarItem> getNavigationBarItems() {
    List<BottomNavigationBarItem> items = [];

    print(box.read(StorageKey.staffBottomModual));
    // StaffBottomModule.fromJson(json)
    box.read(StorageKey.staffBottomModual).forEach((key, value) {
      if (value == 1) {
        items.add(
          BottomNavigationBarItem(
            icon: moduleIcons[key]!,
            label: moduleLabels[key]!,
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
