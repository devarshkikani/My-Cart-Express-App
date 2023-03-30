import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cart_express/e_commerce_app/constant/divider.dart';
import 'package:my_cart_express/e_commerce_app/constant/sizedbox.dart';
import 'package:my_cart_express/e_commerce_app/controller/address/delivery_address_screen_controller.dart';
import 'package:my_cart_express/e_commerce_app/controller/theme_controller.dart';
import 'package:my_cart_express/e_commerce_app/routes/app_pages.dart';
import 'package:my_cart_express/e_commerce_app/theme/app_text_theme.dart';
import 'package:my_cart_express/e_commerce_app/widget/elevated_button.dart';

class DeliveryAddressScreen extends GetView<DeliveryAddressScreenController> {
  const DeliveryAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Delivery Address',
        ),
      ),
      body: SizedBox(
        height: Get.height,
        child: Column(
          children: <Widget>[
            dividers(0),
            Padding(
              padding: const EdgeInsets.all(15),
              child: GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.addNewAddress);
                },
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.add,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        width5,
                        Text(
                          'Add New Address',
                          style: regularText16.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    favoritesList(context),
                  ],
                ),
              ),
            ),
            height10,
            SizedBox(
              width: Get.width * 0.8,
              child: elevatedButton(
                context: context,
                title: 'Proceed to Payment',
                onTap: () {
                  Get.toNamed(Routes.paymentMethod);
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
      itemCount: controller.addressList.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(15),
      itemBuilder: (BuildContext context, int index) =>
          addressView(context, index),
    );
  }

  Widget addressView(BuildContext context, int index) {
    return Container(
      width: Get.width,
      margin: const EdgeInsets.only(bottom: 15),
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
          Text(
            'Home Address',
            style: lightText16.copyWith(),
          ),
          height5,
          Text(
            '2249 Carling Ave #416',
            style: lightText14.copyWith(
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
          Text(
            'Ottawa, ON K2B 7E9',
            style: lightText14.copyWith(
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
          Text(
            'Canada',
            style: lightText14.copyWith(
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: const Size(40, 30),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              index == 0
                  ? 'Default delivery address'
                  : 'Set as your default delivery address',
            ),
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
