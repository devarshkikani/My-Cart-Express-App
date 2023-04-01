import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cart_express/e_commerce_app/e_constant/e_divider.dart';
import 'package:my_cart_express/e_commerce_app/e_constant/e_sizedbox.dart';
import 'package:my_cart_express/e_commerce_app/e_controller/e_home/e_filter_screen_controller.dart';
import 'package:my_cart_express/e_commerce_app/e_theme/e_app_text_theme.dart';
import 'package:my_cart_express/e_commerce_app/e_widget/e_elevated_button.dart';

class EFilterScreen extends GetView<EFilterScreenController> {
  const EFilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Filter',
        ),
      ),
      body: SizedBox(
        height: Get.height,
        child: Column(
          children: <Widget>[
            dividers(0),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: <Widget>[
                      bodyView(context),
                    ],
                  ),
                ),
              ),
            ),
            height10,
            SizedBox(
              width: Get.width * 0.8,
              child: eElevatedButton(
                context: context,
                title: 'Apply Filter',
                onTap: () {
                  Get.back();
                },
              ),
            ),
            height15,
          ],
        ),
      ),
    );
  }

  Widget bodyView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Sort by',
          style: regularText12.copyWith(
              color: Theme.of(context).colorScheme.tertiary),
        ),
        height15,
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Obx(
                () => DropdownButton<String>(
                  icon: const Icon(Icons.keyboard_arrow_down_rounded),
                  underline: const SizedBox(),
                  value: controller.country.value == ''
                      ? null
                      : controller.country.value,
                  items: <String>[
                    'Brand',
                    'Prioce',
                    'Deals',
                    'Customer Review',
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
            ),
          ],
        ),
        height15,
        Text(
          'Category',
          style: regularText12.copyWith(
              color: Theme.of(context).colorScheme.tertiary),
        ),
        height15,
        Wrap(
          runSpacing: 10,
          spacing: 10,
          children: List<Widget>.generate(
            controller.categoryList.length,
            (int index) => Obx(
              () => GestureDetector(
                onTap: () {
                  if (controller.categorySelected
                      .contains(controller.categoryList[index])) {
                    controller.categorySelected
                        .remove(controller.categoryList[index]);
                  } else {
                    controller.categorySelected
                        .add(controller.categoryList[index]);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: controller.categorySelected
                            .contains(controller.categoryList[index])
                        ? Theme.of(context).colorScheme.primary
                        : Colors.transparent,
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        Icons.add_rounded,
                        size: 18,
                        color: controller.categorySelected
                                .contains(controller.categoryList[index])
                            ? Theme.of(context).colorScheme.background
                            : Theme.of(context).colorScheme.primary,
                      ),
                      width10,
                      Text(
                        controller.categoryList[index],
                        style: regularText14.copyWith(
                          color: controller.categorySelected
                                  .contains(controller.categoryList[index])
                              ? Theme.of(context).colorScheme.background
                              : Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
