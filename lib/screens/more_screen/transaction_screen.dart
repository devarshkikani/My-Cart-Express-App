import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_cart_express/constant/app_endpoints.dart';
import 'package:my_cart_express/constant/default_images.dart';
import 'package:my_cart_express/constant/sizedbox.dart';
import 'package:my_cart_express/theme/colors.dart';
import 'package:my_cart_express/theme/text_style.dart';
import 'package:my_cart_express/utils/network_dio.dart';
import 'package:my_cart_express/widget/app_bar_widget.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  ScrollController scrollController = ScrollController();
  RxInt limit = 10.obs;
  RxList transactionList = [].obs;
  RxBool isLoading = true.obs;
  @override
  void initState() {
    super.initState();
    scrollController = ScrollController()..addListener(_scrollListener);
    getTransaction();
  }

  void getTransaction() async {
    Map<String, dynamic>? response = await NetworkDio.getDioHttpMethod(
      url:
          '${ApiEndPoints.apiEndPoint}${ApiEndPoints.transactionList}?offset=0&limit=$limit',
      context: context,
    );
    isLoading.value = false;
    if (response != null) {
      transactionList.value = response['list'];
    }
  }

  Future<void> _scrollListener() async {
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      limit.value = limit.value + 10;
      getTransaction();
    }
  }

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
        Text(
          'Transaction',
          style: regularText18,
        ),
        height10,
        Expanded(
          child: transactionsListView(),
        ),
      ],
    );
  }

  Widget transactionsListView() {
    return Obx(
      () => isLoading.value
          ? const SizedBox()
          : transactionList.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      noTransactions,
                    ),
                    height10,
                    Text(
                      'No Transactions Yet',
                      style: mediumText24,
                    ),
                    height10,
                    Text(
                      'You have no transactions right now.\n come back later',
                      style: regularText16.copyWith(color: greyColor),
                      textAlign: TextAlign.center,
                    ),
                  ],
                )
              : ListView.separated(
                  itemCount: transactionList.length,
                  controller: scrollController,
                  padding: EdgeInsets.zero,
                  separatorBuilder: (BuildContext context, int index) =>
                      height10,
                  itemBuilder: (BuildContext context, int index) => Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: greyColor.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Expanded(
                              flex: 2,
                              child: Text(
                                'Date/Time',
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(
                                DateFormat('dd MMM yyyy HH:mm a').format(
                                    DateTime.parse(transactionList[index]
                                        ['insert_timestamp'])),
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
                                transactionList[index]['id'],
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
                                    '${transactionList[index]['payment_type']} ${transactionList[index]['payment_type_label']}',
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
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                ),
    );
  }
}
