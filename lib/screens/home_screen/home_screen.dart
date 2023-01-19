import 'dart:io';

import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:file_picker/file_picker.dart';
import 'package:my_cart_express/theme/colors.dart';
import 'package:my_cart_express/theme/text_style.dart';
import 'package:my_cart_express/widget/validator.dart';
import 'package:my_cart_express/utils/network_dio.dart';
import 'package:my_cart_express/constant/sizedbox.dart';
import 'package:my_cart_express/constant/app_endpoints.dart';
import 'package:my_cart_express/constant/default_images.dart';
import 'package:my_cart_express/widget/input_text_field.dart';
import 'package:my_cart_express/screens/messages_screen/messages_screen.dart';
import 'package:my_cart_express/screens/shipping_screen/shipping_screen.dart';
import 'package:my_cart_express/screens/notification_screen/notifications_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  RxInt balance = 0.obs;
  RxString howItWorks = ''.obs;
  RxString fullName = ''.obs;
  RxMap pickuoBranchData = {}.obs;
  RxMap usaShippingData = {}.obs;
  RxList packagesList = [].obs;
  TextEditingController type = TextEditingController();
  TextEditingController declared = TextEditingController();
  File? selectedFile;
  RxString catId = ''.obs;
  RxString fileName = ''.obs;
  RxList categoriesList = [].obs;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    getBalance();
  }

  void getBalance() async {
    Map<String, dynamic>? response = await NetworkDio.getDioHttpMethod(
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.balance,
      context: context,
    );
    if (response != null) {
      balance.value = response['data'];
    }

    Map<String, dynamic>? packagesResponse = await NetworkDio.getDioHttpMethod(
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.dashboardPackageList,
      context: context,
    );
    if (packagesResponse != null) {
      packagesList.value = packagesResponse['list'] ?? [];
    }

    Map<String, dynamic>? howItWorksResponse =
        await NetworkDio.getDioHttpMethod(
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.howItWorks,
      context: context,
    );
    if (howItWorksResponse != null) {
      howItWorks.value = howItWorksResponse['img_url'];
    }

    Map<String, dynamic>? shippingPickupAddress =
        await NetworkDio.getDioHttpMethod(
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.shippingPickupAddress,
      context: context,
    );
    if (shippingPickupAddress != null) {
      fullName.value = shippingPickupAddress['package_shipping_data']
              ['firstname'] +
          ' ' +
          shippingPickupAddress['package_shipping_data']['lastname'] +
          ' ' +
          shippingPickupAddress['package_shipping_data']['mce_number'];
      usaShippingData.value = shippingPickupAddress['package_shipping_data']
          ['usa_air_address_details'];
      pickuoBranchData.value =
          shippingPickupAddress['package_shipping_data']['branch_data'];
    }

    Map<String, dynamic>? categoriesListResponse =
        await NetworkDio.getDioHttpMethod(
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.shippingCategories,
      context: context,
    );
    if (categoriesListResponse != null) {
      categoriesList.value = categoriesListResponse['list'];
    }
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
          title: 'Success', sucessMessage: response['message']);
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
                leading: const SizedBox(),
                centerTitle: true,
                elevation: 0.0,
                title: const Text(
                  'MyCartExpress',
                ),
                actions: [
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const MessagesScreen());
                    },
                    child: const Icon(
                      Icons.mail_outline_rounded,
                    ),
                  ),
                  width15,
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const NotificationScreen());
                    },
                    child: const Icon(
                      Icons.notifications_active_outlined,
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
      ),
    );
  }

  Widget bodyView() {
    return Column(
      children: [
        balanceView(),
        height15,
        detailsView(),
        height15,
        packagesView(),
      ],
    );
  }

  Widget balanceView() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: primary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'E-Wallet Balance',
                  style: lightText14.copyWith(
                    color: whiteColor,
                  ),
                ),
                height5,
                Obx(
                  () => Text(
                    '\$${balance.value} JMD',
                    style: regularText18.copyWith(
                      color: whiteColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 15.0,
          ),
          child: GestureDetector(
            onTap: () {},
            child: Column(
              children: [
                Image.asset(
                  shareIcon,
                  height: 40,
                  width: 40,
                ),
                Text(
                  'Share this app',
                  style: lightText12,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget detailsView() {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'USA Shipping Address',
                    style: regularText14,
                  ),
                  height5,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Air freight',
                        style: lightText14.copyWith(
                          color: Colors.grey.shade600,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (ctx) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Stack(
                                    children: [
                                      Image.network(howItWorks.value),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pop(ctx);
                                        },
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            color: blackColor,
                                          ),
                                          child: const Icon(
                                            Icons.close,
                                            color: whiteColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Text(
                          "How it's Work?",
                          style: lightText14.copyWith(
                            color: primary,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  height15,
                  Obx(
                    () => Text(
                      fullName.isNotEmpty ? fullName.value : '',
                      style: lightText13,
                    ),
                  ),
                  height10,
                  Obx(
                    () => Text(
                      usaShippingData.isNotEmpty
                          ? usaShippingData['address_1'] +
                              ' ' +
                              usaShippingData['address_2'] +
                              ' ' +
                              usaShippingData['city'] +
                              ', ' +
                              usaShippingData['state'] +
                              ', ' +
                              usaShippingData['postcode']
                          : '',
                      style: lightText13,
                    ),
                  ),
                  height10,
                  Obx(
                    () => Text(
                      'USA Tel: +1 ${usaShippingData.isNotEmpty ? usaShippingData['telephone'] : ''}',
                      style: lightText13,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const VerticalDivider(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pick-Up Branch',
                    style: regularText14,
                  ),
                  height15,
                  Obx(() => Text(
                        pickuoBranchData.isNotEmpty
                            ? pickuoBranchData['location'] +
                                ' ' +
                                pickuoBranchData['address'] +
                                ' ' +
                                pickuoBranchData['city'] +
                                ', ' +
                                pickuoBranchData['parishname'] +
                                ', ' +
                                pickuoBranchData['code']
                            : '',
                        style: lightText13.copyWith(
                          color: primary,
                        ),
                      )),
                  height10,
                  Obx(() => Text(
                        pickuoBranchData.isNotEmpty
                            ? pickuoBranchData['open_hour']
                            : '',
                        style: lightText13.copyWith(
                          color: primary,
                        ),
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget packagesView() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(
          left: 15,
          top: 15,
          right: 15,
        ),
        decoration: BoxDecoration(
          color: greyColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Last 5 Packages',
                  style: regularText18,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(
                      () => const ShippingScreen(
                        isFromeHome: true,
                      ),
                    );
                  },
                  child: Text(
                    'View all',
                    style: lightText16,
                  ),
                ),
              ],
            ),
            height15,
            Expanded(
              child: Obx(
                () => packagesList.isEmpty
                    ? Center(
                        child: Image.asset(
                          emptyList,
                          height: 200,
                        ),
                      )
                    : ListView.separated(
                        itemCount: packagesList.length,
                        separatorBuilder: (BuildContext context, int index) =>
                            height10,
                        itemBuilder: (BuildContext context, int index) =>
                            Container(
                          padding: const EdgeInsets.all(15),
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
                                    Text(
                                      packagesList[index]['shipping_mcecode'],
                                      style: lightText13.copyWith(
                                        color: blackColor,
                                      ),
                                    ),
                                    height10,
                                    Text(
                                      packagesList[index]['tracking'],
                                      overflow: TextOverflow.ellipsis,
                                      style: lightText13.copyWith(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: orangeColor,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                  ),
                                ),
                                onPressed: () {
                                  uploadInvoice(
                                      packagesList[index]['package_id']);
                                },
                                child: Row(
                                  children: [
                                    const Text(
                                      'Invoice Needed',
                                      style: TextStyle(
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                    width10,
                                    Image.asset(
                                      addIcon,
                                      color: whiteColor,
                                      height: 14,
                                      width: 14,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
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
              'Declared Value',
              style: regularText14,
            ),
            height10,
            TextFormFieldWidget(
              hintText: 'Enter value here',
              controller: declared,
              validator: (value) =>
                  Validators.validateText(value, 'Declared value'),
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
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles(
                              type: FileType.custom,
                              allowedExtensions: [
                                'jpg',
                                'tiff',
                                'png',
                                'jpeg',
                                'pdf',
                                'doc',
                              ],
                            );
                            await pickFile(
                              result,
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
