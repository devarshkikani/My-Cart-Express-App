import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:my_cart_express/order_tracking_app/constant/app_endpoints.dart';
import 'package:my_cart_express/order_tracking_app/constant/default_images.dart';
import 'package:my_cart_express/order_tracking_app/constant/sizedbox.dart';
import 'package:my_cart_express/order_tracking_app/screens/home/main_home_screen.dart';
import 'package:my_cart_express/order_tracking_app/screens/more_screen/more_screen.dart';
import 'package:my_cart_express/order_tracking_app/theme/colors.dart';
import 'package:my_cart_express/order_tracking_app/theme/text_style.dart';
import 'package:my_cart_express/order_tracking_app/utils/network_dio.dart';
import 'package:my_cart_express/order_tracking_app/widget/app_bar_widget.dart';
import 'package:my_cart_express/order_tracking_app/widget/input_text_field.dart';
import 'package:my_cart_express/order_tracking_app/widget/validator.dart';

class ChangeNumberScreen extends StatefulWidget {
  const ChangeNumberScreen({super.key});

  @override
  State<ChangeNumberScreen> createState() => _ChangeNumberScreenState();
}

class _ChangeNumberScreenState extends State<ChangeNumberScreen> {
  RxMap userDetails = {}.obs;

  TextEditingController phoneNumber = TextEditingController();
  RxBool isEditing = false.obs;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    userDetails.value = MoreScreenState.userDetails;
    phoneNumber.text = userDetails['phone'];
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
              'Change Number',
              style: regularText18,
            ),
            height20,
            profileView(),
            height20,
            Text(
              'CHANGE PHONE NUMBER',
              style: regularText14,
            ),
            height10,
            Obx(
              () => TextFormFieldWidget(
                enabled: isEditing.value,
                prefixIcon: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '+1',
                      style: regularText16,
                    ),
                  ],
                ),
                prefixIconConstraints: const BoxConstraints(
                  minWidth: 24,
                ),
                maxLength: 14,
                labelText: 'Phone Number',
                hintText: 'Enter phone number',
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                controller: phoneNumber,
                validator: (value) =>
                    Validators.validateText(value, 'Phone Number'),
                inputFormatters: [
                  PhoneInputFormatter(
                    defaultCountryCode: 'US',
                    allowEndlessPhone: true,
                  )
                ],
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
                  if (isEditing.value) {
                    if (_formKey.currentState!.validate()) {
                      await submitButton();
                    }
                  } else {
                    isEditing.value = true;
                  }
                },
                child: Obx(() => Text(
                      isEditing.value ? 'SAVE NUMBER' : 'EDIT NAME',
                      style: const TextStyle(
                        letterSpacing: 0.5,
                      ),
                    )),
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
      'phone': phoneNumber.text.trim(),
    });
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.editPhone,
      data: data,
      context: context,
    );
    if (response != null) {
      Get.offAll(
        () => MainHomeScreen(
          selectedIndex: 5.obs,
        ),
      );
      NetworkDio.showSuccess(
          title: 'Success',
          sucessMessage: 'You have successfully change your phone number');
    }
  }
}
