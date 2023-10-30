import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_cart_express/e_commerce_app/e_widget/e_input_text_field.dart';
import 'package:my_cart_express/order_tracking_app/constant/app_endpoints.dart';
import 'package:my_cart_express/order_tracking_app/constant/sizedbox.dart';
import 'package:my_cart_express/order_tracking_app/screens/messages_screen/messages_screen.dart';
import 'package:my_cart_express/order_tracking_app/screens/notification_screen/notifications_screen.dart';
import 'package:my_cart_express/order_tracking_app/theme/colors.dart';
import 'package:my_cart_express/order_tracking_app/theme/text_style.dart';
import 'package:my_cart_express/order_tracking_app/utils/network_dio.dart';

class MissingPackagesScreen extends StatefulWidget {
  const MissingPackagesScreen({super.key});

  @override
  State<MissingPackagesScreen> createState() => _MissingPackagesScreenState();
}

class _MissingPackagesScreenState extends State<MissingPackagesScreen> {
  String? deliveryDateString;
  String? deliveryAddressFile;
  String? deliveryAddress;
  String? sucessfulDeliveryFile;
  String? sucessfulDelivery;
  String? trackingFile;
  String? tracking;
  String? orderDetailsFile;
  String? orderDetails;
  TextEditingController additionalInfo = TextEditingController();

  void selectFileType(BuildContext context, String forWhich) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: offWhite,
      builder: (BuildContext context) {
        return SizedBox(
          height: 280,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                height20,
                buttonStyle(
                    title: 'CHOOSE DOCUMENT',
                    onPressed: () async {
                      Get.back();
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles(
                        type: FileType.custom,
                        allowedExtensions: [
                          'pdf',
                          'doc',
                        ],
                      );
                      if (result != null) {
                        XFile file = XFile(
                          result.files.first.path!,
                          name: result.files.first.name,
                        );
                        storeFileAndName(forWhich, file);
                      }
                    }),
                height10,
                buttonStyle(
                    title: 'CHOOSE IMAGE FROM GALLERY',
                    onPressed: () async {
                      Get.back();
                      XFile? result = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      if (result != null) {
                        storeFileAndName(forWhich, result);
                      }
                    }),
                height10,
                buttonStyle(
                    title: 'TAKE A PHOTO',
                    onPressed: () async {
                      Get.back();
                      XFile? result = await ImagePicker()
                          .pickImage(source: ImageSource.camera);
                      if (result != null) {
                        storeFileAndName(forWhich, result);
                        setState(() {});
                      }
                    }),
                height10,
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: blackColor,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text(
                    'CANCEL',
                    style: TextStyle(
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                height20,
              ],
            ),
          ),
        );
      },
    );
  }

  void storeFileAndName(value, XFile xFile) {
    if (value == 'Delivery Address') {
      deliveryAddress = xFile.name;
      deliveryAddressFile = xFile.path;
    } else if (value == 'Sucessful Delivery') {
      sucessfulDelivery = xFile.name;
      sucessfulDeliveryFile = xFile.path;
    } else if (value == 'Tracking') {
      tracking = xFile.name;
      trackingFile = xFile.path;
    } else if (value == 'Order Details') {
      orderDetails = xFile.name;
      orderDetailsFile = xFile.path;
    }
    setState(() {});
  }

  Future<void> uploadMissingPackage() async {
    Map<String, dynamic>? uploadMissingPackage =
        await NetworkDio.postDioHttpMethod(
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.uploadMissingPackage,
      context: context,
      data: dio.FormData.fromMap({
        'delivery_date': deliveryDateString,
        'proof_delivery_address_used': await dio.MultipartFile.fromFile(
          deliveryAddressFile.toString(),
          filename: deliveryAddress,
        ),
        'proof_of_successful_delivery': await dio.MultipartFile.fromFile(
          sucessfulDeliveryFile.toString(),
          filename: sucessfulDelivery,
        ),
        'tracking': await dio.MultipartFile.fromFile(
          trackingFile.toString(),
          filename: tracking,
        ),
        'package_invoice_order_details': await dio.MultipartFile.fromFile(
          orderDetailsFile.toString(),
          filename: orderDetails,
        ),
        'additional_info': additionalInfo.text.trim(),
      }),
    );
    if (uploadMissingPackage != null) {
      if (uploadMissingPackage['status'] == 200) {
        Get.back();
        Get.back();
        NetworkDio.showSuccess(
          title: 'Success',
          sucessMessage: uploadMissingPackage['message'],
        );
      }
    }
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
                backgroundColor: Colors.transparent,
                centerTitle: true,
                elevation: 0.0,
                leading: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Platform.isAndroid
                        ? Icons.arrow_back_rounded
                        : Icons.arrow_back_ios_rounded,
                  ),
                ),
                title: Text(
                  'MyCartExpress',
                  style: regularText20.copyWith(
                    color: whiteColor,
                  ),
                ),
                actions: [
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const MessagesScreen());
                    },
                    child: const Icon(
                      Icons.mail_outline_rounded,
                      color: whiteColor,
                    ),
                  ),
                  width15,
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const NotificationScreen());
                    },
                    child: const Icon(
                      Icons.notifications_active_outlined,
                      color: whiteColor,
                    ),
                  ),
                  width15,
                ],
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(
                    left: 15,
                    top: 15,
                    right: 15,
                  ),
                  width: Get.width,
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

  Widget bodyView(context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Missing a Package?',
              style: mediumText18.copyWith(),
            ),
          ),
          height20,
          deliveryDate(),
          height20,
          proofDeliveryAddressUsedWidget(),
          height20,
          proofofSucessfulDeliveryWidget(),
          height20,
          trackingWidget(),
          height20,
          packageInvoiceWidget(),
          height20,
          Text(
            'Additional info :',
            style: mediumText18.copyWith(),
          ),
          height10,
          textFormField(
            maxLines: 3,
            controller: additionalInfo,
          ),
          height20,
          Center(
            child: ElevatedButton(
              onPressed: () {
                deliveryDateString ??= '';
                deliveryAddress ??= '';
                sucessfulDelivery ??= '';
                tracking ??= '';
                orderDetails ??= '';
                if (deliveryDateString == '' ||
                    deliveryAddress == '' ||
                    sucessfulDelivery == '' ||
                    tracking == '' ||
                    orderDetails == '') {
                  setState(() {});
                  return;
                }
                uploadMissingPackage();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primary,
                padding: const EdgeInsets.symmetric(horizontal: 40),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
              ),
              child: const Text(
                'Submit',
              ),
            ),
          ),
          height20,
        ],
      ),
    );
  }

  Widget deliveryDate() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Delivery Date',
          style: mediumText18.copyWith(),
        ),
        height10,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                _selectDate(context);
              },
              child: Container(
                width: Get.width,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                decoration: BoxDecoration(
                  color: surface.withOpacity(.15),
                ),
                child: Row(
                  children: [
                    Text(
                      deliveryDateString == null || deliveryDateString == ''
                          ? 'Select Date'
                          : deliveryDateString.toString(),
                      style: regularText14,
                    ),
                    const Spacer(),
                    Icon(
                      deliveryDateString == null || deliveryDateString == ''
                          ? Icons.check_box_outline_blank_rounded
                          : Icons.check_box_rounded,
                      color:
                          deliveryDateString == null || deliveryDateString == ''
                              ? const Color(0xff808080)
                              : surface,
                    ),
                  ],
                ),
              ),
            ),
            height5,
            if (deliveryDateString == '')
              Text(
                'Delivery Date is required',
                style: lightText12.copyWith(color: error),
              ),
          ],
        ),
      ],
    );
  }

  Widget proofDeliveryAddressUsedWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Proof Delivery Address Used',
          style: mediumText18.copyWith(),
        ),
        height10,
        commonDecoration(
          errorMessage: 'Proof Delivery Address  is required',
          forWich: 'Delivery Address',
          title: deliveryAddress == null || deliveryAddress == ''
              ? 'Upload file'
              : deliveryAddress.toString(),
          variable: deliveryAddress,
        ),
      ],
    );
  }

  Widget proofofSucessfulDeliveryWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Proof of Sucessful Delivery',
          style: mediumText18.copyWith(),
        ),
        height10,
        commonDecoration(
          errorMessage: 'Proof of Sucessful Delivery is required',
          forWich: 'Sucessful Delivery',
          variable: sucessfulDelivery,
          title: sucessfulDelivery == null || sucessfulDelivery == ''
              ? 'Upload file'
              : sucessfulDelivery.toString(),
        ),
      ],
    );
  }

  Widget trackingWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tracking #',
          style: mediumText18.copyWith(),
        ),
        height10,
        commonDecoration(
          errorMessage: 'Tracking is required',
          forWich: 'Tracking',
          variable: tracking,
          title: tracking == null || tracking == ''
              ? 'Upload file'
              : tracking.toString(),
        ),
      ],
    );
  }

  Widget packageInvoiceWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Package Invoice/Order Details',
          style: mediumText18.copyWith(),
        ),
        height10,
        commonDecoration(
          errorMessage: 'Package Invoice/Order Details are required',
          forWich: 'Order Details',
          variable: orderDetails,
          title: orderDetails == null || orderDetails == ''
              ? 'Upload file'
              : orderDetails.toString(),
        ),
      ],
    );
  }

  Widget commonDecoration({
    required String errorMessage,
    required String forWich,
    required String? variable,
    required String title,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            selectFileType(context, forWich);
          },
          child: Container(
            width: Get.width,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: surface.withOpacity(.15),
            ),
            child: Text(
              title,
              style: regularText14,
            ),
          ),
        ),
        height5,
        if (variable == '')
          Text(
            errorMessage,
            style: lightText12.copyWith(color: error),
          ),
      ],
    );
  }

  Widget buttonStyle({required String title, required Function() onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: whiteColor,
        textStyle: const TextStyle(color: blackColor),
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: blackColor,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: blackColor,
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      // date.text = picked.day.toString().padLeft(2, '0');
      // month.text = picked.month.toString().padLeft(2, '0');
      // year.text = picked.year.toString();
      deliveryDateString = '${picked.year}-${picked.month}-${picked.day}';
      setState(() {});
    }
  }
}
