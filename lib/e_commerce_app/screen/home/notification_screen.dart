import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cart_express/e_commerce_app/constant/divider.dart';
import 'package:my_cart_express/e_commerce_app/constant/sizedbox.dart';
import 'package:my_cart_express/e_commerce_app/controller/home/notification_screen_controller.dart';
import 'package:my_cart_express/e_commerce_app/theme/app_text_theme.dart';

class NotificationScreen extends GetView<NotificationScreenController> {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Notification',
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
            height15,
          ],
        ),
      ),
    );
  }

  Widget bodyView(BuildContext context) {
    return ListView.separated(
      itemCount: controller.notificationList.length,
      shrinkWrap: true,
      separatorBuilder: (BuildContext context, int index) => dividers(0),
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
                controller.notificationList[index]['image'] as String),
          ),
          title: Text(
            controller.notificationList[index]['title'] as String,
            style: lightText14,
          ),
          subtitle: Text(
            controller.notificationList[index]['date'] as String,
            style: lightText12.copyWith(
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
        );
      },
    );
  }
}
