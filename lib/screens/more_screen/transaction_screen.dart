import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cart_express/constant/sizedbox.dart';
import 'package:my_cart_express/theme/colors.dart';
import 'package:my_cart_express/theme/text_style.dart';
import 'package:my_cart_express/widget/app_bar_widget.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
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
              'Transaction',
              style: regularText18,
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
        height10,
        Expanded(
          child: transactionsListView(),
        ),
      ],
    );
  }

  Widget transactionsListView() {
    return ListView.separated(
      itemCount: 10,
      padding: EdgeInsets.zero,
      separatorBuilder: (BuildContext context, int index) => height10,
      itemBuilder: (BuildContext context, int index) => Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: greyColor.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Row(
              children: const [
                Expanded(
                  flex: 2,
                  child: Text(
                    'Date/Time',
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    '02 Aug 2022 22:33 PM',
                  ),
                ),
              ],
            ),
            height5,
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'Transaction #',
                    style: lightText13,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    '16318',
                    style: lightText13,
                  ),
                ),
              ],
            ),
            height5,
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      Text('Type', style: lightText13),
                      width5,
                      Text(
                        '1 PKG (In Store)',
                        style: lightText13.copyWith(
                          color: primary,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        SizedBox(
                          width: 18,
                        ),
                        Text(
                          'Download',
                        ),
                        Icon(
                          Icons.download_for_offline_outlined,
                          size: 18,
                        ),
                      ],
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
