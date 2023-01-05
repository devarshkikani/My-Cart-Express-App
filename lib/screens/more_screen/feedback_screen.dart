import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cart_express/constant/sizedbox.dart';
import 'package:my_cart_express/theme/colors.dart';
import 'package:my_cart_express/theme/text_style.dart';
import 'package:my_cart_express/widget/app_bar_widget.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.height,
        color: primary,
        child: Column(
          children: [
            appBarWithAction(),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: const BoxDecoration(
                  color: offWhite,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: bodyView(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget bodyView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Feedback',
              style: regularText18,
            ),
          ],
        ),
        height10,
        Text(
          'TRANSACTION',
          style: regularText16,
        ),
        height15,
        Expanded(
          child: feedbackList(),
        ),
      ],
    );
  }

  Widget feedbackList() {
    return ListView.separated(
      itemCount: 10,
      padding: EdgeInsets.zero,
      separatorBuilder: (BuildContext context, int index) => height10,
      itemBuilder: (BuildContext context, int index) => Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: greyColor.withOpacity(.5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    'Your Agent was :',
                    style: regularText14,
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Text(
                    "Damion Campbell",
                    style: regularText14,
                  ),
                ),
              ],
            ),
            height5,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    'Date/Time',
                    style: lightText13,
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Text(
                    "11/09/2022",
                    style: lightText13,
                  ),
                ),
              ],
            ),
            height5,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    'Transaction',
                    style: lightText13,
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Text(
                    "TR783466",
                    style: lightText13,
                  ),
                ),
              ],
            ),
            const Divider(
              color: blackColor,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    'Last Replay :',
                    style: lightText13,
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "RC555555",
                        style: lightText13,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(primary),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          minimumSize: MaterialStateProperty.all(
                            const Size(0, 0),
                          ),
                          padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 8,
                            ),
                          ),
                        ),
                        child: Text(
                          'Leave Feedback',
                          style: lightText12.copyWith(
                            letterSpacing: 0.9,
                            color: whiteColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
