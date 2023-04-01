import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cart_express/e_commerce_app/e_constant/e_divider.dart';
import 'package:my_cart_express/e_commerce_app/e_constant/e_sizedbox.dart';
import 'package:my_cart_express/e_commerce_app/e_controller/e_payment/e_payment_method_screen_controller.dart';
import 'package:my_cart_express/e_commerce_app/e_controller/e_theme_controller.dart';
import 'package:my_cart_express/e_commerce_app/e_routes/e_app_pages.dart';
import 'package:my_cart_express/e_commerce_app/e_theme/e_app_text_theme.dart';
import 'package:my_cart_express/e_commerce_app/e_widget/e_elevated_button.dart';

class EPaymentMethodScreen extends GetView<EPaymentMethodScreenController> {
  const EPaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Payment Methods',
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        'Credit / Debit Card',
                        style: lightText18,
                      ),
                      height15,
                      cardListView(context),
                      addNewCardButton(context),
                      const Text(
                        'Wallet',
                        style: lightText18,
                      ),
                      walletListView(context),
                      const Text(
                        'Net Banking',
                        style: lightText18,
                      ),
                      netBankingView(context),
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
                title: 'Continue',
                onTap: () {
                  Get.toNamed(ERoutes.orderSuccess);
                },
              ),
            ),
            height15,
          ],
        ),
      ),
    );
  }

  Widget cardListView(BuildContext context) {
    return Container(
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
      child: ListView.separated(
        itemCount: 2,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        separatorBuilder: (BuildContext context, int index) => dividers(15),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              for (final Map<String, dynamic> element
                  in controller.cardDetails) {
                element['default'].value = false;
              }
              controller.cardDetails[index]['default'].value = true;
            },
            child: Row(
              children: <Widget>[
                Image.asset(
                  controller.cardDetails[index]['icon'] as String,
                  height: 30,
                ),
                width30,
                Text(
                  '''*** *** *** ${controller.cardDetails[index]['code']}''',
                ),
                const Spacer(),
                Obx(
                  () => controller.cardDetails[index]['default'].value == true
                      ? Icon(
                          Icons.check_circle_rounded,
                          color: Theme.of(context).colorScheme.primary,
                        )
                      : const SizedBox(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget addNewCardButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: GestureDetector(
        onTap: () {
          Get.toNamed(ERoutes.addNewCardScreen);
        },
        child: Container(
          height: 45,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
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
                  'Add New Card',
                  style: regularText16.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget netBankingView(BuildContext context) {
    return SizedBox(
      height: 110,
      child: ListView.builder(
        itemCount: controller.netBanking.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) => Container(
          height: 50,
          width: 90,
          margin: EdgeInsets.only(
            left: index == 0 ? 15 : 0,
            right: 10,
            top: 10,
            bottom: 20,
          ),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Get.find<ThemeController>().isDarkTheme.value
                ? Theme.of(context).colorScheme.tertiary.withOpacity(0.5)
                : Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(10),
            boxShadow: Get.find<ThemeController>().isDarkTheme.value
                ? <BoxShadow>[]
                : <BoxShadow>[
                    BoxShadow(
                      color: Theme.of(context)
                          .colorScheme
                          .secondary
                          .withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 1,
                      offset: const Offset(0, 5),
                    ),
                  ],
          ),
          alignment: Alignment.center,
          child: Image.asset(
            controller.netBanking[index],
          ),
        ),
      ),
    );
  }

  Widget walletListView(BuildContext context) {
    return SizedBox(
      height: 110,
      child: ListView.builder(
        itemCount: controller.walletList.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) => Container(
          height: 50,
          width: 90,
          margin: EdgeInsets.only(
            left: index == 0 ? 15 : 0,
            right: 10,
            top: 10,
            bottom: 20,
          ),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Get.find<ThemeController>().isDarkTheme.value
                ? Theme.of(context).colorScheme.tertiary.withOpacity(0.5)
                : Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(10),
            boxShadow: Get.find<ThemeController>().isDarkTheme.value
                ? <BoxShadow>[]
                : <BoxShadow>[
                    BoxShadow(
                      color: Theme.of(context)
                          .colorScheme
                          .secondary
                          .withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 1,
                      offset: const Offset(0, 5),
                    ),
                  ],
          ),
          alignment: Alignment.center,
          child: Image.asset(
            controller.walletList[index],
          ),
        ),
      ),
    );
  }
}
