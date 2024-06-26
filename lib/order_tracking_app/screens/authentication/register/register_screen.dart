import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/formatters/phone_input_formatter.dart';
import 'package:get/get.dart';
import 'package:my_cart_express/order_tracking_app/constant/sizedbox.dart';
import 'package:my_cart_express/order_tracking_app/screens/authentication/login/login_screen.dart';
import 'package:my_cart_express/order_tracking_app/screens/authentication/register/register_controller.dart';
import 'package:my_cart_express/order_tracking_app/theme/colors.dart';
import 'package:my_cart_express/order_tracking_app/theme/text_style.dart';
import 'package:my_cart_express/order_tracking_app/widget/app_bar_widget.dart';
import 'package:my_cart_express/order_tracking_app/widget/input_text_field.dart';
import 'package:my_cart_express/order_tracking_app/widget/validator.dart';
import 'package:url_launcher/url_launcher.dart';

class RegisterScreen extends GetView<RegisterController> {
  RegisterScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    controller.getBranches(context);
    controller.setupSettings();
    return Scaffold(
      backgroundColor: background,
      appBar: appbarWidget(title: 'Create Account'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    "Thousands of happy customers are using MyCart Express to elevate their shipping experience. Let's make you one.",
                    style: lightText16,
                  ),
                  height20,
                  TextFormFieldWidget(
                    labelText: 'First Name',
                    hintText: 'Enter first name here',
                    controller: controller.firstName,
                    textInputAction: TextInputAction.next,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
                    ],
                    validator: (value) =>
                        Validators.validateText(value, 'First Name'),
                  ),
                  height20,
                  TextFormFieldWidget(
                    labelText: 'Middle initial',
                    hintText: 'Enter middle name here',
                    controller: controller.middleName,
                    maxLength: 1,
                    textInputAction: TextInputAction.next,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
                    ],
                    validator: (value) =>
                        Validators.validateText(value, 'Middle Name'),
                  ),
                  height20,
                  TextFormFieldWidget(
                    labelText: 'Last Name',
                    hintText: 'Enter last name here',
                    controller: controller.lastName,
                    textInputAction: TextInputAction.next,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
                    ],
                    validator: (value) =>
                        Validators.validateText(value, 'Last Name'),
                  ),
                  height20,
                  EmailWidget(
                    labelText: 'Email Address',
                    hintText: 'Enter email here',
                    textInputAction: TextInputAction.next,
                    controller: controller.emailId,
                  ),
                  height20,
                  TextFormFieldWidget(
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
                    controller: controller.phoneNumber,
                    validator: (value) =>
                        Validators.validateText(value, 'Phone Number'),
                    inputFormatters: [
                      PhoneInputFormatter(
                        defaultCountryCode: 'US',
                        allowEndlessPhone: true,
                      )
                    ],
                  ),
                  height20,
                  TextFormFieldWidget(
                    labelText: 'How did you find out about us?',
                    controller: controller.howFindAboutUsId,
                    readOnly: true,
                    onTap: () {
                      findAboutUs(context, controller);
                    },
                    suffixIcon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: primary,
                    ),
                    validator: (value) =>
                        Validators.validateText(value, 'How find about us?'),
                  ),
                  height20,
                  TextFormFieldWidget(
                    labelText: 'About Me',
                    controller: controller.aboutme,
                    readOnly: true,
                    onTap: () {
                      selectAboutme(context, Get.find<RegisterController>());
                    },
                    suffixIcon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: primary,
                    ),
                    validator: (value) =>
                        Validators.validateText(value, 'About Me'),
                  ),
                  height20,
                  TextFormFieldWidget(
                    labelText: 'Where are you located?',
                    controller: controller.location,
                    readOnly: true,
                    onTap: () {
                      selectLocation(context, controller);
                    },
                    suffixIcon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: primary,
                    ),
                    validator: (value) =>
                        Validators.validateText(value, 'Location'),
                  ),
                  height20,
                  TextFormFieldWidget(
                    labelText: 'Preferred Branch',
                    controller: controller.branchName,
                    readOnly: true,
                    onTap: () {
                      selectBranch(context, controller);
                    },
                    suffixIcon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: primary,
                    ),
                    validator: (value) =>
                        Validators.validateText(value, 'Preferred Branch'),
                    // ),
                    // if (GlobalSingleton.inviteUserId != null) height20,
                    // if (GlobalSingleton.inviteUserId != null)
                    //   TextFormFieldWidget(
                    //     labelText: 'Reffral Id',
                    //     // controller: controller.branchName,
                    //     controller: TextEditingController(
                    //         text: GlobalSingleton.inviteUserId),
                    //     readOnly: true,
                    //     onTap: () {},
                    //     // suffixIcon: const Icon(
                    //     //   Icons.keyboard_arrow_down_rounded,
                    //     //   color: primary,
                    //     // ),
                    //     validator: (value) =>
                    //         Validators.validateText(value, 'Reffral Id'),
                  ),
                  height20,
                  PasswordWidget(
                    labelText: 'Password',
                    passType: 'Password',
                    hintText: 'Enter password here',
                    controller: controller.password,
                    textInputAction: TextInputAction.next,
                    showsuffixIcon: true,
                  ),
                  height20,
                  PasswordWidget(
                    labelText: 'Confirm Password',
                    passType: 'Confirm Password',
                    hintText: 'Enter confirm password here',
                    textInputAction: TextInputAction.next,
                    controller: controller.confirmPassword,
                    showsuffixIcon: true,
                    validator: (value) =>
                        Validators.validatePassword(
                          value!.trim(),
                          'Confirm password',
                        ) ??
                        (value != controller.password.text
                            ? 'Confirm Password does not match with password'
                            : null),
                  ),
                  height20,
                  Row(
                    children: [
                      Obx(
                        () => Checkbox(
                          value: controller.termsAndService.value,
                          activeColor: primary,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          onChanged: (bool? value) {
                            controller.termsAndService.value = value ?? false;
                          },
                        ),
                      ),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "I agree to MyCart Quick Limited's ",
                                style: lightText14,
                              ),
                              TextSpan(
                                text: 'Terms of services.',
                                style: regularText14.copyWith(
                                  color: primary,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    launchUrl(
                                      Uri.parse(
                                          'https://app.mycartexpress.com/terms-condition'),
                                    );
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Obx(
                        () => Checkbox(
                          value: controller.privacyPolicy.value,
                          activeColor: primary,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          onChanged: (bool? value) {
                            controller.privacyPolicy.value = value ?? false;
                          },
                        ),
                      ),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "I agree to MyCart Quick Limited's ",
                                style: lightText14,
                              ),
                              TextSpan(
                                text: 'Privacy Policy.',
                                style: regularText14.copyWith(
                                  color: primary,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    launchUrl(
                                      Uri.parse(
                                          'https://app.mycartexpress.com/privacy-policy'),
                                    );
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  height20,
                  // Column(
                  //   children: [
                  //     TextFormFieldWidget(
                  //       labelText: 'Business Name',
                  //       hintText: 'Business Name',
                  //       controller: controller.businessName,
                  //       textInputAction: TextInputAction.next,
                  //       validator: (value) =>
                  //           Validators.validateText(value, 'Business Name'),
                  //     ),
                  //     height20,
                  //     TextFormFieldWidget(
                  //       labelText: 'Business Contact Person',
                  //       hintText: 'Business Contact Person',
                  //       controller: controller.businessContact,
                  //       textInputAction: TextInputAction.next,
                  //       validator: (value) => Validators.validateText(
                  //         value,
                  //         'Business Contact Person',
                  //       ),
                  //     ),
                  //     height20,
                  //     TextFormFieldWidget(
                  //       labelText: 'Position In Company',
                  //       hintText: 'Position In Company',
                  //       controller: controller.positionCompany,
                  //       textInputAction: TextInputAction.next,
                  //       validator: (value) => Validators.validateText(
                  //         value,
                  //         'Position In Company',
                  //       ),
                  //     ),
                  //     height20,
                  //   ],
                  // ),

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
                      if (_formKey.currentState!.validate() &&
                          controller.termsAndService.value &&
                          controller.privacyPolicy.value) {
                        controller.signUpOnTap(
                          context: context,
                        );
                      }
                    },
                    child: const Text(
                      'REGISTER ACCOUNT',
                      style: TextStyle(
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  height20,
                  Center(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Already have an account? ",
                            style: lightText14,
                          ),
                          TextSpan(
                            text: 'Login',
                            style: regularText14.copyWith(
                              color: primary,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.to(
                                  () => LoginScreen(),
                                );
                              },
                          ),
                        ],
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

  void selectLocation(
    BuildContext context,
    RegisterController controller,
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
                    controller.locatedIndex.value = value;
                  },
                  children: List.generate(
                    controller.locationList.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        controller.locationList[index]['parish_name'],
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
                    controller.location.text =
                        controller.locationList[controller.locatedIndex.value]
                            ['parish_name'];

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

  void findAboutUs(
    BuildContext context,
    RegisterController controller,
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
                    controller.aboutUSIndex.value = value;
                    controller.howFindAboutUsId.text =
                        controller.howFindAboutUsIdList[value]['label_text'];
                  },
                  children: List.generate(
                    controller.howFindAboutUsIdList.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        controller.howFindAboutUsIdList[index]['label_text'],
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
                    controller.location.text =
                        controller.locationList[controller.locatedIndex.value]
                            ['parish_name'];
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

  void selectBranch(
    BuildContext context,
    RegisterController controller,
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
                  magnification: 1.20,
                  squeeze: 1.2,
                  useMagnifier: true,
                  looping: true,
                  onSelectedItemChanged: (int value) {
                    controller.branchIndex.value = value;
                  },
                  children: List.generate(
                    controller.branchesList.length,
                    (index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Column(
                          children: [
                            Text(
                              '${controller.branchesList[index].parishname} - ${controller.branchesList[index].code}',
                              style: mediumText14.copyWith(
                                color: primary,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
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
                    controller.branchName.text =
                        '${controller.branchesList[controller.branchIndex.value].parishname} - ${controller.branchesList[controller.branchIndex.value].code}';
                    controller.branchId.value = controller
                            .branchesList[controller.branchIndex.value]
                            .branchId ??
                        '0';
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

  void selectAboutme(
    BuildContext context,
    RegisterController controller,
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
                  looping: false,
                  onSelectedItemChanged: (int value) {
                    controller.aboutMeIndex.value = value;
                  },
                  children: List.generate(
                    controller.aboutMeList.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        controller.aboutMeList[index],
                        style: mediumText16.copyWith(
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
                    controller.aboutme.text =
                        controller.aboutMeList[controller.aboutMeIndex.value];

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
