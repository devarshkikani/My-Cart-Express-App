// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:flutter_multi_formatter/formatters/phone_input_formatter.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:file_picker/file_picker.dart';
import 'package:my_cart_express/theme/colors.dart';
import 'package:my_cart_express/utils/network_dio.dart';
import 'package:my_cart_express/theme/text_style.dart';
import 'package:my_cart_express/widget/validator.dart';
import 'package:my_cart_express/constant/sizedbox.dart';
import 'package:my_cart_express/widget/app_bar_widget.dart';
import 'package:my_cart_express/constant/app_endpoints.dart';
import 'package:my_cart_express/constant/default_images.dart';
import 'package:my_cart_express/widget/input_text_field.dart';
import 'package:my_cart_express/screens/more_screen/more_screen.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  RxMap userDetails = {}.obs;
  RxList locationList = [].obs;
  RxString locationID = ''.obs;
  RxString filePath = ''.obs;
  RxString fileName = ''.obs;
  TextEditingController pickUpLocation = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController month = TextEditingController();
  TextEditingController year = TextEditingController();
  TextEditingController mobileNumber = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      date.text = picked.day.toString().padLeft(2, '0');
      month.text = picked.month.toString().padLeft(2, '0');
      year.text = picked.year.toString();
    }
  }

  Future<void> getLocation() async {
    Map<String, dynamic>? response = await NetworkDio.getDioHttpMethod(
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.userLocation,
      context: context,
    );
    if (response != null) {
      locationList.value = response['data'];
    }
  }

  @override
  void initState() {
    userDetails.value = MoreScreenState.userDetails;
    getLocation();
    super.initState();
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
                width: Get.width,
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
        Text(
          'Edit Profile',
          style: regularText18,
        ),
        height20,
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                profileView(),
                height20,
                editDetails(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget profileView() {
    return Center(
      child: Obx(
        () => Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: userDetails['image'].toString() != ''
                  ? Image.network(
                      userDetails['image'].toString(),
                      height: 100,
                      width: 100,
                    )
                  : Image.asset(
                      dummyProfileImage,
                      height: 100,
                      width: 100,
                    ),
            ),
            height20,
            Text(
              userDetails.isEmpty ? '' : userDetails['name'].toString(),
              style: regularText18.copyWith(
                color: blackColor,
                letterSpacing: 0.3,
              ),
            ),
            height5,
            Text(
              'User Code : ${userDetails.isEmpty ? '' : userDetails['mce_number'].toString()}',
              style: lightText16,
            ),
            height5,
            Text(
              'Email : ${userDetails.isEmpty ? '' : userDetails['email'].toString()}',
              style: lightText16,
            ),
            height5,
            Text(
              'Phone : ${userDetails.isEmpty ? '' : userDetails['phone'].toString()}',
              style: lightText16,
            ),
          ],
        ),
      ),
    );
  }

  Widget editDetails() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'PICK UP LOCATION',
            style: regularText14,
          ),
          height10,
          TextFormFieldWidget(
            hintText: 'Select Location',
            controller: pickUpLocation,
            readOnly: true,
            onTap: () {
              showBottomSheet(context);
            },
            suffixIcon: const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: primary,
            ),
            validator: (value) =>
                Validators.validateText(value, 'Pick Up Location'),
          ),
          height15,
          Text(
            'DATE',
            style: regularText14,
          ),
          height10,
          Row(
            children: [
              Expanded(
                child: TextFormFieldWidget(
                  hintText: 'Day',
                  controller: date,
                  readOnly: true,
                  onTap: () {
                    _selectDate(context);
                  },
                  suffixIcon: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: primary,
                  ),
                  validator: (value) => Validators.validateText(value, 'Date'),
                ),
              ),
              width10,
              Expanded(
                child: TextFormFieldWidget(
                  hintText: 'Month',
                  controller: month,
                  readOnly: true,
                  onTap: () {
                    _selectDate(context);
                  },
                  suffixIcon: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: primary,
                  ),
                  validator: (value) => Validators.validateText(value, 'Month'),
                ),
              ),
              width10,
              Expanded(
                child: TextFormFieldWidget(
                  hintText: 'Year',
                  controller: year,
                  readOnly: true,
                  onTap: () {
                    _selectDate(context);
                  },
                  suffixIcon: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: primary,
                  ),
                  validator: (value) => Validators.validateText(value, 'Year'),
                ),
              ),
            ],
          ),
          height15,
          Text(
            'Mobile Number',
            style: regularText14,
          ),
          height10,
          TextFormFieldWidget(
            hintText: 'Mobile Number',
            controller: mobileNumber,
            keyboardType: TextInputType.number,
            prefixIcon: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '+1',
                  style: lightText16,
                ),
              ],
            ),
            prefixIconConstraints: const BoxConstraints(
              minWidth: 24,
            ),
            maxLength: 14,
            validator: (value) =>
                Validators.validateText(value, 'Mobile Number'),
            inputFormatters: [
              PhoneInputFormatter(
                defaultCountryCode: 'US',
                allowEndlessPhone: true,
              )
            ],
          ),
          height15,
          Row(
            children: [
              Text(
                'UPLOAD ID',
                style: lightText14,
              ),
              Text(
                ' (PDF/JPEG/PNG/TIFF)',
                style: lightText14.copyWith(
                  color: Colors.grey,
                ),
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
                      Obx(
                        () => Text(
                          fileName.value == ''
                              ? '(filename.txt)'
                              : fileName.toString(),
                          style: lightText14.copyWith(
                            color: primary,
                          ),
                        ),
                      ),
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
                            borderRadius: BorderRadius.all(Radius.circular(5)),
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
          height15,
          const Text(
            'Upload File to Your Account \nDO NOT UPLOAD Shipping Invoice Here',
          ),
          height20,
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: primary,
              padding: const EdgeInsets.symmetric(horizontal: 40),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                saveOnTap();
              }
            },
            child: const Text(
              'SAVE',
              style: TextStyle(
                letterSpacing: 0.5,
              ),
            ),
          ),
          height20,
        ],
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

  Future<void> pickFile(FilePickerResult? result) async {
    if (result != null) {
      filePath.value = result.files.first.path!;
      fileName.value = result.files.first.name;
    }
  }

  Future<void> saveOnTap() async {
    final data = dio.FormData.fromMap({
      'location': locationID.value,
      'birth_date': '${year.text}-${month.text}-${date.text}',
      'phone': mobileNumber.text
          .replaceAll('(', '')
          .replaceAll(')', '')
          .replaceAll('-', '')
          .replaceAll(' ', ''),
      'file': filePath.value != ''
          ? await dio.MultipartFile.fromFile(
              filePath.value,
              filename: fileName.value,
            )
          : null,
    });
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.userEditInfo,
      data: data,
      context: context,
    );
    if (response != null) {
      if (response['status'] == 200) {
        await getUserInfo(response['message']);
      }
    }
  }

  Future<void> getUserInfo(String messgae) async {
    Map<String, dynamic>? response = await NetworkDio.getDioHttpMethod(
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.userInfo,
      context: context,
    );

    if (response != null) {
      userDetails.value = response['data'];
      MoreScreenState.userDetails.value = response['data'];
      Get.back(
        result: userDetails,
      );
      NetworkDio.showSuccess(
        title: 'Success',
        sucessMessage: messgae,
      );
    }
  }

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (BuildContext context) {
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
                    pickUpLocation.text = locationList[i]['parish_name'];
                    locationID.value = locationList[i]['id'];
                  },
                  children: List.generate(
                    locationList.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        locationList[index]['parish_name'],
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
                    Navigator.pop(context);
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
