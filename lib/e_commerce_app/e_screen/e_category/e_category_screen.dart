import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cart_express/e_commerce_app/e_constant/e_divider.dart';
import 'package:my_cart_express/e_commerce_app/e_constant/e_sizedbox.dart';
import 'package:my_cart_express/e_commerce_app/e_controller/e_category/e_category_screen_controller.dart';
import 'package:my_cart_express/e_commerce_app/e_controller/e_theme_controller.dart';
import 'package:my_cart_express/e_commerce_app/e_theme/e_app_colors.dart';

class ECategoryScreen extends StatelessWidget {
  const ECategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'All Categories',
        ),
      ),
      body: SizedBox(
        height: Get.height,
        child: GetBuilder<ECategoryScreenController>(
          init: ECategoryScreenController(),
          builder: (ECategoryScreenController _) {
            return Column(
              children: <Widget>[
                dividers(0),
                Expanded(
                  child: SingleChildScrollView(
                    child: GridView.count(
                      crossAxisCount: 3,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 8,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(15),
                      children: List<Widget>.generate(
                        _.categoryList.length,
                        (int index) {
                          return Container(
                            decoration: BoxDecoration(
                              color:
                                  Get.find<ThemeController>().isDarkTheme.value
                                      ? Theme.of(context)
                                          .colorScheme
                                          .tertiary
                                          .withOpacity(0.5)
                                      : Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withOpacity(0.15),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: InkWell(
                              onTap: () {},
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    height: 50,
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.asset(
                                      _.categoryList[index]['image'] as String,
                                      color: whiteColor,
                                    ),
                                  ),
                                  height15,
                                  Text(
                                      _.categoryList[index]['title'] as String),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
