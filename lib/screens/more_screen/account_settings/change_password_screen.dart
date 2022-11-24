import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cart_express/constant/default_images.dart';
import 'package:my_cart_express/constant/sizedbox.dart';
import 'package:my_cart_express/theme/colors.dart';
import 'package:my_cart_express/theme/text_style.dart';
import 'package:my_cart_express/widget/app_bar_widget.dart';
import 'package:my_cart_express/widget/input_text_field.dart';
import 'package:my_cart_express/widget/validator.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController changePassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController typeOldPassword = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Change Passoword',
            style: regularText18,
          ),
          height20,
          profileView(),
          height20,
          Text(
            'CHANGE PASSWORD',
            style: regularText14,
          ),
          height10,
          TextFormFieldWidget(
            hintText: 'Change Password',
            controller: changePassword,
            validator: (value) => Validators.validateText(
              value,
              'Change password',
            ),
          ),
          height15,
          Text(
            'CONFIRM PASSWORD',
            style: regularText14,
          ),
          height10,
          TextFormFieldWidget(
            hintText: 'Confirm Password',
            controller: changePassword,
            validator: (value) => Validators.validateText(
              value,
              'Confirm password',
            ),
          ),
          height15,
          Text(
            'TYPE OLD PASSWORD',
            style: regularText14,
          ),
          height10,
          TextFormFieldWidget(
            hintText: 'Type Old Password',
            controller: changePassword,
            validator: (value) => Validators.validateText(
              value,
              'Type old password',
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
              onPressed: () {
                if (_formKey.currentState!.validate()) {}
              },
              child: const Text(
                'SAVE PASSWORD',
                style: TextStyle(
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget profileView() {
    return Center(
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              dummyProfileImage,
              height: 100,
              width: 100,
            ),
          ),
          height20,
          Text(
            'KAMAR PALMER',
            style: regularText18.copyWith(
              color: blackColor,
              letterSpacing: 0.3,
            ),
          ),
          height5,
          Text(
            'User Code : STF000002',
            style: lightText16,
          ),
          height5,
          Text(
            'Email : mkamar@mycartexpress.com',
            style: lightText16,
          ),
          height5,
          Text(
            'Phone : ',
            style: lightText16,
          ),
        ],
      ),
    );
  }
}
