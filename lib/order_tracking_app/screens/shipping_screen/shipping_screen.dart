// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_cart_express/order_tracking_app/theme/colors.dart';
import 'package:my_cart_express/order_tracking_app/theme/text_style.dart';
import 'package:my_cart_express/order_tracking_app/widget/validator.dart';
import 'package:my_cart_express/order_tracking_app/constant/sizedbox.dart';
import 'package:my_cart_express/order_tracking_app/utils/network_dio.dart';
import 'package:my_cart_express/order_tracking_app/constant/app_endpoints.dart';
import 'package:my_cart_express/order_tracking_app/constant/default_images.dart';
import 'package:my_cart_express/order_tracking_app/widget/input_text_field.dart';
import 'package:my_cart_express/order_tracking_app/screens/shipping_screen/packages_details_screen.dart';

class ShippingScreen extends StatefulWidget {
  const ShippingScreen({super.key, required this.isFromeHome});
  final bool isFromeHome;
  @override
  State<ShippingScreen> createState() => _ShippingScreenState();
}

class _ShippingScreenState extends State<ShippingScreen> {
  ScrollController scrollController = ScrollController();
  RxList shippmentsList = [].obs;
  RxString searchData = ''.obs;
  RxBool isLoading = true.obs;
  RxInt offSet = 0.obs;
  RxInt selectedIndex = 0.obs;
  TextEditingController type = TextEditingController();
  TextEditingController declared = TextEditingController();
  File? selectedFile;
  RxString catId = ''.obs;
  RxString fileName = ''.obs;
  RxList categoriesList = [].obs;
  RxInt categorySelectIndex = 0.obs;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    getCategoriesList();

    debounce<String>(searchData, validations,
        time: const Duration(milliseconds: 700));
    scrollController = ScrollController()..addListener(_scrollListener);
    super.initState();
  }

  validations(String string) async {
    await getShippments(string);
  }

  Future<void> _scrollListener() async {
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      await getShippments(searchData.value != '' ? searchData.value : null);
    }
  }

  Future<void> getShippments(
    String? value, {
    bool? forceAssign,
  }) async {
    if (forceAssign == true) {
      offSet.value = 0;
    }
    Map<String, dynamic> map = {
      'search_text': value,
      'offset': value == null ? offSet.value : 0,
      'invoice_needed': selectedIndex.value == 1 ? 1 : 0,
      'in_transit': selectedIndex.value == 2 ? 1 : 0,
      'is_collected': selectedIndex.value == 3 ? 1 : 0,
    };
    final data = dio.FormData.fromMap(map);
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
        url: ApiEndPoints.apiEndPoint + ApiEndPoints.shippingList,
        context: context,
        data: data);

    if (response != null) {
      isLoading.value = false;
      if (shippmentsList.isEmpty) {
        shippmentsList.value = response['list'];
      } else if (value != null) {
        shippmentsList.value = response['list'];
      } else {
        for (var i = 0; i < response['list'].length; i++) {
          shippmentsList.add(response['list'][i]);
        }
      }
      if (forceAssign == true) {
        shippmentsList.value = response['list'];
      }
      offSet.value = response['offset'];
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
    getShippments(null);
  }

  Future<void> pickFile(String path, String name) async {
    selectedFile = File(path); //File(result.files.first.path!).obs;
    fileName.value = name; //result.files.first.name;
    setState(() {});
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
      offSet.value = 0;
      shippmentsList.value = [];
      await getShippments(null);
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
              leading: widget.isFromeHome
                  ? IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(
                        Platform.isAndroid
                            ? Icons.arrow_back_rounded
                            : Icons.arrow_back_ios_rounded,
                        color: whiteColor,
                      ),
                    )
                  : const SizedBox(),
              centerTitle: true,
              elevation: 0.0,
              title: Text(
                'MyCartExpress',
                style: regularText20.copyWith(
                  color: whiteColor,
                ),
              ),
            ),
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
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Shipments',
              style: regularText14,
            ),
            const SizedBox(
              width: 100,
            ),
            Expanded(
              child: TextFormFieldWidget(
                hintText: 'Search',
                onChanged: (String? value) {
                  searchData.value = value ?? '';
                },
              ),
            ),
          ],
        ),
        height15,
        buttonListWidget(),
        height15,
        Expanded(
          child: Obx(() {
            return isLoading.value
                ? const SizedBox()
                : shippmentsList.isEmpty
                    ? Center(
                        child: Text(
                          'No shipments found.',
                          style: lightText14.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                      )
                    : shippingList();
          }),
        ),
      ],
    );
  }

  Widget buttonListWidget() {
    return Column(
      children: [
        Row(
          children: [
            Obx(
              () => filterButton(
                bgcolor: selectedIndex.value == 0 ? primary : Colors.grey,
                name: 'All',
                onTap: () async {
                  selectedIndex.value = 0;
                  await getShippments(null, forceAssign: true);
                },
              ),
            ),
            width15,
            Obx(
              () => filterButton(
                bgcolor: selectedIndex.value == 1 ? primary : Colors.grey,
                name: 'Invoice Needed',
                onTap: () async {
                  selectedIndex.value = 1;
                  await getShippments(null, forceAssign: true);
                },
              ),
            ),
          ],
        ),
        height5,
        Row(
          children: [
            Obx(
              () => filterButton(
                bgcolor: selectedIndex.value == 2 ? primary : Colors.grey,
                name: 'In Transit',
                onTap: () async {
                  selectedIndex.value = 2;
                  await getShippments(null, forceAssign: true);
                },
              ),
            ),
            width15,
            Obx(
              () => filterButton(
                bgcolor: selectedIndex.value == 3 ? primary : Colors.grey,
                name: 'Collected',
                onTap: () async {
                  selectedIndex.value = 3;
                  await getShippments(null, forceAssign: true);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget filterButton({
    required String name,
    required Color bgcolor,
    required Function() onTap,
  }) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bgcolor,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
        ),
        onPressed: onTap,
        child: Text(
          name,
          style: const TextStyle(
            letterSpacing: 0.5,
            color: whiteColor,
          ),
        ),
      ),
    );
  }

  Widget shippingList() {
    return ListView.separated(
      itemCount: shippmentsList.length,
      padding: EdgeInsets.zero,
      controller: scrollController,
      separatorBuilder: (BuildContext context, int index) => height20,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            Get.to(() => MyPackagesDetailsScreen(
                  packagesDetails: shippmentsList[index],
                  isFromAll: true,
                ));
          },
          child: Container(
            decoration: BoxDecoration(
              color: shippmentsList[index]['status'] == 'Available for Pickup'
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
                  padding: const EdgeInsets.all(15),
                  decoration: const BoxDecoration(
                    color: greyColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          shippmentsList[index]['status'],
                          style: regularText14.copyWith(
                            color: primary,
                          ),
                        ),
                        const VerticalDivider(
                          color: primary,
                        ),
                        Row(
                          children: [
                            const Text(
                              'Value : ',
                            ),
                            Text(
                              shippmentsList[index]['value_cost'].toString(),
                              style: const TextStyle(
                                color: primary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: greyColor.withOpacity(0.2),
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      width20,
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: SizedBox(
                            height: 60,
                            width: 60,
                            child: Image.network(
                              shippmentsList[index]['package_image'],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      width20,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              shippmentsList[index]['shipping_mcecode'],
                              style: regularText14.copyWith(
                                color: primary,
                              ),
                            ),
                            height10,
                            Column(
                              children: [
                                Text(
                                  shippmentsList[index]['tracking'],
                                  // overflow: TextOverflow.ellipsis,
                                  style: regularText14.copyWith(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            height10,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  shippmentsList[index]['weight_label'],
                                  overflow: TextOverflow.ellipsis,
                                  style: regularText14.copyWith(
                                    color: Colors.grey,
                                  ),
                                ),
                                const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Colors.grey,
                                  size: 14,
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: const BoxDecoration(
                            color: greyColor,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              shippmentsList[index]['status_id'] == '6' ||
                                      shippmentsList[index]['status_id'] == '19'
                                  ? Text(
                                      'TOTAL COST : ${shippmentsList[index]['amount'] ?? 0.00}',
                                      style: lightText12.copyWith(
                                        color: blackColor,
                                      ),
                                    )
                                  : Text(
                                      shippmentsList[index]
                                          ['flight_eta_status'],
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
                          onTap: shippmentsList[index]
                                      ['upload_attachment_flag'] ==
                                  1
                              ? () {
                                  uploadInvoice(
                                      shippmentsList[index]['package_id']);
                                }
                              : null,
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: shippmentsList[index]
                                          ['upload_attachment_flag'] ==
                                      1
                                  ? orangeColor
                                  : primary,
                              borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  shippmentsList[index]['invoice_type_label'],
                                  style: lightText12.copyWith(
                                    color: whiteColor,
                                  ),
                                ),
                                width10,
                                shippmentsList[index]
                                            ['upload_attachment_flag'] ==
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
        );
      },
    );
  }

  void uploadInvoice(String packageId) async {
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
              child: uploadFileBodyView(packageId),
            ),
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
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
              ],
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

  showConformatonDialog(String packageId, BuildContext ctx) {
    showDialog(
      context: ctx,
      builder: (BuildContext ctttx) {
        return AlertDialog(
          title: const Text("Confirm"),
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
                await submitOnTap(packageId);
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
                    // FilePickerResult? result =
                    //     await FilePicker.platform.pickFiles(
                    //   type: FileType.custom,
                    //   allowMultiple: true,
                    //   allowedExtensions: ['jpg', 'png', 'jpeg'],
                    // );
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
