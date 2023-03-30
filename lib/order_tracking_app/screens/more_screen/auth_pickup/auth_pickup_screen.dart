import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:my_cart_express/order_tracking_app/theme/colors.dart';
import 'package:my_cart_express/order_tracking_app/theme/text_style.dart';
import 'package:my_cart_express/order_tracking_app/constant/sizedbox.dart';
import 'package:my_cart_express/order_tracking_app/utils/network_dio.dart';
import 'package:my_cart_express/order_tracking_app/widget/app_bar_widget.dart';
import 'package:my_cart_express/order_tracking_app/constant/app_endpoints.dart';
import 'package:my_cart_express/order_tracking_app/constant/default_images.dart';
import 'package:my_cart_express/order_tracking_app/screens/more_screen/auth_pickup/auth_pickup_details_screen.dart';

class AuthPickUpScreen extends StatefulWidget {
  const AuthPickUpScreen({super.key});

  @override
  State<AuthPickUpScreen> createState() => _AuthPickUpScreenState();
}

class _AuthPickUpScreenState extends State<AuthPickUpScreen> {
  RxList authPickupList = [].obs;
  RxBool isLoading = true.obs;
  @override
  void initState() {
    super.initState();
    getAuthorizePickupList();
  }

  Future<void> getAuthorizePickupList() async {
    Map<String, dynamic>? response = await NetworkDio.getDioHttpMethod(
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.authorizePickup,
      context: context,
    );
    if (response != null) {
      authPickupList.value = response['data'];
      isLoading.value = false;
    }
  }

  Future<void> deletePickup(ctx, String id) async {
    final data = dio.FormData.fromMap({
      'id': id,
    });
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.authorizePickupDelete,
      context: ctx,
      data: data,
    );
    if (response != null) {
      Navigator.of(ctx).pop();
      NetworkDio.showSuccess(
          title: 'Success',
          sucessMessage:
              'You have successfully deleted one item from authorize pickup');
      await getAuthorizePickupList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.height,
        color: primary,
        child: Column(
          children: [
            appBarWithAction(),
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
    );
  }

  Widget bodyView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Authorize Pickup',
              style: regularText18,
            ),
            InkWell(
              onTap: () {
                Get.to(() => AuthPickupDetailsScreen(
                      editedData: null,
                    ))?.then((value) {
                  if (value == true) {
                    getAuthorizePickupList();
                  }
                });
              },
              child: const Icon(
                Icons.add,
              ),
            ),
          ],
        ),
        height15,
        Expanded(
          child: feedbackList(),
        ),
      ],
    );
  }

  Widget feedbackList() {
    return Obx(
      () => isLoading.value
          ? const SizedBox()
          : authPickupList.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(noAuthorizePickup),
                    Text(
                      'Add Authorize Pickup First',
                      style: regularText20,
                    ),
                  ],
                )
              : ListView.separated(
                  itemCount: authPickupList.length,
                  padding: EdgeInsets.zero,
                  separatorBuilder: (BuildContext context, int index) =>
                      height10,
                  itemBuilder: (BuildContext context, int index) => Container(
                    padding: const EdgeInsets.only(
                      top: 15,
                    ),
                    decoration: BoxDecoration(
                      color: greyColor.withOpacity(.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text(
                                  'Name :',
                                  style: regularText14,
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Text(
                                  authPickupList[index]['name'],
                                  style: regularText14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        height5,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text(
                                  'ID Number :',
                                  style: regularText14,
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Text(
                                  authPickupList[index]['id_number'],
                                  style: regularText14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        height5,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text(
                                  'Phone Number :',
                                  style: regularText14,
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Text(
                                  authPickupList[index]['phone_number'],
                                  style: regularText14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        height5,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text(
                                  'Date :',
                                  style: regularText14,
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Text(
                                  DateFormat('dd MMM yyyy HH:mm a').format(
                                      DateTime.parse(authPickupList[index]
                                          ['insert_timestamp'])),
                                  style: regularText14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        height10,
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  deleteIcon(authPickupList[index]['id']);
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(
                                    color: Colors.redAccent,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                    ),
                                  ),
                                  child: const Text(
                                    'Delete',
                                    style: TextStyle(
                                      letterSpacing: 0.5,
                                      color: whiteColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Get.to(() => AuthPickupDetailsScreen(
                                        editedData: authPickupList[index],
                                      ))?.then((value) {
                                    if (value == true) {
                                      getAuthorizePickupList();
                                    }
                                  });
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(
                                    color: primary,
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(10),
                                    ),
                                  ),
                                  child: const Text(
                                    'Edit',
                                    style: TextStyle(
                                      letterSpacing: 0.5,
                                      color: whiteColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }

  void deleteIcon(String id) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Image.asset(
          trashIcon,
          height: 60,
          width: 60,
          color: Colors.redAccent,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Are you sure?",
              style: regularText20,
            ),
            height15,
            Text(
              "Do you really want to delete these pickup details?",
              style: regularText14,
              textAlign: TextAlign.center,
            ),
            height15,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: greyColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Text(
                      "Cancel",
                      style: regularText14,
                    ),
                  ),
                ),
                width10,
                TextButton(
                  onPressed: () async {
                    await deletePickup(ctx, id);
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.redAccent.shade200,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Text(
                      "Delete",
                      style: regularText14.copyWith(
                        color: whiteColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
