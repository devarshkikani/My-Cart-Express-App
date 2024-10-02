import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cart_express/staff_app/staff_screen/staff_pos/close_drawer/drawer_details/drawer_details_controller.dart';

class DrawerDetailsScreen extends StatefulWidget {
  const DrawerDetailsScreen({super.key});

  @override
  State<DrawerDetailsScreen> createState() => _DrawerDetailsScreenState();
}

class _DrawerDetailsScreenState extends State<DrawerDetailsScreen> {
  final DrawerDetailsController _ =
      Get.put<DrawerDetailsController>(DrawerDetailsController());

  @override
  void initState() {
    _.drawerDetails(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: const Text(
          'Drawer Details',
        ),
      ),
      body: ListView(
        children: [],
      ),
    );
  }
}
