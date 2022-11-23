import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cart_express/constant/sizedbox.dart';
import 'package:my_cart_express/theme/colors.dart';
import 'package:my_cart_express/theme/text_style.dart';
import 'package:my_cart_express/widget/app_bar_widget.dart';
import 'package:my_cart_express/widget/input_text_field.dart';

class SupportIndexScreen extends StatefulWidget {
  const SupportIndexScreen({super.key});

  @override
  State<SupportIndexScreen> createState() => _SupportIndexScreenState();
}

class _SupportIndexScreenState extends State<SupportIndexScreen> {
  final TextEditingController searchContorller = TextEditingController();
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
      children: [
        Row(
          children: [
            Text(
              'Support Index',
              style: regularText18,
            ),
            const SizedBox(
              width: 60,
            ),
            Expanded(
              child: TextFormFieldWidget(
                hintText: 'Search',
                controller: searchContorller,
              ),
            ),
          ],
        ),
        height10,
        Row(
          children: [
            Text(
              'Your Tickets',
              style: lightText14.copyWith(
                color: Colors.grey,
              ),
            ),
            const Spacer(),
            Text(
              'All',
              style: lightText14.copyWith(
                color: Colors.grey,
              ),
            ),
            width15,
            Text(
              'Sort by',
              style: lightText14.copyWith(
                color: Colors.grey,
              ),
            ),
          ],
        ),
        height15,
        Expanded(
          child: ticketList(),
        ),
      ],
    );
  }

  Widget ticketList() {
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
                    'Title :',
                    style: lightText16,
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Text(
                    "What's My Shipping address & USA Phone Number",
                    style: lightText16,
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
                    'Date/Time :',
                    style: lightText16,
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Text(
                    "24 Aug, 2022 6:20 AM",
                    style: lightText16,
                  ),
                ),
              ],
            ),
            height5,
            Row(
              children: [
                Expanded(
                  flex: 6,
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(
                              'Ticket ID :',
                              style: lightText16,
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              "8758",
                              style: lightText16,
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
                              'Last Replay :',
                              style: lightText16,
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              "Orlan R.",
                              style: lightText16.copyWith(color: primary),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(secondary),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      minimumSize: MaterialStateProperty.all(
                        const Size(0, 0),
                      ),
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 8,
                        ),
                      ),
                    ),
                    child: Text(
                      'WAITING',
                      style: regularText14.copyWith(
                        letterSpacing: 0.9,
                        color: whiteColor,
                      ),
                    ),
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
