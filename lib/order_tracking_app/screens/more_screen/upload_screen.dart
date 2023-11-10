// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:my_cart_express/order_tracking_app/theme/colors.dart';
// import 'package:my_cart_express/order_tracking_app/widget/validator.dart';
import 'package:my_cart_express/order_tracking_app/theme/text_style.dart';
import 'package:my_cart_express/order_tracking_app/constant/sizedbox.dart';
import 'package:my_cart_express/order_tracking_app/utils/network_dio.dart';
import 'package:my_cart_express/order_tracking_app/widget/app_bar_widget.dart';
import 'package:my_cart_express/order_tracking_app/constant/app_endpoints.dart';
// import 'package:my_cart_express/order_tracking_app/widget/input_text_field.dart';

class UploadFileScreen extends StatefulWidget {
  const UploadFileScreen({super.key});

  @override
  State<UploadFileScreen> createState() => _UploadFileScreenState();
}

class _UploadFileScreenState extends State<UploadFileScreen> {
  TextEditingController type = TextEditingController();
  File? selectedFile;
  // RxString catId = ''.obs;
  RxString fileName = ''.obs;
  // RxList categoriesList = [].obs;
  // RxInt categorySelectIndex = 0.obs;
  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // @override
  // void initState() {
  //   super.initState();
  // getShippingCategories();
  // }

  // Future<void> getShippingCategories() async {
  //   Map<String, dynamic>? response = await NetworkDio.getDioHttpMethod(
  //     url: ApiEndPoints.apiEndPoint + ApiEndPoints.shippingCategories,
  //     context: context,
  //   );
  //   if (response != null) {
  //     categoriesList.value = response['list'];
  //   }
  // }

  Future<void> pickFile(String path, String name) async {
    selectedFile = File(path); //File(result.files.first.path!).obs;
    fileName.value = name; //result.files.first.name;
    setState(() {});
  }

  Future<void> submitOnTap() async {
    final data = dio.FormData.fromMap({
      'files': await dio.MultipartFile.fromFile(
        selectedFile!.path,
        filename: fileName.value,
      ),
      'file_name': fileName.value,
      // 'file_type_id': catId.value,
    });
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.uploadFileAttachment,
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
          children: [
            Text(
              'Upload File',
              style: regularText18,
            ),
          ],
        ),
        height20,
        Row(
          children: [
            Text(
              'UPLOAD ID',
              style: lightText14,
            ),
            Text(
              ' (JPG,JPEG,PNG)',
              style: lightText14.copyWith(
                color: Colors.grey,
              ),
            ),
          ],
        ),
        height15,
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
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: greyColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
          ),
          onPressed: () {
            selectFileType(context);
          },
          child: const Text(
            'Select /Upload File',
            style: TextStyle(
              letterSpacing: 0.5,
              color: primary,
            ),
          ),
        ),
        height15,
        const Text(
          'Upload File to Your Account \nDO NOT UPLOAD Shipping Invoice Here',
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
            if (fileName.value != '') {
              await submitOnTap();
            } else {
              NetworkDio.showError(
                  title: 'Warning', errorMessage: 'Select file first');
            }
          },
          child: const Text(
            'SUBMIT',
            style: TextStyle(
              letterSpacing: 0.5,
            ),
          ),
        ),
        height20,
      ],
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
                    // XFile? result = await ImagePicker()
                    //     .pickImage(source: ImageSource.gallery);
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowMultiple: true,
                      allowedExtensions: ['jpg', 'png', 'jpeg', 'tiff'],
                    );
                    if (result != null) {
                      await pickFile(
                        result.files.first.path!,
                        result.files.first.name,
                      );
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
                    XFile? result = await ImagePicker()
                        .pickImage(source: ImageSource.camera);
                    if (result != null) {
                      await pickFile(
                        result.path,
                        result.name,
                      );
                      setState(() {});
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
                    "TAKE PHOTO",
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

  // void showBottomSheet(BuildContext context, int index) {
  //   showModalBottomSheet(
  //     context: context,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(10.0),
  //     ),
  //     builder: (BuildContext context) {
  //       return SizedBox(
  //         height: 250,
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.stretch,
  //           children: [
  //             Expanded(
  //               child: CupertinoPicker(
  //                 itemExtent: 40,
  //                 magnification: 1.33,
  //                 squeeze: 1.2,
  //                 useMagnifier: true,
  //                 looping: true,
  //                 onSelectedItemChanged: (int i) {
  //                   categorySelectIndex.value = i;
  //                 },
  //                 children: List.generate(
  //                   categoriesList.length,
  //                   (index) => Padding(
  //                     padding: const EdgeInsets.only(top: 8.0),
  //                     child: Text(
  //                       categoriesList[index]['cat_name'],
  //                       style: mediumText18.copyWith(
  //                         color: primary,
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             Padding(
  //               padding: const EdgeInsets.symmetric(horizontal: 15.0),
  //               child: ElevatedButton(
  //                 style: ElevatedButton.styleFrom(
  //                   maximumSize: Size(Get.width, 50),
  //                   shape: const RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.all(
  //                       Radius.circular(5),
  //                     ),
  //                   ),
  //                 ),
  //                 onPressed: () {
  //                   type.text =
  //                       categoriesList[categorySelectIndex.value]['cat_name'];
  //                   catId.value =
  //                       categoriesList[categorySelectIndex.value]['id'];

  //                   Navigator.pop(context);
  //                 },
  //                 child: const Text(
  //                   'SELECT',
  //                   style: TextStyle(
  //                     letterSpacing: 1,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             height10,
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }
}
