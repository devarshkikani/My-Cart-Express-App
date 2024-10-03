import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_cart_express/order_tracking_app/constant/app_endpoints.dart';
import 'package:my_cart_express/order_tracking_app/constant/default_images.dart';
import 'package:my_cart_express/order_tracking_app/constant/sizedbox.dart';
import 'package:my_cart_express/order_tracking_app/constant/storage_key.dart';
import 'package:my_cart_express/order_tracking_app/screens/home/main_home_screen.dart';
import 'package:my_cart_express/order_tracking_app/screens/home_screen/home_screen.dart';
import 'package:my_cart_express/order_tracking_app/screens/more_screen/more_screen.dart';
import 'package:my_cart_express/order_tracking_app/screens/not_verify/not_verify_screen.dart';
import 'package:my_cart_express/order_tracking_app/theme/colors.dart';
import 'package:my_cart_express/order_tracking_app/theme/text_style.dart';
import 'package:my_cart_express/order_tracking_app/utils/global_singleton.dart';
import 'package:my_cart_express/order_tracking_app/utils/network_dio.dart';
import 'package:my_cart_express/order_tracking_app/widget/app_bar_widget.dart';
import 'package:my_cart_express/order_tracking_app/widget/input_text_field.dart';
import 'package:my_cart_express/order_tracking_app/widget/network_image_handle.dart';
import 'package:my_cart_express/order_tracking_app/widget/validator.dart';

class ChangeEmailAddressScreen extends StatefulWidget {
  const ChangeEmailAddressScreen({super.key});

  @override
  State<ChangeEmailAddressScreen> createState() =>
      _ChangeEmailAddressScreenState();
}

class _ChangeEmailAddressScreenState extends State<ChangeEmailAddressScreen> {
  RxMap userDetails = {}.obs;
  GetStorage box = GetStorage();
  TextEditingController emailAddressController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    userDetails.value = MoreScreenState.userDetails;
    emailAddressController.text = userDetails['email'];
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
              'Change Email',
              style: regularText18,
            ),
            height20,
            profileView(),
            height20,
            Text(
              'CHANGE EMAIL ADDRESS',
              style: regularText14,
            ),
            height10,
            TextFormFieldWidget(
              hintText: 'Enter email address',
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              controller: emailAddressController,
              validator: (value) => Validators.validateEmail(value),
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
                  'EDIT EMAIL',
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
      'email': emailAddressController.text.trim(),
    });
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.editEmail,
      data: data,
      context: context,
    );
    if (response != null) {
      if (!context.mounted) return;
      await getUserDetails(context);
    }
  }

  Future<void> getUserDetails(BuildContext context) async {
    Map<String, dynamic>? response = await NetworkDio.getDioHttpMethod(
        url: ApiEndPoints.apiEndPoint + ApiEndPoints.userInfo,
        context: context);

    if (response != null) {
      GlobalSingleton.userDetails = response['data'];
      if (response['data']['verify_email'] == '0') {
        box.write(StorageKey.isRegister, false);
        Get.offAll(() => NotVerifyScreen(
              userDetails: response['data'],
            ));
      } else {
        box.write(StorageKey.isRegister, true);
        Get.offAll(
          () => MainHomeScreen(selectedIndex: 0.obs),
        );
      }
    }
  }
}
