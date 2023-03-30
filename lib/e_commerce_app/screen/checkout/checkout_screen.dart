import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:my_cart_express/e_commerce_app/constant/divider.dart';
import 'package:my_cart_express/e_commerce_app/constant/sizedbox.dart';
import 'package:my_cart_express/e_commerce_app/controller/checkout/checkout_screen_controller.dart';
import 'package:my_cart_express/e_commerce_app/controller/theme_controller.dart';
import 'package:my_cart_express/e_commerce_app/routes/app_pages.dart';
import 'package:my_cart_express/e_commerce_app/theme/app_text_theme.dart';
import 'package:my_cart_express/e_commerce_app/widget/elevated_button.dart';

class CheckoutScreen extends GetView<CheckoutScreenController> {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Checkout',
        ),
      ),
      body: SizedBox(
        height: Get.height,
        child: Column(
          children: <Widget>[
            dividers(0),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    favoritesList(context),
                    priceDetailsView(context),
                  ],
                ),
              ),
            ),
            height10,
            SizedBox(
              width: Get.width * 0.8,
              child: elevatedButton(
                context: context,
                title: 'Proceed to Buy',
                onTap: () {
                  Get.toNamed(Routes.deliveryAddress);
                },
              ),
            ),
            height15,
          ],
        ),
      ),
    );
  }

  Widget favoritesList(
    BuildContext context,
  ) {
    return ListView.builder(
      itemCount: controller.favoritesList.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(15),
      itemBuilder: (BuildContext context, int index) =>
          cartDecoration(context, index),
    );
  }

  Widget cartDecoration(BuildContext context, int index) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 15,
      ),
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
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.network(
                    controller.favoritesList[index]['image'] as String,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              width10,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    height5,
                    Text(
                      controller.favoritesList[index]['title'] as String,
                      style: regularText14,
                      overflow: TextOverflow.ellipsis,
                    ),
                    height5,
                    Text(
                      '''\$${controller.favoritesList[index]['discount_price']}''',
                      style: regularText16,
                    ),
                    height5,
                    Text.rich(
                      TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text:
                                '''\$${controller.favoritesList[index]['real_price']}''',
                            style: lightText12.copyWith(
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          TextSpan(
                            text:
                                '''  ${controller.favoritesList[index]['discount']}% off''',
                            style: lightText12.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget priceDetailsView(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15, left: 15, right: 15),
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
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Price Details',
                style: lightText16.copyWith(
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
              Text(
                '\$16',
                style: lightText16.copyWith(
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
            ],
          ),
          dividers(10),
          height10,
          rowDecorationView(
            title: 'Price (3 Item)',
            details: '\$16',
            context: context,
          ),
          height5,
          rowDecorationView(
            title: 'Discount',
            details: '-\$1',
            textColor: Theme.of(context).colorScheme.primary,
            context: context,
          ),
          height5,
          rowDecorationView(
            title: 'Delivery Charges',
            details: '-\$5',
            context: context,
          ),
          dividers(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const <Widget>[
              Text(
                'Total Amount',
                style: lightText16,
              ),
              Text(
                '\$20',
                style: lightText16,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget rowDecorationView(
      {required String title,
      required String details,
      required BuildContext context,
      Color? textColor}) {
    return Row(
      children: <Widget>[
        Text(
          title,
          style: lightText14,
        ),
        const Spacer(),
        Text(
          details,
          style: lightText14.copyWith(
            color: textColor ?? Theme.of(context).colorScheme.secondary,
          ),
        ),
      ],
    );
  }
}
