// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:my_cart_express/order_tracking_app/constant/default_images.dart';
import 'package:my_cart_express/order_tracking_app/models/package_model_detail.dart';
import 'package:timelines/timelines.dart';
import 'package:file_picker/file_picker.dart';
import 'package:my_cart_express/order_tracking_app/theme/colors.dart';
import 'package:my_cart_express/order_tracking_app/theme/text_style.dart';
import 'package:my_cart_express/order_tracking_app/widget/validator.dart';
import 'package:my_cart_express/order_tracking_app/utils/network_dio.dart';
import 'package:my_cart_express/order_tracking_app/constant/sizedbox.dart';
import 'package:my_cart_express/order_tracking_app/constant/app_endpoints.dart';
import 'package:my_cart_express/order_tracking_app/widget/input_text_field.dart';

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
  TextEditingController type = TextEditingController();
  TextEditingController declared = TextEditingController();
  File? selectedFile;
  RxString catId = ''.obs;
  RxString fileName = ''.obs;
  RxList categoriesList = [].obs;
  RxInt categorySelectIndex = 0.obs;

  PackageDetailModel? packageDetailModel;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    getTrackingDetails();
  }

  getTrackingDetails({bool? notshow}) async {
    Map<String, dynamic>? response = await NetworkDio.getDioHttpMethod(
        url: ApiEndPoints.apiEndPoint +
            ApiEndPoints.shippingTracking +
            widget.packagesDetails[widget.isFromAll ? 'package_id' : 'pkg_id'],
        context: notshow == true ? null : context);
    timeline = [];
    dateTimeline = [];
    if (response != null) {
      packageDetailModel = PackageDetailModel.fromJson(response);
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

  Future<void> pickFile(String path, String name) async {
    selectedFile = File(path); //File(result.files.first.path!).obs;
    fileName.value = name; //result.files.first.name;
    setState(() {});
  }

  Future<void> submitOnTap(String? packageId, int editFlag) async {
    final data = dio.FormData.fromMap({
      'files': await dio.MultipartFile.fromFile(
        selectedFile!.path,
        filename: fileName.value,
      ),
      'attachment_package_id': packageId,
      'attach_for': 'invoice',
      'edit_flag': editFlag,
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
        // width: Get.height,
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
                height: Get.height,
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
    return RefreshIndicator(
      onRefresh: () async {
        await getTrackingDetails(notshow: true);
      },
      child: ListView(
        padding: EdgeInsets.zero,
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
                          packageDetailModel?.data.status ?? '',
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
                              packageDetailModel?.data.flightEtaStatus ?? '',
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
                                  '''Tracking #: ${widget.packagesDetails['tracking'] ?? ''}''',
                                  // overflow: TextOverflow.ellipsis,
                                  style: regularText14.copyWith(
                                    color: Colors.grey,
                                  ),
                                ),
                                height10,
                                Text(
                                  '''Weight: ${widget.packagesDetails['weight_label'] ?? '00LB'}''',
                                  overflow: TextOverflow.ellipsis,
                                  style: regularText14.copyWith(
                                    color: Colors.grey,
                                  ),
                                ),
                                if (widget.packagesDetails['status_id'] == '6')
                                  height10,
                                if (widget.packagesDetails['status_id'] == '6')
                                  Text(
                                    '''Storage days: ${packageDetailModel?.data.storageDays ?? 0}''',
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
                        '''Declared Value: \n\$${widget.packagesDetails['value_cost'] ?? 0.00} USD''',
                        overflow: TextOverflow.ellipsis,
                        style: regularText18.copyWith(
                          color: primary,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: GestureDetector(
                          onTap: widget.packagesDetails[
                                      'upload_attachment_flag'] ==
                                  1
                              ? () {
                                  uploadInvoice(
                                      widget.packagesDetails['package_id'], 0);
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
                                  widget.packagesDetails[
                                          'invoice_type_label'] ??
                                      'Invoice Uploaded',
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
                      if (packageDetailModel?.data.freightCharges != '0.00')
                        Text(
                          '''Freight Charges : \$${packageDetailModel?.data.freightCharges ?? 0.00}''',
                          overflow: TextOverflow.ellipsis,
                          style: lightText14,
                        ),
                      if (packageDetailModel?.data.inlandCharges != '0.00')
                        height10,
                      if (packageDetailModel?.data.inlandCharges != '0.00')
                        Text(
                          '''Inland Charges : \$${packageDetailModel?.data.inlandCharges ?? 0.00}''',
                          overflow: TextOverflow.ellipsis,
                          style: lightText14,
                        ),
                      if (packageDetailModel?.data.storageFee != '0.00')
                        height10,
                      if (packageDetailModel?.data.storageFee != '0.00')
                        Text(
                          '''Storage Fee : \$${packageDetailModel?.data.storageFee ?? 0.00} (${packageDetailModel?.data.storageDays ?? 0} day)''',
                          overflow: TextOverflow.ellipsis,
                          style: lightText14,
                        ),
                      if (packageDetailModel?.data.processingFee != '0.00')
                        height10,
                      if (packageDetailModel?.data.processingFee != '0.00')
                        Text(
                          '''Processing Fee : \$${packageDetailModel?.data.processingFee ?? 0.00}''',
                          overflow: TextOverflow.ellipsis,
                          style: lightText14,
                        ),
                      if (packageDetailModel?.data.tax != '0.00') height10,
                      if (packageDetailModel?.data.tax != '0.00')
                        Text(
                          '''Tax : \$${packageDetailModel?.data.tax ?? 0.00} (${packageDetailModel?.data.gctTaxPercentage ?? 0.00}%)''',
                          overflow: TextOverflow.ellipsis,
                          style: lightText14,
                        ),
                      if (packageDetailModel?.data.dutyTax != '0.00') height10,
                      if (packageDetailModel?.data.dutyTax != '0.00')
                        Text(
                          '''Duty Tax : \$${packageDetailModel?.data.dutyTax ?? 0.00} (${packageDetailModel?.data.dutyTaxPercentage ?? 0.00}%)''',
                          overflow: TextOverflow.ellipsis,
                          style: lightText14,
                        ),
                      if (packageDetailModel?.data.deliveryCost != '0.00')
                        height10,
                      if (packageDetailModel?.data.deliveryCost != '0.00')
                        Text(
                          '''Delivery Cost : \$${packageDetailModel?.data.deliveryCost ?? 0.00}''',
                          overflow: TextOverflow.ellipsis,
                          style: lightText14,
                        ),
                      if (packageDetailModel?.data.gct != '0.00') height10,
                      if (packageDetailModel?.data.gct != '0.00')
                        Text(
                          '''GCT : \$${packageDetailModel?.data.gct ?? 0.00}''',
                          overflow: TextOverflow.ellipsis,
                          style: lightText14,
                        ),
                      if (packageDetailModel?.data.thirdPartyDeliveryCost !=
                          '0.00')
                        height10,
                      if (packageDetailModel?.data.thirdPartyDeliveryCost !=
                          '0.00')
                        Text(
                          '''Third Party Delivery Cost : \$${packageDetailModel?.data.thirdPartyDeliveryCost ?? 0.00}''',
                          overflow: TextOverflow.ellipsis,
                          style: lightText14,
                        ),
                      if (packageDetailModel?.data.badAddressFee != '0.00')
                        height10,
                      if (packageDetailModel?.data.badAddressFee != '0.00')
                        Text(
                          '''Bad Address Fee : \$${packageDetailModel?.data.badAddressFee ?? 0.00}''',
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
                    '''Estimated Total Due : \n\$${packageDetailModel?.data.amountDue ?? 0.00} JMD''',
                    overflow: TextOverflow.ellipsis,
                    style: regularText18.copyWith(
                      color: primary,
                    ),
                  ),
                ),
              ],
            ),
          height25,
          if (widget.packagesDetails['edit_invoice'] == 1)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(
                  () => fileName.value != ''
                      ? Text(
                          fileName.value,
                          style: lightText14.copyWith(
                            color: primary,
                          ),
                        )
                      : const SizedBox(),
                ),
                Obx(
                  () =>
                      fileName.value != '' ? const Spacer() : const SizedBox(),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                  ),
                  onPressed: () {
                    uploadInvoice(widget.packagesDetails['package_id'], 1);
                  },
                  child: const Text(
                    'Edit Invoice',
                    style: TextStyle(
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ],
            ),
          if (widget.packagesDetails['edit_invoice'] == 1) height25,
          Text(
            'Timeline',
            style: regularText16,
          ),
          height25,
          Timeline.tileBuilder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            theme: TimelineThemeData(nodePosition: 0.25),
            physics: const NeverScrollableScrollPhysics(),
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
          )
        ],
      ),
    );
  }

  void uploadInvoice(String packageId, int editFlag) async {
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
              child: uploadFileBodyView(packageId, editFlag),
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

  Widget uploadFileBodyView(String packageId, int editFlag) {
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
                    await showConformatonDialog(packageId, context, editFlag);
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

  showConformatonDialog(String packageId, BuildContext ctx, int editFlag) {
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
                await submitOnTap(packageId, editFlag);
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
