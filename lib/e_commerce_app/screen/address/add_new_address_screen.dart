import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cart_express/e_commerce_app/constant/default_image.dart';
import 'package:my_cart_express/e_commerce_app/constant/divider.dart';
import 'package:my_cart_express/e_commerce_app/constant/sizedbox.dart';
import 'package:my_cart_express/e_commerce_app/controller/address/add_new_address_controller.dart';
import 'package:my_cart_express/e_commerce_app/controller/theme_controller.dart';
import 'package:my_cart_express/e_commerce_app/theme/app_text_theme.dart';
import 'package:my_cart_express/e_commerce_app/widget/elevated_button.dart';
import 'package:my_cart_express/e_commerce_app/widget/validator.dart';

class AddNewAddressScreen extends GetView<AddNewAddressController> {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Add New Address',
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
                  child: elevatedButton(
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
                  child: elevatedButton(
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
                location,
                height: 200,
              ),
            ),
            Text(
              'Address',
              style: lightText16.copyWith(),
            ),
            TextFormField(
              controller: controller.homeOffice,
              decoration: const InputDecoration(
                hintText: 'Enter home/office address',
              ),
              validator: (String? value) => Validators.validateText(
                value,
                'Home/Office address',
              ),
            ),
            height15,
            Text(
              'City',
              style: lightText16.copyWith(),
            ),
            TextFormField(
              controller: controller.city,
              decoration: const InputDecoration(
                hintText: 'Enter City',
              ),
              validator: (String? value) =>
                  Validators.validateText(value, 'City name'),
            ),
            height15,
            Text(
              'Country',
              style: lightText16.copyWith(),
            ),
            Obx(
              () => DropdownButton<String>(
                isExpanded: true,
                hint: const Text('Select Country'),
                icon: const Icon(Icons.keyboard_arrow_down_rounded),
                value: controller.country.value == ''
                    ? null
                    : controller.country.value,
                items: <String>[
                  'United States',
                  'Australia',
                  'India',
                  'United Kingdom'
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? _) {
                  controller.country.value = _ ?? '';
                },
              ),
            ),
            height15,
            Text(
              'Zip Code',
              style: lightText16.copyWith(),
            ),
            TextFormField(
              controller: controller.zip,
              decoration: const InputDecoration(
                hintText: 'Enter Zip Code',
              ),
              validator: (String? value) =>
                  Validators.validateText(value, 'Zip code'),
            ),
            height15,
            Row(
              children: <Widget>[
                width30,
                Obx(() => Checkbox(
                      value: controller.isHome.value,
                      onChanged: (bool? value) {
                        controller.isHome.value = value ?? false;
                        controller.isOffice.value = false;
                      },
                    )),
                const Text(
                  'Home',
                  style: lightText14,
                ),
                width30,
                Obx(() => Checkbox(
                      value: controller.isOffice.value,
                      onChanged: (bool? value) {
                        controller.isOffice.value = value ?? false;
                        controller.isHome.value = false;
                      },
                    )),
                const Text(
                  'Office',
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
