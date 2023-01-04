import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:my_cart_express/constant/app_endpoints.dart';
import 'package:my_cart_express/constant/sizedbox.dart';
import 'package:my_cart_express/theme/colors.dart';
import 'package:my_cart_express/theme/text_style.dart';
import 'package:my_cart_express/utils/network_dio.dart';
import 'package:my_cart_express/widget/app_bar_widget.dart';
import 'package:my_cart_express/widget/input_text_field.dart';
import 'package:my_cart_express/widget/validator.dart';

class AuthPickupScreen extends StatefulWidget {
  const AuthPickupScreen({super.key});

  @override
  State<AuthPickupScreen> createState() => _AuthPickupScreenState();
}

class _AuthPickupScreenState extends State<AuthPickupScreen> {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController idNumber = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  RxString idType = ''.obs;

  RxList pickUpType = [].obs;
  RxString pickUpId = ''.obs;
  RxList<String> pickUpTypeName = <String>[].obs;

  @override
  void initState() {
    super.initState();
    getAuthorizePickupType();
  }

  void getAuthorizePickupType() async {
    Map<String, dynamic>? response = await NetworkDio.getDioHttpMethod(
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.pickupType,
      context: context,
    );
    if (response != null) {
      pickUpType.value = response['data'];
      for (var i = 0; i < pickUpType.length; i++) {
        pickUpTypeName.add(pickUpType[i]['type_name']);
      }
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
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Authorise Pick Up',
            style: regularText18,
          ),
          formView(),
        ],
      ),
    );
  }

  Widget formView() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          height30,
          Text(
            'First Name',
            style: regularText14,
          ),
          height10,
          TextFormFieldWidget(
            hintText: 'First name',
            controller: firstName,
            validator: (value) => Validators.validateText(value, 'First Name'),
          ),
          height15,
          Text(
            'Last Name',
            style: regularText14,
          ),
          height10,
          TextFormFieldWidget(
            hintText: 'Last name',
            controller: lastName,
            validator: (value) => Validators.validateText(value, 'Last Name'),
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
            validator: (value) =>
                Validators.validateText(value, 'Mobile Number'),
          ),
          height15,
          Text(
            'ID Type',
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
                value: idType.value == '' ? null : idType.value,
                hint: Text(
                  'Select ID Type',
                  style: lightText16.copyWith(
                    color: Theme.of(context).hintColor,
                  ),
                ),
                icon: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: primary,
                ),
                items: pickUpTypeName.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                    ),
                  );
                }).toList(),
                onChanged: (type) {
                  idType.value = type.toString();
                  for (var element in pickUpType) {
                    if (element['type_name'] == type) {
                      pickUpId.value = element['authorized_type_list_id'];
                    }
                  }
                },
              ),
            ),
          ),
          height15,
          Text(
            'ID Number',
            style: regularText14,
          ),
          height10,
          TextFormFieldWidget(
            hintText: 'ID Number',
            controller: idNumber,
            validator: (value) => Validators.validateText(value, 'ID Number'),
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
                await submitButton();
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
      ),
    );
  }

  Future<void> submitButton() async {
    final data = dio.FormData.fromMap({
      'id': 0,
      'first_name': firstName.text,
      'last_name': lastName.text,
      'phone_number': mobileNumber.text,
      'id_type': idType.value,
      'id_number': idNumber.text,
    });
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.pickupAdd,
      data: data,
      context: context,
    );
    if (response != null) {
      Get.back();
    }
  }
}
