import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cart_express/constant/sizedbox.dart';
import 'package:my_cart_express/screens/authentication/sign_up/sign_up_controller.dart';
import 'package:my_cart_express/theme/colors.dart';
import 'package:my_cart_express/theme/text_style.dart';
import 'package:my_cart_express/widget/app_bar_widget.dart';
import 'package:my_cart_express/widget/input_text_field.dart';
import 'package:my_cart_express/widget/validator.dart';

class SignUpScreen extends GetView {
  SignUpScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController emailId = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final TextEditingController branchName = TextEditingController();
  final TextEditingController type = TextEditingController();
  final TextEditingController businessName = TextEditingController();
  final TextEditingController businessContact = TextEditingController();
  final TextEditingController positionCompany = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: appbarWidget(title: 'Create Account'),
      body: GetBuilder<SignUpController>(
        init: SignUpController(),
        builder: (controller) => SingleChildScrollView(
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
                    validator: (value) =>
                        Validators.validatePassword(
                          value!.trim(),
                          'Confirm password',
                        ) ??
                        (value != password.text
                            ? 'Confirm Password does not match with password'
                            : null),
                  ),
                  height20,
                  TextFormFieldWidget(
                    labelText: 'Branch Name',
                    controller: branchName,
                    readOnly: true,
                    onTap: () {
                      selectBranch(context);
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
                    controller: type,
                    readOnly: true,
                    onTap: () {
                      selectType(
                        context,
                      );
                    },
                    suffixIcon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: primary,
                    ),
                    validator: (value) =>
                        Validators.validateText(value, 'Type'),
                  ),
                  height20,
                  Obx(
                    () => controller.type.value == 'Business Customer'
                        ? Column(
                            children: [
                              TextFormFieldWidget(
                                labelText: 'Business Name',
                                hintText: 'Business Name',
                                controller: businessName,
                                textInputAction: TextInputAction.next,
                                validator: (value) => Validators.validateText(
                                    value, 'Business Name'),
                              ),
                              height20,
                              TextFormFieldWidget(
                                labelText: 'Business Contact Person',
                                hintText: 'Business Contact Person',
                                controller: businessContact,
                                textInputAction: TextInputAction.next,
                                validator: (value) => Validators.validateText(
                                  value,
                                  'Business Contact Person',
                                ),
                              ),
                              height20,
                              TextFormFieldWidget(
                                labelText: 'Position In Company',
                                hintText: 'Position In Company',
                                controller: positionCompany,
                                textInputAction: TextInputAction.next,
                                validator: (value) => Validators.validateText(
                                  value,
                                  'Position In Company',
                                ),
                              ),
                              height20,
                            ],
                          )
                        : const SizedBox(),
                  ),
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
                        controller.signUpOnTap(
                          firstName: firstName.text,
                          lastName: lastName.text,
                          email: emailId.text,
                          password: password.text,
                          passwordConfirm: confirmPassword.text,
                          branchId: controller.branchId.value,
                          gid: controller.type.value == 'Business Customer'
                              ? '0'
                              : '1',
                          legalBusinessName: businessName.text,
                          businessContactPerson: businessContact.text,
                          positionInCompany: positionCompany.text,
                          context: context,
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
      ),
    );
  }

  void selectBranch(
    BuildContext context,
  ) {
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
                    branchName.text = controller.branchesList[value].parishname;
                    controller.branchId.value =
                        controller.branchesList[value].branchId;
                  },
                  children: List.generate(
                    controller.branchesList.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        controller.branchesList[index].parishname,
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

  void selectType(BuildContext context) {
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
                  looping: false,
                  onSelectedItemChanged: (int value) {
                    type.text = controller.typeList[value];
                  },
                  children: List.generate(
                    controller.typeList.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        controller.typeList[index],
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
                    controller.type.value = type.text;
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
