// ignore_for_file: must_be_immutable, avoid_print, use_build_context_synchronously

import 'dart:async';
import 'dart:io';

import 'package:badges/badges.dart' as b;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_cart_express/e_commerce_app/e_widget/e_input_text_field.dart';
import 'package:my_cart_express/order_tracking_app/constant/app_endpoints.dart';
import 'package:my_cart_express/order_tracking_app/constant/default_images.dart';
import 'package:my_cart_express/order_tracking_app/constant/storage_key.dart';
import 'package:my_cart_express/order_tracking_app/screens/overdue_screen/overdue_screen.dart';
import 'package:my_cart_express/order_tracking_app/screens/home_screen/home_screen.dart';
import 'package:my_cart_express/order_tracking_app/screens/more_screen/more_screen.dart';
import 'package:my_cart_express/order_tracking_app/screens/more_screen/available_packages.dart';
import 'package:my_cart_express/order_tracking_app/screens/scanner_screen/scanner_screen.dart';
import 'package:my_cart_express/order_tracking_app/screens/shipping_screen/shipping_screen.dart';
import 'package:my_cart_express/order_tracking_app/theme/colors.dart';
import 'package:my_cart_express/order_tracking_app/theme/text_style.dart';
import 'package:my_cart_express/order_tracking_app/utils/global_singleton.dart';
import 'package:my_cart_express/order_tracking_app/utils/network_dio.dart';
import 'package:my_cart_express/order_tracking_app/widget/show_feedback_popup.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../e_commerce_app/e_constant/e_sizedbox.dart';
import '../../../e_commerce_app/e_widget/e_validator.dart';

RxInt packageCounts = 0.obs;
RxInt availablePackageCounts = 0.obs;
RxInt overduePackageCounts = 0.obs;

class MainHomeScreen extends StatefulWidget {
  MainHomeScreen({
    super.key,
    required this.selectedIndex,
    this.id,
    this.staffFirstname,
    this.staffImage,
  });

  final String? id;
  final String? staffFirstname;
  final String? staffImage;

  RxInt selectedIndex;

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  late Timer _timer;
  GetStorage box = GetStorage();
  TextEditingController trnController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final GlobalKey<FormState> dialogformKey = GlobalKey<FormState>();
  TextEditingController type = TextEditingController();
  TextEditingController declared = TextEditingController();
  RxInt categorySelectIndex = 0.obs;
  RxString catId = ''.obs;
  RxInt selectedPickuoBranchIndex = 0.obs;
  Rx<File>? selectedFile;

  RxString fileName = ''.obs;
  RxList categoriesList = [].obs;

  List<Map<String, dynamic>> invoicePackageList = [];
  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 20), (Timer t) async {
      if (!isPopShown.value) {
        print('FEEDBACK SHOW FROM TIMER');
        ShowFeedBackPopup feedBackPopup = ShowFeedBackPopup();
        await feedBackPopup.callApi(context: context);
      }
    });
    getCategoryData();
    if (box.read(StorageKey.isTrnEnter) != "1") {
      if (GlobalSingleton.userDetails['show_trn_popup'] == 1) {
        Future.delayed(Duration.zero, () {
          trnDialog(context);
        });
      }
    }

    if (GlobalSingleton.userDetails['show_restricted_items_popup '] != null &&
        GlobalSingleton.userDetails['show_restricted_items_popup '] == 1 &&
        GlobalSingleton.userDetails["is_restricted_items_accepted"] != 1) {
      Future.delayed(Duration.zero, () {
        restrictedDialod(context);
      });
    }
  }

  getCategoryData() async {
    Map<String, dynamic>? categoriesListResponse =
        await NetworkDio.getDioHttpMethod(
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.shippingCategories,
      context: context,
    );
    if (categoriesListResponse != null) {
      categoriesList.value = categoriesListResponse['list'];
      Future.delayed(Duration.zero, () async {
        await getNotUploadedInvoices(context, true);
      });
    }
  }

  void showADialog() {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          actions: [
            TextButton(
              onPressed: () {
                isPopShown.value = false;
                Navigator.pop(ctx);
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        // InkWell(
        //   onTap: () {
        //     getNotUploadedInvoices(context);
        //   },
        //   child: Container(
        //     height: 100,
        //     width: 100,
        //     color: Colors.red,
        //   ),
        // ),
        HomeScreen(
          id: widget.id,
          staffFirstname: widget.staffFirstname,
          staffImage: widget.staffImage,
        ),
        const ScannerScreen(),
        const ShippingScreen(
          isFromeHome: false,
        ),
        const AvailablePackagesScreen(fromHome: true),
        const OverdueScreen(),
        const MoreScreen(),
      ][widget.selectedIndex.value],
      bottomNavigationBar: Obx(
        () => Container(
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
                    setState(() {
                      widget.selectedIndex.value = 0;
                    });
                  },
                  child: Image.asset(
                    homeIcon,
                    color: widget.selectedIndex.value == 0 ? null : Colors.grey,
                    height: 24,
                    width: 24,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.selectedIndex.value = 1;
                    });
                  },
                  child: Image.asset(
                    scannerIcon,
                    color: widget.selectedIndex.value == 1 ? null : Colors.grey,
                    height: 24,
                    width: 24,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.selectedIndex.value = 2;
                    });
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
                          widget.selectedIndex.value == 2 ? null : Colors.grey,
                      height: 24,
                      width: 24,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.selectedIndex.value = 3;
                    });
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
                          widget.selectedIndex.value == 3 ? null : Colors.grey,
                      height: 24,
                      width: 24,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.selectedIndex.value = 4;
                    });
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
                          widget.selectedIndex.value == 4 ? null : Colors.grey,
                      height: 24,
                      width: 24,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.selectedIndex.value = 5;
                    });
                  },
                  child: Icon(
                    Icons.more_horiz_rounded,
                    color:
                        widget.selectedIndex.value == 5 ? primary : Colors.grey,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void trnDialog(
    BuildContext context,
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: StatefulBuilder(builder: (ctx, set) {
          return Dialog(
            insetPadding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  height15,
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15.0,
                    ),
                    child: Text(
                      'TRN',
                      style: mediumText18,
                    ),
                  ),
                  const Divider(),
                  height10,
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      GlobalSingleton.userDetails['trn_popup_message']
                          .toString(),
                      style: regularText14,
                    ),
                  ),
                  height10,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 280,
                          height: 90,
                          child: TextFormFieldWidget(
                            maxLines: 1,
                            controller: trnController,
                            hintText: "Enter TRN",
                            contentPadding: const EdgeInsets.all(10),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "";
                              } else if (value.length < 9) {
                                return "Enter Valid TRN";
                              } else {
                                return null;
                              }
                            },
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(9),
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            saveTrn(ctx);
                          }
                        },
                        child: const Text(
                          'Done',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  void uploadInvoiceDialog(
    BuildContext context,
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: StatefulBuilder(builder: (ctx, set) {
          return Dialog(
            insetPadding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                height15,
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Invoice Upload',
                        style: mediumText18,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Skip',
                          style: mediumText18.copyWith(color: primary),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                Expanded(
                  child: ListView.separated(
                    itemCount: invoicePackageList.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        height10,
                    shrinkWrap: true,
                    // physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 4,
                      ),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 2),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: greyColor,
                          ),
                          borderRadius: BorderRadius.circular(12)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                invoicePackageList[index]['vendor_name'] == ""
                                    ? const SizedBox()
                                    : Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              invoicePackageList[index]
                                                  ['vendor_name'],
                                              style: boldText14.copyWith(
                                                color: blackColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                if (invoicePackageList[index]['vendor_name'] !=
                                    "")
                                  height5,
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        invoicePackageList[index]
                                            ['shipping_mcecode'],
                                        style: lightText13.copyWith(
                                          color: blackColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                // height5,
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        invoicePackageList[index]['tracking'],
                                        overflow: TextOverflow.ellipsis,
                                        style: lightText13.copyWith(
                                            // color: Colors.grey,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        invoicePackageList[index]
                                            ['insert_timestamp'],
                                        overflow: TextOverflow.ellipsis,
                                        style: lightText13.copyWith(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: orangeColor,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              ),
                            ),
                            onPressed: () {
                              showModalBottomSheet(
                                  context: context,
                                  isDismissible: true,
                                  isScrollControlled: true,
                                  builder: (BuildContext ctx) {
                                    return Padding(
                                      padding: MediaQuery.of(ctx).viewInsets,
                                      child: Container(
                                        padding: const EdgeInsets.all(15),
                                        decoration: const BoxDecoration(
                                          color: offWhite,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20),
                                          ),
                                        ),
                                        child: uploadFileBodyView(
                                            invoicePackageList[index]
                                                ['package_id'],
                                            context),
                                      ),
                                    );
                                  }).then((value) async {
                                await getNotUploadedInvoices(context, false);

                                set(() {});
                                setState(() {});
                              });
                              // uploadInvoice(
                              //     invoicePackageList[index]['package_id'],
                              //     context);
                            },
                            child: const Row(
                              children: [
                                Text(
                                  'Upload invoice',
                                  style: TextStyle(
                                      letterSpacing: 0.5, fontSize: 12),
                                ),
                                // width5,
                                // Image.asset(
                                //   addIcon,
                                //   color: whiteColor,
                                //   height: 14,
                                //   width: 14,
                                // ),
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
          );
        }),
      ),
    );
  }

  Future<void> saveTrn(BuildContext context) async {
    final data = dio.FormData.fromMap({
      'trn_number': trnController.text,
    });
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
        url: ApiEndPoints.apiEndPoint + ApiEndPoints.trnNumberSave,
        data: data,
        context: context);

    if (response != null && response['status'] == 200) {
      box.write(StorageKey.isTrnEnter, "1");
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } else {
      NetworkDio.showError(
        title: 'Error',
        errorMessage: response!['message'],
      );
    }
  }

  Future<void> getNotUploadedInvoices(
      BuildContext context, bool isShowDialog) async {
    Map<String, dynamic>? response = await NetworkDio.getDioHttpMethod(
        url: ApiEndPoints.apiEndPoint + ApiEndPoints.getUploadInvoices,
        context: context);
    if (response != null && response['status'] == 200) {
      Map<String, dynamic>? getinvoiceStatus = response['data'];
      invoicePackageList = getinvoiceStatus!.values
          .map((e) => e as Map<String, dynamic>)
          .toList();
      if (isShowDialog == true) {
        uploadInvoiceDialog(context);
      }
    } else {
      NetworkDio.showError(
        title: 'Error',
        errorMessage: response!['message'],
      );
    }
    setState(() {});
  }

  Future<void> customerAcceptenceApi(BuildContext context) async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
        url: ApiEndPoints.apiEndPoint + ApiEndPoints.customerAcceptence,
        data: {},
        context: context);

    if (response != null && response['status'] == 200) {
      Navigator.pop(context);
    } else {
      NetworkDio.showError(
        title: 'Error',
        errorMessage: response!['message'],
      );
    }
  }

  void restrictedDialod(
    BuildContext context,
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: StatefulBuilder(builder: (ctx, set) {
          return Dialog(
            insetPadding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    height15,
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Restricted/Prohibited Items',
                            style: mediumText16,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Skip',
                              style: mediumText18.copyWith(color: primary),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    height10,
                    html(GlobalSingleton
                        .userDetails['restricted_items_popup_message']
                        .toString()),
                    height10,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            customerAcceptenceApi(context);
                          },
                          child: Text(
                            GlobalSingleton.userDetails[
                                'restricted_items_accept_button_text'],
                          ),
                        ),
                      ],
                    ),
                    height10,
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget html(String data) {
    return Html(
      data: data,
      onAnchorTap: (url, attributes, element) {
        if (url != null) {
          launchUrl(Uri.parse(url));
        }
      },
      onLinkTap: (url, attributes, element) {
        if (url != null) {
          launchUrl(Uri.parse(url));
        }
      },
    );
  }

  void uploadInvoice(String packageId, context) async {}

  Widget uploadFileBodyView(String packageId, BuildContext context) {
    return Form(
      key: dialogformKey,
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
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
              ],
              textInputAction: TextInputAction.done,
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
                showBottomSheet(
                  context,
                  1,
                );
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
                            selectFileType(
                              context,
                            );
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
                if (dialogformKey.currentState!.validate()) {
                  if (selectedFile != null) {
                    await showConformatonDialog(packageId, context);
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

  Future<void> pickFile(String path, String name) async {
    selectedFile = File(path).obs; //File(result.files.first.path!).obs;
    fileName.value = name; //result.files.first.name;
  }

  Future<void> submitOnTap(String? packageId, BuildContext context) async {
    final data = dio.FormData.fromMap({
      'files': await dio.MultipartFile.fromFile(
        selectedFile!.value.path,
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
          title: 'Success', sucessMessage: response['message']);
      Get.back();
    }
  }

  showConformatonDialog(
    String packageId,
    BuildContext ctx,
  ) {
    showDialog(
      context: ctx,
      builder: (BuildContext ctttx) {
        return AlertDialog(
          title: const Text(
            "All Invoice Values must be in US Dollars",
            style: TextStyle(color: error, fontWeight: FontWeight.bold),
          ),
          content: Text(
              "Your invoice value for this package is ${declared.text} US dollars?"),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: primary,
              ),
              child: const Text(
                "No",
                style: TextStyle(color: whiteColor),
              ),
              onPressed: () {
                Navigator.pop(ctttx);
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: primary,
              ),
              child: const Text(
                "Yes",
                style: TextStyle(color: whiteColor),
              ),
              onPressed: () async {
                Navigator.pop(ctttx);
                await submitOnTap(packageId, ctx);
              },
            ),
          ],
        );
      },
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
                    XFile? result = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    if (result != null) {
                      await pickFile(result.path, result.name);
                    }
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
                    if (result != null) {
                      await pickFile(
                          result.files.first.path!, result.files.first.name);
                    }
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

  void showBottomSheet(
    BuildContext context,
    int index,
  ) {
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
                    categorySelectIndex.value = i;
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
                    type.text =
                        categoriesList[categorySelectIndex.value]['cat_name'];
                    catId.value =
                        categoriesList[categorySelectIndex.value]['id'];
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
