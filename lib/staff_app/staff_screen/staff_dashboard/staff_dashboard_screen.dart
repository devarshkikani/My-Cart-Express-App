import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_cart_express/e_commerce_app/e_constant/e_sizedbox.dart';
import 'package:my_cart_express/e_commerce_app/e_constant/e_storage_key.dart';
import 'package:my_cart_express/e_commerce_app/e_theme/e_app_text_theme.dart';
import 'package:my_cart_express/order_tracking_app/constant/app_endpoints.dart';
import 'package:my_cart_express/order_tracking_app/constant/default_images.dart';
import 'package:my_cart_express/order_tracking_app/screens/authentication/login/login_screen.dart';
import 'package:my_cart_express/order_tracking_app/theme/colors.dart';
import 'package:my_cart_express/order_tracking_app/utils/global_singleton.dart';
import 'package:my_cart_express/order_tracking_app/utils/network_dio.dart';
import 'package:my_cart_express/order_tracking_app/widget/network_image_handle.dart';
import 'package:my_cart_express/staff_app/staff_model/get_staff_branches_model.dart';

class StaffDashboardScreen extends StatefulWidget {
  const StaffDashboardScreen({super.key});
  @override
  State<StaffDashboardScreen> createState() => _StaffDashboardScreenState();
}

class _StaffDashboardScreenState extends State<StaffDashboardScreen> {
  List<StaffBranch>? staffBranches = <StaffBranch>[];
  GetStorage box = GetStorage();

  @override
  void initState() {
    getStaffBranchesApi(context);
    super.initState();
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
                  'Staff Dashboard',
                ),
                actions: [
                  // actions: [
                  InkWell(
                    onTap: () {
                      box.write(EStorageKey.eIsLogedIn, false);

                      Get.offAll(
                        () => LoginScreen(),
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(15),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Logout",
                            style: TextStyle(color: whiteColor),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 18,
                            color: whiteColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  width: Get.width,
                  padding: const EdgeInsets.all(15),
                  decoration: const BoxDecoration(
                    color: offWhite,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: bodyView(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget bodyView(BuildContext context) {
    return Stack(
      children: [
        ListView(),
        ListView(
          children: [
            profileView(),
            if (staffBranches != null && staffBranches!.isNotEmpty)
              Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Associate Branches', style: boldText18),
                        const SizedBox(height: 10),
                        SizedBox(
                          child: ListView.builder(
                              itemCount: staffBranches!.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          '${index + 1}. ${staffBranches![index].parishname} - ${staffBranches![index].branchCode}',
                                          style: lightText16),
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ],
                    )),
              ),
          ],
        ),
      ],
    );
  }

  Widget profileView() {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: GlobalSingleton.userDetails['image'].toString().isEmpty ||
                  GlobalSingleton.userDetails['image'] == null
              ? Image.asset(
                  dummyProfileImage,
                  height: 100,
                  width: 100,
                )
              : networkImage(
                  GlobalSingleton.userDetails['image'].toString(),
                  fit: BoxFit.cover,
                  height: 100,
                  width: 100,
                ),
        ),
        height10,
        Text(
          GlobalSingleton.userDetails['name'].toString(),
          style: regularText18.copyWith(
            color: blackColor,
            letterSpacing: 0.3,
          ),
        ),
        height5,
        Text(
          'Staff ID : ${GlobalSingleton.userDetails['mce_number']}',
          style: lightText16,
        ),
        height5,
        Text(
          'Email : ${GlobalSingleton.userDetails['email']}',
          style: mediumText16,
        ),
        height5,
        Text(
          'Phone : ${GlobalSingleton.userDetails['phone']}',
          style: mediumText16,
        ),
        height5,
        const Divider(),
      ],
    );
  }

  Future<void> getStaffBranchesApi(BuildContext context) async {
    Map<String, dynamic>? response = await NetworkDio.getDioHttpMethod(
        url: ApiEndPoints.apiEndPoint + ApiEndPoints.getStaffBranches,
        context: context);

    if (response != null && response['status'] == 200) {
      staffBranches = GetStaffAllBranches.fromJson(response).staffBranches;
    } else {
      NetworkDio.showError(
        title: 'Error',
        errorMessage: response!['message'],
      );
    }
    setState(() {});
  }

  // Color _getColorFromHex(String hexColor) {
  //   hexColor = hexColor.toUpperCase().replaceAll("#", "");
  //   if (hexColor.length == 6) {
  //     hexColor = "FF" + hexColor; // Adding FF for full opacity
  //   }
  //   return Color(int.parse(hexColor, radix: 16));
  // }
}
