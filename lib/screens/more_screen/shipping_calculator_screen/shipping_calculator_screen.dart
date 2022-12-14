import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cart_express/constant/sizedbox.dart';
import 'package:my_cart_express/screens/more_screen/shipping_calculator_screen/calculator_controller.dart';
import 'package:my_cart_express/theme/colors.dart';
import 'package:my_cart_express/theme/text_style.dart';
import 'package:my_cart_express/widget/app_bar_widget.dart';
import 'package:my_cart_express/widget/input_text_field.dart';
import 'package:my_cart_express/widget/validator.dart';

class ShippingCalculatorScreen extends StatefulWidget {
  const ShippingCalculatorScreen({super.key});

  @override
  State<ShippingCalculatorScreen> createState() =>
      _ShippingCalculatorScreenState();
}

class _ShippingCalculatorScreenState extends State<ShippingCalculatorScreen> {
  final ShippingCalculatorController controller =
      Get.put(ShippingCalculatorController());

  @override
  void initState() {
    if (rateGroupList.isEmpty || categoriesList.isEmpty) {
      controller.getGropDetails(context);
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
                padding: const EdgeInsets.all(15),
                decoration: const BoxDecoration(
                  color: offWhite,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: bodyView(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget bodyView(context) {
    return Form(
      key: controller.formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Shipping Calculator',
              style: regularText18,
            ),
            height15,
            Container(
              width: Get.width,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: greyColor.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Estimate the cost of shipping your package',
                  ),
                  height15,
                  Text(
                    'Rate Group',
                    style: regularText14,
                  ),
                  height10,
                  TextFormFieldWidget(
                    hintText: 'Select Group',
                    controller: controller.rate,
                    readOnly: true,
                    onTap: () {
                      selectRateGroup(
                        context: context,
                      );
                    },
                    suffixIcon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: primary,
                    ),
                    validator: (value) =>
                        Validators.validateText(value, 'Rate'),
                  ),
                  height15,
                  Text(
                    'Category',
                    style: regularText14,
                  ),
                  height10,
                  TextFormFieldWidget(
                    hintText: 'Select Category',
                    controller: controller.category,
                    readOnly: true,
                    onTap: () {
                      selectCategoryGroup(context: context);
                    },
                    suffixIcon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: primary,
                    ),
                    validator: (value) =>
                        Validators.validateText(value, 'Category'),
                  ),
                  height15,
                  Text(
                    'Value (USD)',
                    style: regularText14,
                  ),
                  height10,
                  TextFormFieldWidget(
                    hintText: 'Total cost at check out',
                    controller: controller.value,
                    keyboardType: TextInputType.number,
                    validator: (value) =>
                        Validators.validateText(value, 'Value'),
                  ),
                  height15,
                  Text(
                    'Estimated weight (LBS)',
                    style: regularText14,
                  ),
                  height10,
                  TextFormFieldWidget(
                    hintText: 'Total cost at check out',
                    controller: controller.estimated,
                    keyboardType: TextInputType.number,
                    validator: (value) => Validators.validateText(
                      value,
                      'Estimated weight',
                    ),
                  ),
                  height15,
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          controller.rate.clear();
                          controller.category.clear();
                          controller.value.clear();
                          controller.estimated.clear();
                          controller.resultData.clear();
                        },
                        child: const Text(
                          'RESET',
                        ),
                      ),
                      width15,
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(success),
                        ),
                        onPressed: () {
                          if (controller.formKey.currentState!.validate()) {
                            controller.calculateData(context);
                          }
                        },
                        child: const Text(
                          'CALCULATE',
                        ),
                      ),
                    ],
                  ),
                  height15,
                  resultView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget resultView() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: greyColor.withOpacity(0.2),
            border: Border.all(
              color: offWhite,
            ),
          ),
          child: Row(
            children: [
              Text(
                'Estimated Total Due : ',
                style: regularText16.copyWith(
                  color: primary,
                ),
              ),
              const Spacer(),
              Obx(
                () => Text(
                  controller.resultData.isNotEmpty
                      ? controller.resultData['amount']
                      : '\$0.0',
                  style: regularText18.copyWith(
                    color: success,
                  ),
                ),
              ),
            ],
          ),
        ),
        height15,
        Row(
          children: [
            Text(
              ' Freight Charges : ',
              style: regularText14.copyWith(
                color: primary,
              ),
            ),
            Obx(
              () => Text(
                controller.resultData.isNotEmpty
                    ? controller.resultData['freight_cost']
                    : '\$0.0',
                style: regularText14,
              ),
            ),
          ],
        ),
        height5,
        Row(
          children: [
            Text(
              ' Local Charges : ',
              style: regularText14.copyWith(
                color: primary,
              ),
            ),
            Obx(
              () => Text(
                controller.resultData.isNotEmpty
                    ? controller.resultData['clearance_fee_jmd']
                    : '\$0.0',
                style: regularText14,
              ),
            ),
          ],
        ),
        height5,
        Row(
          children: [
            Text(
              ' Processing fee : ',
              style: regularText14.copyWith(
                color: primary,
              ),
            ),
            Obx(() => Text(
                  controller.resultData.isNotEmpty
                      ? controller.resultData['processing_fee']
                      : '\$0.0',
                  style: regularText14,
                )),
          ],
        ),
        height5,
        Row(
          children: [
            Text(
              ' Tax : ',
              style: regularText14.copyWith(
                color: primary,
              ),
            ),
            Obx(() => Text(
                  controller.resultData.isNotEmpty
                      ? controller.resultData['tax']
                      : '\$0.0',
                  style: regularText14,
                )),
          ],
        ),
        height15,
        Text(
          '*THE PRICES INDICATED ARE ESTIMATE & ARE SUBJECT CHARGE',
          style: regularText14.copyWith(
            letterSpacing: 0.2,
            color: error,
          ),
        ),
      ],
    );
  }

  void selectRateGroup({
    required BuildContext context,
  }) {
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
                  onSelectedItemChanged: (int i) {
                    controller.rate.text = rateGroupList[i]['grp_name'];
                    controller.rateId.value = categoriesList[i]['id'];
                  },
                  children: List.generate(
                    rateGroupList.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        rateGroupList[index]['grp_name'],
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

  void selectCategoryGroup({
    required BuildContext context,
  }) {
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
                  onSelectedItemChanged: (int i) {
                    controller.category.text = categoriesList[i]['cat_name'];
                    controller.catId.value = categoriesList[i]['id'];
                  },
                  children: List.generate(
                    categoriesList.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        categoriesList[index]['cat_name'],
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
