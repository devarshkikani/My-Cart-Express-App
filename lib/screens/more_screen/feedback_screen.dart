import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:my_cart_express/constant/app_endpoints.dart';
import 'package:my_cart_express/constant/default_images.dart';
import 'package:my_cart_express/theme/colors.dart';
import 'package:my_cart_express/theme/text_style.dart';
import 'package:my_cart_express/constant/sizedbox.dart';
import 'package:my_cart_express/utils/network_dio.dart';
import 'package:my_cart_express/widget/app_bar_widget.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  ScrollController scrollController = ScrollController();
  RxInt limit = 10.obs;
  RxList feedbackList = [].obs;
  RxBool isLoading = true.obs;
  @override
  void initState() {
    super.initState();
    scrollController = ScrollController()..addListener(_scrollListener);
    getFeedbackData();
  }

  Future<void> _scrollListener() async {
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      limit.value = limit.value + 10;
      getFeedbackData();
    }
  }

  void getFeedbackData() async {
    Map<String, dynamic>? response = await NetworkDio.getDioHttpMethod(
      // ignore: prefer_interpolation_to_compose_strings
      url: ApiEndPoints.apiEndPoint +
          ApiEndPoints.feedbackTransactionList +
          '?offset=0&limit=$limit',
      context: context,
    );
    if (response != null) {
      feedbackList.value = response['list'];
    }
    isLoading.value = false;
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
          child: feedbackListView(),
        ),
      ],
    );
  }

  Widget feedbackListView() {
    return Obx(
      () => isLoading.value
          ? const SizedBox()
          : feedbackList.isEmpty
              ? Center(
                  child: Text(
                    'No feedback found.',
                    style: lightText14.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                )
              : ListView.separated(
                  itemCount: feedbackList.length,
                  controller: scrollController,
                  padding: EdgeInsets.zero,
                  separatorBuilder: (BuildContext context, int index) =>
                      height10,
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
                                feedbackList[index]['agent'],
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
                                feedbackList[index]["insert_timestamp"],
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
                                feedbackList[index]['customer_name']
                                    .toString()
                                    .split(' ')
                                    .first,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    feedbackList[index]['last_reply']
                                                .toString() !=
                                            ""
                                        ? feedbackList[index]['last_reply']
                                        : feedbackList[index]['customer_name']
                                            .toString()
                                            .split('-')
                                            .last
                                            .trim(),
                                    style: lightText13,
                                  ),
                                  if (feedbackList[index]
                                          ['hide_leave_feedback'] !=
                                      1)
                                    ElevatedButton(
                                      onPressed: () {},
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(primary),
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
                ),
    );
  }
}
