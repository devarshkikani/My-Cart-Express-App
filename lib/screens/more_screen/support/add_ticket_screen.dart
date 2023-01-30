import 'dart:io';

import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:my_cart_express/theme/colors.dart';
import 'package:my_cart_express/widget/validator.dart';
import 'package:my_cart_express/theme/text_style.dart';
import 'package:my_cart_express/constant/sizedbox.dart';
import 'package:my_cart_express/utils/network_dio.dart';
import 'package:my_cart_express/constant/app_endpoints.dart';
import 'package:my_cart_express/widget/input_text_field.dart';

class AddTicketScreen extends StatefulWidget {
  const AddTicketScreen({super.key});

  @override
  State<AddTicketScreen> createState() => _AddTicketScreenState();
}

class _AddTicketScreenState extends State<AddTicketScreen> {
  TextEditingController title = TextEditingController();
  TextEditingController message = TextEditingController();
  File? selectedFile;
  RxString fileName = ''.obs;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  RxList subjectList = [].obs;
  RxList<String> subjects = <String>[].obs;
  RxString selectedSubject = ''.obs;

  @override
  void initState() {
    getSubjects();
    super.initState();
  }

  Future<void> pickFile(FilePickerResult? result) async {
    if (result != null) {
      selectedFile = File(result.files.first.path!);
      fileName.value = result.files.first.name;
      setState(() {});
    }
  }

  Future<void> getSubjects() async {
    Map<String, dynamic>? response = await NetworkDio.getDioHttpMethod(
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.subjects,
      context: context,
    );
    if (response != null) {
      subjectList.value = response['list'];
      for (var i = 0; i < subjectList.length; i++) {
        subjects.add(subjectList[i]['subject']);
      }
    }
  }

  Future<void> submitOnTap() async {
    final data = dio.FormData.fromMap({
      'title': selectedSubject.value,
      'message': message.text,
      'files': selectedFile != null
          ? await dio.MultipartFile.fromFile(
              selectedFile!.path,
              filename: fileName.value,
            )
          : null,
    });
    if (selectedSubject.value != '') {
      Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
        url: ApiEndPoints.apiEndPoint + ApiEndPoints.contactAgent,
        data: data,
        context: context,
      );
      if (response != null) {
        Get.back(
          result: true,
        );
        NetworkDio.showSuccess(
            title: 'Success', sucessMessage: response['message']);
      }
    } else {
      NetworkDio.showError(
        title: 'Warning',
        errorMessage: 'Please enter title first',
      );
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
              centerTitle: true,
              elevation: 0.0,
              title: const Text(
                'MyCartExpress',
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
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Contact an Agent',
                  style: regularText18,
                ),
              ],
            ),
            height20,
            Text(
              'Title',
              style: regularText14,
            ),
            height10,
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: blackColor,
                ),
              ),
              child: Obx(
                () => DropdownButton<String>(
                  underline: const SizedBox(),
                  isExpanded: true,
                  value: selectedSubject.value == ''
                      ? null
                      : selectedSubject.value,
                  hint: Text(
                    'Select title ',
                    style: lightText16.copyWith(
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                  icon: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: primary,
                  ),
                  items: subjects.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                      ),
                    );
                  }).toList(),
                  onChanged: (type) {
                    selectedSubject.value = type.toString();
                  },
                ),
              ),
            ),
            height20,
            Text(
              'Message',
              style: regularText14,
            ),
            height10,
            TextFormFieldWidget(
              hintText: 'Write message here...',
              controller: message,
              maxLines: 5,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              validator: (value) => Validators.validateText(value, 'Message'),
            ),
            height15,
            Text(
              'Attachment',
              style: lightText14,
            ),
            height15,
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
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
                          'Choosse file',
                        ),
                        Obx(() => Text(
                              fileName.value != ''
                                  ? fileName.value
                                  : 'No file chosen',
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
                          onPressed: () {
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
                  await submitOnTap();
                }
              },
              child: const Text(
                'Send',
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
                      allowedExtensions: ['jpg', 'tiff', 'png', 'jpeg'],
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
                      allowedExtensions: ['pdf', 'doc', 'tiff'],
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
  //                   type.text = categoriesList[i]['cat_name'];
  //                   catId.value = categoriesList[i]['id'];
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
