import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:my_cart_express/e_commerce_app/e_constant/e_default_image.dart';
import 'package:my_cart_express/e_commerce_app/e_constant/e_divider.dart';
import 'package:my_cart_express/e_commerce_app/e_constant/e_sizedbox.dart';
import 'package:my_cart_express/e_commerce_app/e_controller/e_theme_controller.dart';
import 'package:my_cart_express/e_commerce_app/e_theme/e_app_text_theme.dart';
import 'package:my_cart_express/e_commerce_app/e_widget/e_elevated_button.dart';
import 'package:my_cart_express/e_commerce_app/e_controller/e_payment/e_add_new_card_screen_controller.dart';
import 'package:my_cart_express/e_commerce_app/e_widget/e_input_text_field.dart';
import 'package:my_cart_express/e_commerce_app/e_widget/e_validator.dart';

class EAddNewCardScreen extends GetView<EAddNewCardScreenController> {
  const EAddNewCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Add New Card',
        ),
      ),
      body: SizedBox(
        height: Get.height,
        child: Column(
          children: <Widget>[
            dividers(0),
            Expanded(
              child: SingleChildScrollView(
                child: bodyView(context),
              ),
            ),
            height10,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                  width: Get.width * 0.45,
                  child: eElevatedButton(
                    context: context,
                    title: 'Back',
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    onTap: () {
                      Get.back();
                    },
                  ),
                ),
                SizedBox(
                  width: Get.width * 0.45,
                  child: eElevatedButton(
                    context: context,
                    title: 'Continue',
                    onTap: () {
                      if (controller.formKey.currentState!.validate()) {
                        Get.back();
                      }
                    },
                  ),
                ),
              ],
            ),
            height15,
          ],
        ),
      ),
    );
  }

  Widget bodyView(BuildContext context) {
    return Container(
      width: Get.width,
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Get.find<ThemeController>().isDarkTheme.value
            ? Theme.of(context).colorScheme.tertiary.withOpacity(0.5)
            : Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(10),
        boxShadow: Get.find<ThemeController>().isDarkTheme.value
            ? <BoxShadow>[]
            : <BoxShadow>[
                BoxShadow(
                  color:
                      Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 1,
                  offset: const Offset(0, 5),
                ),
              ],
      ),
      child: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Image.asset(
                creditCardIcon,
                height: 200,
              ),
            ),
            height30,
            Text(
              'Card Number',
              style: lightText16.copyWith(),
            ),
            height5,
            TextFormFieldWidget(
              controller: controller.cardNumber,
              validator: (String? value) =>
                  Validators.validateText(value, 'Card Number'),
            ),
            height15,
            Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Valid Until',
                        style: lightText16.copyWith(),
                      ),
                      height5,
                      TextFormFieldWidget(
                        controller: controller.cardNumber,
                        validator: (String? value) =>
                            Validators.validateText(value, 'Valid Until'),
                      ),
                    ],
                  ),
                ),
                width10,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'CVV',
                        style: lightText16.copyWith(),
                      ),
                      height5,
                      TextFormFieldWidget(
                        controller: controller.cardNumber,
                        validator: (String? value) =>
                            Validators.validateText(value, 'CVV'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            height15,
            Text(
              'Card Holder Name',
              style: lightText16.copyWith(),
            ),
            height5,
            TextFormFieldWidget(
              controller: controller.cardNumber,
              validator: (String? value) =>
                  Validators.validateText(value, 'Card holder name'),
            ),
            height15,
            Row(
              children: <Widget>[
                Obx(() => Checkbox(
                      value: controller.isSaved.value,
                      onChanged: (bool? value) {
                        controller.isSaved.value = value ?? false;
                      },
                    )),
                const Text(
                  'Save card data for future payments',
                  style: lightText14,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
