// ignore_for_file: must_be_immutable

import 'dart:io';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:my_cart_express/constant/default_images.dart';
import 'package:timelines/timelines.dart';
import 'package:file_picker/file_picker.dart';
import 'package:my_cart_express/theme/colors.dart';
import 'package:my_cart_express/theme/text_style.dart';
import 'package:my_cart_express/widget/validator.dart';
import 'package:my_cart_express/utils/network_dio.dart';
import 'package:my_cart_express/constant/sizedbox.dart';
import 'package:my_cart_express/constant/app_endpoints.dart';
import 'package:my_cart_express/widget/input_text_field.dart';

class MyPackagesDetailsScreen extends StatefulWidget {
  Map packagesDetails = {}.obs;
  late bool isFromAll;
  MyPackagesDetailsScreen(
      {super.key, required this.packagesDetails, required this.isFromAll});

  @override
  State<MyPackagesDetailsScreen> createState() =>
      _MyPackagesDetailsScreenState();
}

class _MyPackagesDetailsScreenState extends State<MyPackagesDetailsScreen> {
  List timeline = [];
  List dateTimeline = [];
  RxList shippmentsList = [].obs;
  RxString searchData = ''.obs;
  RxBool isLoading = true.obs;
  RxInt offSet = 0.obs;
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
    getTrackingDetails();
  }

  getTrackingDetails() async {
    Map<String, dynamic>? response = await NetworkDio.getDioHttpMethod(
        url: ApiEndPoints.apiEndPoint +
            ApiEndPoints.shippingTracking +
            widget.packagesDetails[widget.isFromAll ? 'package_id' : 'pkg_id'],
        context: context);
    if (response != null) {
      getCategoriesList();
      for (int i = 0; i < response['package_tracking'].length; i++) {
        timeline.add(response['package_tracking'][i]['package_status']);
        dateTimeline.add(
            '${response['package_tracking'][i]['date_time'].toString().split('/').first}-${DateFormat('MMMM').format(DateTime(0, int.parse(response['package_tracking'][i]['date_time'].toString().split('/')[1].toString())))}');
      }
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
      offSet.value = 0;
      shippmentsList.value = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    log(widget.packagesDetails.toString());
    return Scaffold(
      body: Container(
        width: Get.height,
        color: primary,
        child: Column(
          children: [
            AppBar(
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
              centerTitle: false,
              elevation: 0.0,
              title: const Text(
                'My Packages > More',
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
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
                        widget.packagesDetails['status'],
                        style: regularText14.copyWith(
                          color: primary,
                        ),
                      ),
                      const VerticalDivider(
                        color: primary,
                      ),
                      Row(
                        children: [
                          Text(
                            '${widget.packagesDetails[widget.isFromAll ? 'flight_eta_status' : 'ontime_text']} : ',
                            style: regularText14.copyWith(
                              color: success,
                            ),
                          ),
                          Text(
                            widget.packagesDetails[widget.isFromAll
                                ? 'flight_eta_date'
                                : 'ontime_eta'],
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
                decoration: const BoxDecoration(
                  color: offWhite,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        width10,
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: SizedBox(
                            height: 60,
                            width: 60,
                            child: Image.network(
                              widget.packagesDetails['package_image'],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        width20,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '''Package #: ${widget.packagesDetails[widget.isFromAll ? 'shipping_mcecode' : 'pkg_shipging_code']}''',
                                style: regularText14.copyWith(
                                  color: primary,
                                ),
                              ),
                              height10,
                              Text(
                                '''Tracking #: ${widget.packagesDetails['tracking']}''',
                                overflow: TextOverflow.ellipsis,
                                style: regularText14.copyWith(
                                  color: Colors.grey,
                                ),
                              ),
                              height10,
                              Text(
                                '''Weight: ${widget.packagesDetails['weight_label']}''',
                                overflow: TextOverflow.ellipsis,
                                style: regularText14.copyWith(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (widget.packagesDetails['status_id'] == '6' ||
            widget.packagesDetails['status_id'] == '19')
          Column(
            children: [
              height25,
              Container(
                width: Get.width,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: greyColor,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '''Declared Value: \n\$${widget.packagesDetails['value_cost']} USD''',
                      overflow: TextOverflow.ellipsis,
                      style: regularText18.copyWith(
                        color: primary,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        onTap:
                            widget.packagesDetails['upload_attachment_flag'] ==
                                    1
                                ? () {
                                    uploadInvoice(
                                        widget.packagesDetails['package_id']);
                                  }
                                : null,
                        child: Container(
                          width: 200,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: widget.packagesDetails[
                                        'upload_attachment_flag'] ==
                                    1
                                ? orangeColor
                                : primary,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                widget.packagesDetails['invoice_type_label'],
                                style: lightText12.copyWith(
                                  color: whiteColor,
                                ),
                              ),
                              width10,
                              widget.packagesDetails[
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
                    )
                  ],
                ),
              ),
              height10,
              Container(
                width: Get.width,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '''Freight Charges: \$${widget.packagesDetails['freight_cost']} JMD''',
                      overflow: TextOverflow.ellipsis,
                      style: lightText14,
                    ),
                    height10,
                    Text(
                      '''Processing Fee: ${widget.packagesDetails['processing_fee']} JMD''',
                      overflow: TextOverflow.ellipsis,
                      style: lightText14,
                    ),
                  ],
                ),
              ),
              height10,
              Container(
                width: Get.width,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: greyColor,
                  ),
                ),
                child: Text(
                  '''Estimated Total Due: \n\$${widget.packagesDetails['amount']} JMD''',
                  overflow: TextOverflow.ellipsis,
                  style: regularText18.copyWith(
                    color: primary,
                  ),
                ),
              ),
            ],
          ),
        height25,
        Text(
          'Timeline',
          style: regularText16,
        ),
        height25,
        Expanded(
          child: Timeline.tileBuilder(
            padding: EdgeInsets.zero,
            theme: TimelineThemeData(nodePosition: 0.25),
            builder: TimelineTileBuilder.fromStyle(
              itemCount: timeline.length,
              contentsAlign: ContentsAlign.basic,
              oppositeContentsBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(dateTimeline[index]),
                );
              },
              contentsBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    timeline[index],
                  ),
                );
              },
            ),
          ),
        )
      ],
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
