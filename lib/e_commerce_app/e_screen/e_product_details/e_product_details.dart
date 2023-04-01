// ignore_for_file: always_specify_types

import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:my_cart_express/e_commerce_app/e_constant/e_divider.dart';
import 'package:my_cart_express/e_commerce_app/e_constant/e_sizedbox.dart';
import 'package:my_cart_express/e_commerce_app/e_controller/e_product_details/e_product_details_screen_controller.dart';
import 'package:my_cart_express/e_commerce_app/e_controller/e_theme_controller.dart';
import 'package:my_cart_express/e_commerce_app/e_theme/e_app_colors.dart';
import 'package:my_cart_express/e_commerce_app/e_theme/e_app_text_theme.dart';
import 'package:my_cart_express/e_commerce_app/e_widget/e_elevated_button.dart';

class EProductDetailsScreen extends GetView<EProductDetailsController> {
  const EProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Product Details',
        ),
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Platform.isIOS
                ? Icons.arrow_back_ios_new_rounded
                : Icons.arrow_back_rounded,
          ),
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
                      topView(context),
                      height20,
                      productDetailsView(context),
                      height20,
                      ratingsAndReviews(context),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: <Widget>[
                  InkWell(
                    onTap: () {},
                    child: Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.2),
                      ),
                      child: Icon(
                        Icons.favorite_border_rounded,
                        size: 28,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  width10,
                  Expanded(
                    child: eElevatedButton(
                      context: context,
                      title: 'Add to cart',
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget topView(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          silderView(context),
          height10,
          const Text(
            'Nike shoe for men',
            style: regularText14,
            overflow: TextOverflow.ellipsis,
          ),
          height5,
          Row(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: Row(
                  children: <Widget>[
                    width5,
                    Text(
                      '5.0 ',
                      style: regularText14.copyWith(
                        color: whiteColor,
                      ),
                    ),
                    const Icon(
                      Icons.star,
                      color: whiteColor,
                      size: 18,
                    ),
                    width5,
                  ],
                ),
              ),
              width10,
              Text(
                '96 ratings',
                style: regularText12.copyWith(
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: InkWell(
                  onTap: () {
                    Share.share('Nike shoe for men');
                  },
                  child: Icon(
                    Icons.share,
                    size: 18,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
          height5,
          Row(
            children: <Widget>[
              const Text(
                '\$6',
                style: regularText16,
              ),
              width5,
              Text.rich(
                TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: '''\$11''',
                      style: lightText12.copyWith(
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    TextSpan(
                      text: '''  5% off''',
                      style: lightText12.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          height15,
        ],
      ),
    );
  }

  Widget silderView(
    BuildContext context,
  ) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 250,
          width: Get.width,
          child: CarouselSlider(
            carouselController: controller.carouselController,
            options: CarouselOptions(
              autoPlay: true,
              viewportFraction: 1,
              enlargeCenterPage: true,
              onPageChanged: (int index, CarouselPageChangedReason reason) {
                controller.sliderValue.value = index;
              },
            ),
            disableGesture: true,
            items: controller.imgList
                .map(
                  (String item) => Container(
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.5),
                    child: SizedBox(
                      width: Get.width,
                      child: Image.network(
                        item,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: controller.imgList
              .asMap()
              .entries
              .map((MapEntry<int, String> entry) {
            return GestureDetector(
              onTap: () =>
                  controller.carouselController.animateToPage(entry.key),
              child: Obx(
                () => Container(
                  width: 8,
                  height: 8,
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: controller.sliderValue.value == entry.key
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.tertiary,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget productDetailsView(BuildContext context) {
    return Container(
      width: Get.width,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Products Details',
            style: regularText16,
          ),
          height10,
          profileDetailsTile(
            context: context,
            key: 'Brand',
            details: 'ABC brand',
          ),
          height5,
          profileDetailsTile(
            context: context,
            key: 'Type',
            details: 'Mobile & Accessories',
          ),
          height5,
          profileDetailsTile(
            context: context,
            key: 'Weight',
            details: '382 gram',
          ),
          height5,
          profileDetailsTile(
            context: context,
            key: 'OS',
            details: 'Android 11',
          ),
        ],
      ),
    );
  }

  Widget profileDetailsTile({
    required BuildContext context,
    required String key,
    required String details,
  }) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            key,
            style: lightText12.copyWith(
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
        ),
        Expanded(
          child: Text(
            details,
            style: lightText12,
          ),
        ),
      ],
    );
  }

  Widget ratingsAndReviews(BuildContext context) {
    return Container(
      width: Get.width,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Ratings and reviews',
            style: regularText16,
          ),
          height10,
          rowSliderDecoration(context, 5, 50),
          rowSliderDecoration(context, 4, 40),
          rowSliderDecoration(context, 3, 30),
          rowSliderDecoration(context, 2, 20),
          rowSliderDecoration(context, 1, 10),
          height20,
          Column(
            children: List<Widget>.generate(
              controller.reviews.length,
              (int index) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        controller.reviews[index]['name'] as String,
                      ),
                      width5,
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        child: Row(
                          children: <Widget>[
                            width5,
                            Text(
                              controller.reviews[index]['rating'] as String,
                              style: regularText12.copyWith(
                                color: whiteColor,
                              ),
                            ),
                            const Icon(
                              Icons.star,
                              color: whiteColor,
                              size: 12,
                            ),
                            width5,
                          ],
                        ),
                      ),
                      const Spacer(),
                      Text(
                        controller.reviews[index]['date'] as String,
                        style: lightText12.copyWith(
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                    ],
                  ),
                  height10,
                  Text(
                    controller.reviews[index]['review'] as String,
                    style: lightText13,
                  ),
                  if ((index + 1) < controller.reviews.length) dividers(10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget rowSliderDecoration(BuildContext context, int count, double value) {
    return Row(
      children: <Widget>[
        Text(
          '$count',
          style: lightText12,
        ),
        width5,
        const Icon(
          Icons.star,
          size: 18,
          color: Colors.amber,
        ),
        width5,
        Expanded(
          child: FlutterSlider(
            values: <double>[value],
            max: 100,
            min: 0,
            handlerHeight: 10,
            visibleTouchArea: false,
            disabled: true,
            tooltip: FlutterSliderTooltip(
              direction: FlutterSliderTooltipDirection.right,
              disabled: true,
            ),
            trackBar: FlutterSliderTrackBar(
              activeTrackBarHeight: 5,
              inactiveTrackBarHeight: 5,
              activeDisabledTrackBarColor:
                  Theme.of(context).colorScheme.primary,
              activeTrackBar: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
              ),
              inactiveTrackBar: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            onDragging: (int handlerIndex, lowerValue, upperValue) {},
            handler: FlutterSliderHandler(
              decoration: const BoxDecoration(),
              child: const SizedBox(),
            ),
          ),
        ),
      ],
    );
  }
}
