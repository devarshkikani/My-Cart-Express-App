import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:my_cart_express/order_tracking_app/constant/app_endpoints.dart';
import 'package:my_cart_express/order_tracking_app/constant/default_images.dart';
import 'package:my_cart_express/order_tracking_app/constant/sizedbox.dart';
import 'package:my_cart_express/order_tracking_app/screens/home/main_home_screen.dart';
import 'package:my_cart_express/order_tracking_app/screens/home_screen/home_screen.dart';
import 'package:my_cart_express/order_tracking_app/screens/more_screen/more_screen.dart';
import 'package:my_cart_express/order_tracking_app/theme/colors.dart';
import 'package:my_cart_express/order_tracking_app/theme/text_style.dart';
import 'package:my_cart_express/order_tracking_app/utils/network_dio.dart';
import 'package:my_cart_express/order_tracking_app/widget/app_bar_widget.dart';
import 'package:my_cart_express/order_tracking_app/widget/input_text_field.dart';
import 'package:my_cart_express/order_tracking_app/widget/network_image_handle.dart';
import 'package:my_cart_express/order_tracking_app/widget/validator.dart';

class ChangeNameScreen extends StatefulWidget {
  const ChangeNameScreen({super.key});

  @override
  State<ChangeNameScreen> createState() => _ChangeNameScreenState();
}

class _ChangeNameScreenState extends State<ChangeNameScreen> {
  RxMap userDetails = {}.obs;

  TextEditingController firstName = TextEditingController();
  TextEditingController middleName = TextEditingController();
  TextEditingController lastName = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    userDetails.value = MoreScreenState.userDetails;
    List<String> name = userDetails['name'].toString().split(' ');
    if (name.isNotEmpty) {
      firstName.text = name[0];
    }
    if (name.length >= 2) {
      middleName.text = name[1];
    }
    if (name.length >= 3) {
      lastName.text = name[2];
    }

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
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Change Name',
              style: regularText18,
            ),
            height20,
            profileView(),
            height20,
            Text(
              'CHANGE FIRST NAME',
              style: regularText14,
            ),
            height10,
            TextFormFieldWidget(
              hintText: 'Change First Name',
              controller: firstName,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
              ],
              validator: (value) => Validators.validateText(
                value.toString(),
                'Change first name',
              ),
            ),
            height10,
            Text(
              'CHANGE MIDDLE NAME',
              style: regularText14,
            ),
            height10,
            TextFormFieldWidget(
              hintText: 'Change Middle Name',
              controller: middleName,
              maxLength: 1,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
              ],
              validator: (value) => Validators.validateText(
                value.toString(),
                'Change middle name',
              ),
            ),
            height20,
            Text(
              'CHANGE LAST NAME',
              style: regularText14,
            ),
            height10,
            TextFormFieldWidget(
              hintText: 'Change Last Name',
              controller: lastName,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
              ],
              validator: (value) => Validators.validateText(
                value.toString(),
                'Change last name',
              ),
            ),
            height20,
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary,
                  padding: const EdgeInsets.symmetric(horizontal: 40),
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
                  'EDIT NAME',
                  style: TextStyle(
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
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
                  ? networkImage(
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
              userDetails.isEmpty ? '' : userDetails['name'] ?? '',
              style: regularText18.copyWith(
                color: blackColor,
                letterSpacing: 0.3,
              ),
            ),
            height5,
            Text(
              'User Code : ${userDetails.isEmpty ? '' : userDetails['mce_number'] ?? ''}',
              style: lightText16,
            ),
            height5,
            Text(
              'Membership Type : ${userDetails.isEmpty ? '' : userDetails['price_group_name'] ?? ''}',
              style: lightText16,
            ),
            height5,
            Text(
              'Email : ${userDetails.isEmpty ? '' : userDetails['email'] ?? ''}',
              style: lightText16,
            ),
            height5,
            Text(
              'Phone : ${userDetails.isEmpty ? '' : userDetails['phone'] ?? ''}',
              style: lightText16,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> submitButton() async {
    final data = dio.FormData.fromMap({
      'firstname': firstName.text.trim(),
      'middlename': middleName.text.trim(),
      'lastname': lastName.text.trim(),
    });
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.editName,
      data: data,
      context: context,
    );
    if (response != null) {
      callInitState = false;
      Get.offAll(
        () => MainHomeScreen(
          selectedIndex: 5.obs,
        ),
      );
      NetworkDio.showSuccess(
          title: 'Success',
          sucessMessage: 'You have successfully change your name');
    }
  }
}
