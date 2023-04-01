// ignore_for_file: library_prefixes

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cart_express/e_commerce_app/e_constant/e_default_image.dart';
import 'package:my_cart_express/e_commerce_app/e_constant/e_divider.dart';
import 'package:my_cart_express/e_commerce_app/e_constant/e_sizedbox.dart';
import 'package:my_cart_express/e_commerce_app/e_controller/e_cart/e_cart_screen_controller.dart';
import 'package:my_cart_express/e_commerce_app/e_controller/e_theme_controller.dart';
import 'package:my_cart_express/e_commerce_app/e_routes/e_app_pages.dart';
import 'package:my_cart_express/e_commerce_app/e_theme/e_app_text_theme.dart';
import 'package:my_cart_express/e_commerce_app/e_widget/e_elevated_button.dart';

class ECartScreen extends StatelessWidget {
  const ECartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ECartScreenController>(
      init: ECartScreenController(),
      builder: (_) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'My Cart',
          ),
        ),
        body: SizedBox(
          height: Get.height,
          child: Column(
            children: <Widget>[
              dividers(0),
              _.cartList.isNotEmpty
                  ? Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: cartItemList(context, _),
                      ),
                    )
                  : Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Center(
                            child: Image.asset(
                              emptyShoppingCart,
                              height: 250,
                              width: 250,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          height30,
                          const Text(
                            'No Products In Your Cart!',
                            style: mediumText22,
                          ),
                        ],
                      ),
                    ),
              height10,
              if (_.cartList.isNotEmpty)
                SizedBox(
                  width: Get.width * 0.8,
                  child: eElevatedButton(
                    context: context,
                    title: 'Proceed to Checkout',
                    onTap: () {
                      Get.toNamed(ERoutes.checkout);
                    },
                  ),
                ),
              height15,
            ],
          ),
        ),
      ),
    );
  }

  Widget cartItemList(BuildContext context, ECartScreenController _) {
    return ListView.builder(
      itemCount: _.cartList.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      itemBuilder: (BuildContext context, int index) =>
          cartDecoration(context, _, index),
    );
  }

  Widget cartDecoration(
      BuildContext context, ECartScreenController _, int index) {
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
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.network(
                    _.cartList[index]['image'] as String,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              width10,
              Expanded(
                child: SizedBox(
                  height: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        _.cartList[index]['title'] as String,
                        style: regularText14,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            '''\$${_.cartList[index]['discount_price']}''',
                            style: regularText16,
                          ),
                          width5,
                          Text.rich(
                            TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text:
                                      '''\$${_.cartList[index]['real_price']}''',
                                  style: lightText12.copyWith(
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      '''  ${_.cartList[index]['discount']}% off''',
                                  style: lightText12.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          InkWell(
                            onTap: () {},
                            child: Icon(
                              Icons.indeterminate_check_box_outlined,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          width10,
                          const Text(
                            '1',
                            style: regularText14,
                          ),
                          width10,
                          InkWell(
                            onTap: () {},
                            child: Icon(
                              Icons.add_box_outlined,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              width5,
              InkWell(
                onTap: () {},
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.2),
                  ),
                  child: Icon(
                    Icons.delete_rounded,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
