import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_cart_express/e_commerce_app/e_constant/e_storage_key.dart';
import 'package:my_cart_express/e_commerce_app/e_routes/e_app_pages.dart';
import 'package:my_cart_express/e_commerce_app/e_theme/e_app_colors.dart';
import 'package:my_cart_express/e_commerce_app/e_widget/bottom_navigation/c_curved_navigation_bar.dart';
import 'package:my_cart_express/order_tracking_app/constant/default_images.dart';
import 'package:my_cart_express/order_tracking_app/constant/storage_key.dart';
import 'package:my_cart_express/order_tracking_app/utils/global_singleton.dart';
import 'package:my_cart_express/staff_app/staff_screen/staff_dashboard/staff_dashboard_screen.dart';
import 'package:my_cart_express/staff_app/staff_screen/staff_pickup_request/staff_pickup_request_screen.dart';
import 'package:my_cart_express/staff_app/staff_screen/staff_pos/staff_pos_screen.dart';
import 'package:my_cart_express/staff_app/staff_screen/staff_warehouse/staff_warehouse_screen.dart';

// class StaffMainHome extends GetView<StaffMainHomeController> {
//   const StaffMainHome({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: controller.pageList.isEmpty
//           ? Container()
//           : Obx(() => controller.page == null
//               ? controller.dashboardist[controller.bottomDashboardValue.value]
//               : controller.pageList[controller.page!.value]),
//       bottomNavigationBar: Obx(
//         () => BottomNavigationBar(
//           key: controller.bottomNavigationKey,
//           currentIndex: controller.page == null
//               ? controller.bottomDashboardValue.value
//               : controller.page!.value,
//           items: controller.getNavigationBarItems(),
//           backgroundColor: Theme.of(context).colorScheme.background,
//           unselectedIconTheme: const IconThemeData(color: blackColor),
//           unselectedLabelStyle: const TextStyle(color: blackColor),
//           unselectedItemColor: blackColor,
//           showUnselectedLabels: true,
//           onTap: (int index) {
//             controller.navIconTap(index);
//           },
//         ),
//       ),
//     );
//   }

// }

class StaffMainHome extends StatefulWidget {
  const StaffMainHome({super.key});

  @override
  State<StaffMainHome> createState() => _MyStaffMainHome();
}

class _MyStaffMainHome extends State<StaffMainHome> {
  GlobalKey<CurvedNavigationBarState> bottomNavigationKey = GlobalKey();
  GetStorage box = GetStorage();
  List pageList = [];
  List dashboardist = [];
  RxInt bottomDashboardValue = 0.obs;

  @override
  void initState() {
    box.read(StorageKey.staffBottomModual).forEach((key, value) {
      pageList.add(allPages[key]);
    });
    dashboardist.add(const StaffDashboardScreen());
    super.initState();
  }

  final Map<String, Widget> allPages = {
    "pickup_request":
        const StaffPickupRequestScreen(), //const StaffDashboardScreen()
    "customer_pos": const StaffPosScreen(),
    "warehouse_add_to_bin": const StaffWarehouseScreen(),
    "transit_scan": Container(),
    "customer_lookup": Container(),
    "kiosk": Container(),
  };

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
    if (GlobalSingleton.page == null) {
      GlobalSingleton.page = index.obs;
    } else {
      GlobalSingleton.page!.value = index;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageList.isEmpty
          ? Container()
          : GlobalSingleton.page == null
              ? dashboardist[bottomDashboardValue.value]
              : pageList[GlobalSingleton.page!.value],
      bottomNavigationBar: BottomNavigationBar(
        key: bottomNavigationKey,
        currentIndex: GlobalSingleton.page == null
            ? bottomDashboardValue.value
            : GlobalSingleton.page!.value,
        items: getNavigationBarItems(),
        backgroundColor: Theme.of(context).colorScheme.background,
        unselectedIconTheme: const IconThemeData(color: blackColor),
        unselectedLabelStyle: const TextStyle(color: blackColor),
        unselectedItemColor: blackColor,
        showUnselectedLabels: true,
        onTap: (int index) {
          navIconTap(index);
        },
      ),
    );
  }
}
