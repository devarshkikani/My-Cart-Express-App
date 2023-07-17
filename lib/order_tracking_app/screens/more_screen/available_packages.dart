// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:badges/badges.dart' as b;

import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:file_picker/file_picker.dart';
import 'package:my_cart_express/order_tracking_app/screens/home/main_home_screen.dart';
import 'package:my_cart_express/order_tracking_app/screens/home_screen/home_screen_controller.dart';
import 'package:my_cart_express/order_tracking_app/screens/scanner_screen/scanner_screen.dart';
import 'package:my_cart_express/order_tracking_app/theme/colors.dart';
import 'package:my_cart_express/order_tracking_app/theme/text_style.dart';
import 'package:my_cart_express/order_tracking_app/widget/validator.dart';
import 'package:my_cart_express/order_tracking_app/constant/sizedbox.dart';
import 'package:my_cart_express/order_tracking_app/utils/network_dio.dart';
import 'package:my_cart_express/order_tracking_app/constant/app_endpoints.dart';
import 'package:my_cart_express/order_tracking_app/widget/input_text_field.dart';
import 'package:my_cart_express/order_tracking_app/constant/default_images.dart';
import 'package:my_cart_express/order_tracking_app/screens/shipping_screen/packages_details_screen.dart';

class AvailablePackagesScreen extends StatefulWidget {
  final RxList? availablePackages;
  final RxMap? availablePackagesData;
  final bool fromHome;
  final String? title;
  final String? barcode;
  const AvailablePackagesScreen({
    super.key,
    required this.fromHome,
    this.title,
    this.barcode,
    this.availablePackages,
    this.availablePackagesData,
  });

  @override
  State<AvailablePackagesScreen> createState() =>
      _AvailablePackagesScreenState();
}

class _AvailablePackagesScreenState extends State<AvailablePackagesScreen> {
  RxBool isLoading = true.obs;
  RxInt selectedIndex = 1.obs;
  RxList availablePackages = [].obs;
  RxMap availablePackagesData = {}.obs;
  TextEditingController type = TextEditingController();
  TextEditingController declared = TextEditingController();
  File? selectedFile;
  RxString catId = ''.obs;
  RxString fileName = ''.obs;
  RxList categoriesList = [].obs;
  CarouselController carouselController = CarouselController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    if (!widget.fromHome) {
      availablePackages.value = widget.availablePackages!;
      availablePackagesData.value = widget.availablePackagesData!;
    }
    getCategoriesList();
    super.initState();
  }

  Future<void> getAvailablePackages({bool? show}) async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.availableShipping,
      context: show == true ? null : context,
      data: null,
    );
    if (response != null) {
      isLoading.value = false;
      availablePackages.value = response['list'];
      availablePackagesData.value = {
        "counts": response['counts'],
        "due": response['due'],
      };
    }
  }

  Future<void> getScanPackages(String barcode, {bool? show}) async {
    isLoading.value = true;
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.availableShipping,
      context: context,
      data: dio.FormData.fromMap({
        "offset": 0,
        "limit": 10,
        "branch_qr_code": barcode,
        "latitude": currentPosition?.latitude,
        "longitude": currentPosition?.longitude,
      }),
    );
    isLoading.value = false;
    if (response != null) {
      availablePackages.value = response['list'];
      availablePackagesData.value = {
        "counts": response['counts'],
        "due": response['due'],
      };
      setState(() {});
    }
  }

  Future<void> getCategoriesList() async {
    Map<String, dynamic>? categoriesListResponse =
        await NetworkDio.getDioHttpMethod(
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.shippingCategories,
      context: context,
    );
    if (categoriesListResponse != null) {
      categoriesList.value = categoriesListResponse['list'];
    }
    if (widget.fromHome) {
      isLoading.value = true;
      availablePackages.value = [];
      availablePackagesData.value = {};
      await getAvailablePackages();
    }
    isLoading.value = false;
  }

  Future<void> pickFile(FilePickerResult? result) async {
    if (result != null) {
      selectedFile = File(result.files.first.path!);
      fileName.value = result.files.first.name;
      setState(() {});
    }
  }

  Future<void> submitOnTap(String? packageId) async {
    final data = dio.FormData.fromMap({
      'files': await dio.MultipartFile.fromFile(
        selectedFile!.path,
        filename: fileName.value,
      ),
      'attachment_package_id': packageId,
      'attach_for': 'invoice',
      'customer_input_value': declared.text,
      'category_id': catId.value,
    });
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.uploadAttachments,
      data: data,
      context: context,
    );
    if (response != null) {
      Get.back();
      NetworkDio.showSuccess(
        title: 'Success',
        sucessMessage: response['message'],
      );
      isLoading.value = true;
      availablePackages.value = [];
      availablePackagesData.value = {};
      getAvailablePackages();
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
              AppBar(
                backgroundColor: Colors.transparent,
                leading: const SizedBox(),
                centerTitle: true,
                elevation: 0.0,
                title: Text(
                  widget.title ?? 'Available Packages',
                  style: regularText20.copyWith(
                    color: whiteColor,
                  ),
                ),
              ),
              Expanded(
                child: Container(
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
        bottomNavigationBar: widget.title == 'Packages for pickup'
            ? Container(
                height: 80,
                padding: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  color: greyColor.withOpacity(0.2),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: SafeArea(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.offAll(
                            () => MainHomeScreen(selectedIndex: 0.obs),
                          );
                        },
                        child: Image.asset(
                          homeIcon,
                          color: selectedIndex.value == 0 ? null : Colors.grey,
                          height: 24,
                          width: 24,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.offAll(
                            () => MainHomeScreen(selectedIndex: 1.obs),
                          );
                        },
                        child: Image.asset(
                          scannerIcon,
                          color: selectedIndex.value == 1 ? null : Colors.grey,
                          height: 24,
                          width: 24,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.offAll(
                            () => MainHomeScreen(selectedIndex: 2.obs),
                          );
                        },
                        child: b.Badge(
                          showBadge: packageCounts.value > 0,
                          badgeStyle: const b.BadgeStyle(
                            shape: b.BadgeShape.instagram,
                          ),
                          badgeContent: Text(
                            '${packageCounts.value}',
                            style: lightText12.copyWith(
                              color: whiteColor,
                            ),
                          ),
                          child: Image.asset(
                            shippingIcon,
                            color:
                                selectedIndex.value == 2 ? null : Colors.grey,
                            height: 24,
                            width: 24,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.offAll(
                            () => MainHomeScreen(selectedIndex: 3.obs),
                          );
                        },
                        child: b.Badge(
                          showBadge: availablePackageCounts.value > 0,
                          badgeStyle: const b.BadgeStyle(
                            shape: b.BadgeShape.instagram,
                          ),
                          badgeContent: Text(
                            '${availablePackageCounts.value}',
                            style: lightText12.copyWith(
                              color: whiteColor,
                            ),
                          ),
                          child: Image.asset(
                            availablePackagesIcon,
                            color:
                                selectedIndex.value == 3 ? null : Colors.grey,
                            height: 24,
                            width: 24,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.offAll(
                            () => MainHomeScreen(selectedIndex: 4.obs),
                          );
                        },
                        child: b.Badge(
                          showBadge: overduePackageCounts.value > 0,
                          badgeStyle: const b.BadgeStyle(
                            shape: b.BadgeShape.instagram,
                          ),
                          badgeContent: Text(
                            '${overduePackageCounts.value}',
                            style: lightText12.copyWith(
                              color: whiteColor,
                            ),
                          ),
                          child: Image.asset(
                            deliveryIcon,
                            color:
                                selectedIndex.value == 4 ? null : Colors.grey,
                            height: 24,
                            width: 24,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.offAll(
                            () => MainHomeScreen(selectedIndex: 5.obs),
                          );
                        },
                        child: Icon(
                          Icons.more_horiz_rounded,
                          color:
                              selectedIndex.value == 5 ? primary : Colors.grey,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : null);
  }

  Widget bodyView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        height15,
        Obx(
          () => imageList.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CarouselSlider.builder(
                        itemCount: imageList.length,
                        carouselController: carouselController,
                        options: CarouselOptions(
                          enlargeCenterPage: true,
                          padEnds: true,
                          viewportFraction: 1.0,
                          height: 200,
                          autoPlay: imageList.length > 1,
                          scrollPhysics: imageList.length > 1
                              ? const AlwaysScrollableScrollPhysics()
                              : const NeverScrollableScrollPhysics(),
                          autoPlayInterval: const Duration(seconds: 6),
                        ),
                        itemBuilder: (context, i, id) {
                          return InkWell(
                            onTap: () {
                              redirectHome(i);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: Colors.white,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                  imageList[i]['image_url'],
                                  width: Get.width,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      if (imageList.length > 1)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 10),
                              height: 200,
                              width: 100,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15),
                                  topLeft: Radius.circular(15),
                                ),
                              ),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      carouselController.previousPage();
                                    },
                                    child: Image.asset(
                                      arrowLeft,
                                      height: 24,
                                      width: 24,
                                      color: whiteColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 200,
                              width: 100,
                              padding: const EdgeInsets.only(right: 10),
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      carouselController.nextPage();
                                    },
                                    child: Image.asset(
                                      arrowRight,
                                      height: 24,
                                      width: 24,
                                      color: whiteColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                )
              : const SizedBox(),
        ),
        Obx(() => imageList.isNotEmpty ? height10 : const SizedBox()),
        Obx(() => isLoading.value
            ? const SizedBox()
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  'TOTAL PACKAGES AVAILABLE : ${availablePackagesData['counts'] ?? 0}',
                  style: regularText12.copyWith(
                    color: Colors.grey,
                  ),
                ),
              )),
        height5,
        Obx(() => isLoading.value
            ? const SizedBox()
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  'TOTAL DUE : ${availablePackagesData['due'] ?? 0.00}',
                  style: regularText12.copyWith(
                    color: Colors.grey,
                  ),
                ),
              )),
        height10,
        Expanded(
          child: shippingList(),
        ),
      ],
    );
  }

  Widget shippingList() {
    return Obx(
      () => isLoading.value
          ? Row(
              children: const <Widget>[
                SizedBox(),
              ],
            )
          : availablePackages.isEmpty
              ? Center(
                  child: Text(
                    'No available packages found.',
                    style: lightText14.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                )
              : RefreshIndicator(
                  onRefresh: () async {
                    if (widget.title == 'Packages for pickup') {
                      await getScanPackages(widget.barcode!, show: true);
                    } else {
                      await getAvailablePackages(show: true);
                    }
                  },
                  child: Stack(
                    children: [
                      ListView(),
                      ListView.separated(
                        itemCount: availablePackages.length,
                        padding: EdgeInsets.zero,
                        separatorBuilder: (BuildContext context, int index) =>
                            height10,
                        itemBuilder: (BuildContext context, int index) =>
                            InkWell(
                          onTap: () {
                            Get.to(
                              () => MyPackagesDetailsScreen(
                                packagesDetails: availablePackages[index],
                                isFromAll: false,
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                            decoration: BoxDecoration(
                              color: availablePackages[index]['status'] ==
                                      'Available for Pickup'
                                  ? Colors.green.shade200
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(.10),
                                  offset: const Offset(0.0, 2.0),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: const BoxDecoration(
                                    color: greyColor,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                  ),
                                  child: IntrinsicHeight(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                Icons.check_circle,
                                                color: primary,
                                                size: 20,
                                              ),
                                              width5,
                                              Text(
                                                availablePackages[index]
                                                    ['status'],
                                                style: lightText12.copyWith(
                                                  color: primary,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const VerticalDivider(
                                          color: primary,
                                        ),
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'value : ',
                                                style: lightText12,
                                              ),
                                              Text(
                                                availablePackages[index]
                                                    ['value_cost'],
                                                style: regularText14,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  color: greyColor.withOpacity(0.2),
                                  padding: const EdgeInsets.all(8),
                                  child: Row(
                                    children: [
                                      width20,
                                      Center(
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: SizedBox(
                                            height: 60,
                                            width: 60,
                                            child: Image.network(
                                              availablePackages[index]
                                                  ['package_image'],
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      width20,
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              availablePackages[index]
                                                  ['pkg_shipging_code'],
                                              style: regularText12.copyWith(
                                                color: primary,
                                              ),
                                            ),
                                            height5,
                                            Column(
                                              children: [
                                                Text(
                                                  availablePackages[index]
                                                      ['tracking'],
                                                  // overflow: TextOverflow.ellipsis,
                                                  style: regularText12,
                                                ),
                                              ],
                                            ),
                                            height5,
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  availablePackages[index]
                                                      ['weight_label'],
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: regularText12,
                                                ),
                                                const Icon(
                                                  Icons
                                                      .arrow_forward_ios_rounded,
                                                  size: 12,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                IntrinsicHeight(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: const BoxDecoration(
                                            color: greyColor,
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(10),
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'TOTAL COST : ${availablePackages[index]['amount'] ?? 0.00}',
                                                style: lightText12.copyWith(
                                                  color: blackColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: availablePackages[index][
                                                      'upload_attachment_flag'] ==
                                                  1
                                              ? () {
                                                  uploadInvoice(
                                                      availablePackages[index]
                                                          ['package_id']);
                                                }
                                              : null,
                                          child: Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: availablePackages[index][
                                                          'upload_attachment_flag'] ==
                                                      1
                                                  ? orangeColor
                                                  : primary,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                bottomRight:
                                                    Radius.circular(10),
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  availablePackages[index]
                                                      ['invoice_btn_text'],
                                                  style: lightText12.copyWith(
                                                    color: whiteColor,
                                                  ),
                                                ),
                                                width10,
                                                availablePackages[index][
                                                            'upload_attachment_flag'] ==
                                                        1
                                                    ? Image.asset(
                                                        addIcon,
                                                        color: whiteColor,
                                                        height: 14,
                                                        width: 14,
                                                      )
                                                    : const SizedBox(),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }

  void uploadInvoice(String packageId) async {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext ctx) {
          return Container(
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
              color: offWhite,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: uploadFileBodyView(packageId),
          );
        }).then((value) {
      declared.text = '';
      type.text = '';
      fileName.value = '';
      catId.value = '';
      selectedFile = null;
    });
  }

  Widget uploadFileBodyView(String packageId) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Invoice',
                  style: regularText20,
                ),
              ],
            ),
            height20,
            Text(
              'Declared Value in USD',
              style: regularText14,
            ),
            height10,
            TextFormFieldWidget(
              hintText: 'Enter USD Value Here',
              controller: declared,
              validator: (value) =>
                  Validators.validateText(value, 'Declared Value in USD'),
            ),
            height20,
            Text(
              'Category',
              style: regularText14,
            ),
            height10,
            TextFormFieldWidget(
              hintText: 'Select category',
              controller: type,
              readOnly: true,
              onTap: () {
                showBottomSheet(context, 1);
              },
              suffixIcon: const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: primary,
              ),
              validator: (value) => Validators.validateText(value, 'File Type'),
            ),
            height15,
            Row(
              children: [
                Text(
                  'Attachment File',
                  style: lightText14,
                ),
              ],
            ),
            height15,
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 20,
              ),
              decoration: BoxDecoration(
                color: greyColor.withOpacity(.5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Invoice file',
                        ),
                        Obx(() => Text(
                              fileName.value != ''
                                  ? fileName.value
                                  : '(filename.txt)',
                              style: lightText14.copyWith(
                                color: primary,
                              ),
                            )),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: greyColor,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                            ),
                          ),
                          onPressed: () async {
                            selectFileType(context);
                          },
                          child: const Text(
                            'Click to select file...',
                            style: TextStyle(
                              letterSpacing: 0.5,
                              color: primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            height20,
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primary,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
              ),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  if (selectedFile != null) {
                    await submitOnTap(packageId);
                  } else {
                    NetworkDio.showError(
                      title: 'Warning',
                      errorMessage: 'Please select invoice first',
                    );
                  }
                }
              },
              child: const Text(
                'Upload Invoice',
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
  }

  void selectFileType(
    BuildContext context,
  ) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: offWhite,
      builder: (BuildContext context) {
        return SizedBox(
          height: 250,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                height20,
                ElevatedButton(
                  onPressed: () async {
                    Get.back();
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: ['jpg', 'png', 'jpeg'],
                    );
                    await pickFile(
                      result,
                    );
                  },
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
                  child: const Text(
                    "CHOOSE IMAGE FROM GALLERY",
                    style: TextStyle(
                      color: blackColor,
                    ),
                  ),
                ),
                height10,
                ElevatedButton(
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
                    await pickFile(
                      result,
                    );
                  },
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
                  child: const Text(
                    "CHOOSE DOCUMENT",
                    style: TextStyle(
                      color: blackColor,
                    ),
                  ),
                ),
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

  void showBottomSheet(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (BuildContext ctx) {
        return SizedBox(
          height: 250,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: CupertinoPicker(
                  itemExtent: 40,
                  magnification: 1.33,
                  squeeze: 1.2,
                  useMagnifier: true,
                  looping: true,
                  onSelectedItemChanged: (int i) {
                    type.text = categoriesList[i]['cat_name'];
                    catId.value = categoriesList[i]['id'];
                  },
                  children: List.generate(
                    categoriesList.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        categoriesList[index]['cat_name'],
                        style: mediumText18.copyWith(
                          color: primary,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    maximumSize: Size(Get.width, 50),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: const Text(
                    'SELECT',
                    style: TextStyle(
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
              height10,
            ],
          ),
        );
      },
    );
  }
}
