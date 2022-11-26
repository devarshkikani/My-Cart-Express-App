import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cart_express/constant/sizedbox.dart';
import 'package:my_cart_express/screens/authentication/sign_up/sign_up_controller.dart';
import 'package:my_cart_express/screens/home/main_home_screen.dart';
import 'package:my_cart_express/theme/colors.dart';
import 'package:my_cart_express/theme/text_style.dart';
import 'package:my_cart_express/widget/app_bar_widget.dart';
import 'package:my_cart_express/widget/input_text_field.dart';
import 'package:my_cart_express/widget/validator.dart';

class SignUpScreen extends GetView<SignUpController> {
  SignUpScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController firstName = TextEditingController();

  final TextEditingController lastName = TextEditingController();

  final TextEditingController emailId = TextEditingController();

  final TextEditingController password = TextEditingController();

  final TextEditingController confirmPassword = TextEditingController();

  final TextEditingController branchName = TextEditingController();

  final TextEditingController type = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: appbarWidget(title: 'Create Account'),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                height10,
                TextFormFieldWidget(
                  labelText: 'First Name',
                  hintText: 'Enter first name here',
                  controller: firstName,
                  textInputAction: TextInputAction.next,
                  validator: (value) =>
                      Validators.validateText(value, 'First Name'),
                ),
                height20,
                TextFormFieldWidget(
                  labelText: 'Last Name',
                  hintText: 'Enter last name here',
                  controller: lastName,
                  textInputAction: TextInputAction.next,
                  validator: (value) =>
                      Validators.validateText(value, 'Last Name'),
                ),
                height20,
                EmailWidget(
                  labelText: 'Email Address',
                  hintText: 'Enter email here',
                  textInputAction: TextInputAction.next,
                  controller: emailId,
                ),
                height20,
                PasswordWidget(
                  labelText: 'Password',
                  passType: 'Password',
                  hintText: 'Enter password here',
                  controller: password,
                  textInputAction: TextInputAction.next,
                  showsuffixIcon: true,
                ),
                height20,
                PasswordWidget(
                  labelText: 'Confirm Password',
                  passType: 'Confirm Password',
                  hintText: 'Enter confirm password here',
                  textInputAction: TextInputAction.next,
                  controller: confirmPassword,
                  showsuffixIcon: true,
                ),
                height20,
                TextFormFieldWidget(
                  labelText: 'Branch Name',
                  controller: branchName,
                  readOnly: true,
                  onTap: () {
                    showBottomSheet(context);
                  },
                  suffixIcon: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: primary,
                  ),
                  validator: (value) =>
                      Validators.validateText(value, 'Branch Name'),
                ),
                height20,
                TextFormFieldWidget(
                  labelText: 'Type',
                  controller: branchName,
                  readOnly: true,
                  onTap: () {
                    showBottomSheet(context);
                  },
                  suffixIcon: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: primary,
                  ),
                  validator: (value) => Validators.validateText(value, 'Type'),
                ),
                height20,
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    maximumSize: Size(Get.width, 50),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Get.offAll(
                        () => MainHomeScreen(),
                      );
                    }
                  },
                  child: const Text(
                    'CREATE',
                    style: TextStyle(
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
                  onSelectedItemChanged: (int value) {
                    branchName.text = 'Hello';
                  },
                  children: List.generate(
                    10,
                    (index) => Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        'Hello',
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
