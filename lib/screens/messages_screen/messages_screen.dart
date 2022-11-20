import 'package:flutter/material.dart';
import 'package:my_cart_express/constant/sizedbox.dart';
import 'package:my_cart_express/theme/colors.dart';
import 'package:my_cart_express/widget/app_bar_widget.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: appbarWidget(title: 'Messages'),
      body: ListView.separated(
        itemCount: 5,
        padding: const EdgeInsets.all(15),
        separatorBuilder: (BuildContext context, int index) => height10,
        itemBuilder: (BuildContext context, int inde) => ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              childrenPadding: const EdgeInsets.only(
                bottom: 10,
              ),
              backgroundColor: greyColor.withOpacity(0.2),
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              expandedAlignment: Alignment.topCenter,
              collapsedBackgroundColor: greyColor.withOpacity(0.2),
              tilePadding: const EdgeInsets.symmetric(horizontal: 15),
              trailing: const Text(
                '02 sep 2022 15:58 PM',
              ),
              title: const Text(
                'no-replay@mycartexpress.com',
              ),
              subtitle: const Text(
                'Email Verification',
              ),
              children: <Widget>[
                const Text(
                  'Welcome to Mart',
                ),
                height15,
                const Text(
                  'Thank you for signing up to MyCartExpress services.',
                ),
                const Text(
                  'Welcome to Mart',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
