import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cart_express/e_commerce_app/e_constant/e_sizedbox.dart';
import 'package:my_cart_express/e_commerce_app/e_controller/e_home/e_search_screen_controller.dart';
import 'package:my_cart_express/e_commerce_app/e_routes/e_app_pages.dart';
import 'package:my_cart_express/e_commerce_app/e_theme/e_app_text_theme.dart';
import 'package:my_cart_express/e_commerce_app/e_widget/e_input_text_field.dart';
import 'package:my_cart_express/e_commerce_app/e_widget/e_small_product_view.dart';

class ESearchScreen extends GetView<ESearchScreenController> {
  const ESearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: Get.height,
        child: Column(
          children: <Widget>[
            topView(context),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    height15,
                    bodyView(context),
                  ],
                ),
              ),
            ),
            height15,
          ],
        ),
      ),
    );
  }

  Widget topView(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
        ),
      ),
      child: SafeArea(
        child: SizedBox(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    width15,
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(
                        Platform.isIOS
                            ? Icons.arrow_back_ios_rounded
                            : Icons.arrow_back_rounded,
                        color: Theme.of(context).colorScheme.background,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Search',
                        textAlign: TextAlign.center,
                        style: lightText18.copyWith(
                          fontSize: 24,
                          color: Theme.of(context).colorScheme.background,
                        ),
                      ),
                    ),
                    width25,
                  ],
                ),
                height10,
                Row(
                  children: <Widget>[
                    width15,
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(ERoutes.filter);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).colorScheme.background,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.filter_alt_outlined,
                              color: Theme.of(context).colorScheme.background,
                            ),
                            width5,
                            Text(
                              'Filter',
                              style: lightText16.copyWith(
                                color: Theme.of(context).colorScheme.background,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    width10,
                    Expanded(
                      child: TextFormFieldWidget(
                        filledColor: Theme.of(context).colorScheme.background,
                        hintText: 'Search',
                        prefixIcon: const Icon(Icons.search),
                        border: const BorderSide(
                          color: Colors.transparent,
                        ),
                        focusBorder: const BorderSide(
                          color: Colors.transparent,
                        ),
                        enabledBorder: const BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                    width15,
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget bodyView(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      crossAxisCount: 2,
      childAspectRatio: 0.7,
      physics: const NeverScrollableScrollPhysics(),
      children: List<Widget>.generate(
        controller.productList.length,
        (int index) => ESmallProductView(
          width: Get.width * 0.4,
          data: controller.productList[index],
          onTap: () {
            Get.toNamed(ERoutes.productDetails);
          },
        ),
      ),
    );
  }
}
