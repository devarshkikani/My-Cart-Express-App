import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';
import 'package:my_cart_express/e_commerce_app/e_constant/e_divider.dart';
import 'package:my_cart_express/e_commerce_app/e_constant/e_sizedbox.dart';
import 'package:my_cart_express/e_commerce_app/e_routes/e_app_pages.dart';
import 'package:my_cart_express/e_commerce_app/e_theme/e_app_text_theme.dart';
import 'package:my_cart_express/e_commerce_app/e_widget/e_elevated_button.dart';
import 'package:my_cart_express/e_commerce_app/e_controller/e_theme_controller.dart';
import 'package:my_cart_express/e_commerce_app/e_controller/e_track_order/e_track_order_screen_controller.dart';

class ETrackOrderScreen extends GetView<ETrackOrderScreenController> {
  const ETrackOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Track Order',
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
                    bodyView(context),
                  ],
                ),
              ),
            ),
            height10,
            SizedBox(
              width: Get.width * 0.8,
              child: eElevatedButton(
                context: context,
                title: 'Continue Shopping',
                onTap: () {
                  Get.offAllNamed(ERoutes.mainHome);
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
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: <Widget>[
          deliveryStatus(context),
          trackView(context),
          addressView(context),
        ],
      ),
    );
  }

  Widget deliveryStatus(BuildContext context) {
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
          const Text(
            'Delivery expected on Sat, 19',
            style: regularText14,
          ),
          height5,
          Text(
            'Order ID: OD110589307',
            style: regularText12.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget trackView(BuildContext context) {
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
      child: FixedTimeline.tileBuilder(
        // shrinkWrap: true,
        // physics: const NeverScrollableScrollPhysics(),
        theme: TimelineThemeData(
          nodePosition: 0, indicatorPosition: 0,
          // color: const Color(0xff989898),
          indicatorTheme: const IndicatorThemeData(
            position: 0,
            size: 20,
          ),
          connectorTheme: const ConnectorThemeData(
            thickness: 3,
          ),
        ),
        builder: TimelineTileBuilder.connected(
          itemCount: controller.trackDetails.length,
          contentsAlign: ContentsAlign.basic,
          connectionDirection: ConnectionDirection.before,
          connectorBuilder: (_, int index, ___) => SolidLineConnector(
            color: index <= 1 ? const Color(0xff66c97f) : null,
            endIndent: 5,
            indent: 5,
            thickness: 2,
          ),
          indicatorBuilder: (_, int index) {
            if (index <= 1) {
              return const DotIndicator(
                color: Color(0xff66c97f),
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 12,
                ),
              );
            } else {
              return const OutlinedDotIndicator(
                borderWidth: 5,
              );
            }
          },
          contentsBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    controller.trackDetails[index]['status'] as String,
                    style: regularText16,
                  ),
                  if (controller.trackDetails[index]['date'] as String != '')
                    Text(
                      controller.trackDetails[index]['date'] as String,
                      style: regularText12.copyWith(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                  if (controller.trackDetails[index]['date'] as String != '')
                    height15,
                  if (controller.trackDetails[index]['description'] as String !=
                      '')
                    Text(
                      controller.trackDetails[index]['description'] as String,
                      style: regularText12.copyWith(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                  if (controller.trackDetails[index]['description'] as String !=
                      '')
                    height15,
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget addressView(BuildContext context) {
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
          Row(
            children: <Widget>[
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(40, 30),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text(
                  'Default delivery address',
                ),
              ),
              const Spacer(),
              Icon(
                Icons.check_circle,
                color: Theme.of(context).colorScheme.primary,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
