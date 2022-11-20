import 'package:flutter/material.dart';
import 'package:my_cart_express/constant/sizedbox.dart';
import 'package:my_cart_express/theme/colors.dart';
import 'package:my_cart_express/widget/app_bar_widget.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: appbarWidget(title: 'Notifications'),
      body: ListView.separated(
        itemCount: 10,
        padding: const EdgeInsets.all(15),
        separatorBuilder: (BuildContext context, int index) => height10,
        itemBuilder: (BuildContext context, int index) => Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: greyColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'MESSGAE',
                  ),
                  Text(
                    '02 sep 2022 15:58 PM',
                  ),
                ],
              ),
              height5,
              const Text(
                'Replay added to Ticket #545451231564124545',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
