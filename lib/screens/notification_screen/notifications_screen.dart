import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:intl/intl.dart';
import 'package:my_cart_express/constant/app_endpoints.dart';
import 'package:my_cart_express/constant/default_images.dart';
import 'package:my_cart_express/constant/sizedbox.dart';
import 'package:my_cart_express/theme/colors.dart';
import 'package:my_cart_express/theme/text_style.dart';
import 'package:my_cart_express/utils/network_dio.dart';
import 'package:my_cart_express/widget/app_bar_widget.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  ScrollController scrollController = ScrollController();
  RxInt offSet = 10.obs;
  RxList notificationList = [].obs;
  RxBool isLoading = true.obs;
  @override
  void initState() {
    super.initState();
    scrollController = ScrollController()..addListener(_scrollListener);
    getNotifications();
  }

  void getNotifications() async {
    final data = dio.FormData.fromMap({
      'limit': 0,
      'offset': offSet,
    });
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.notificationList,
      data: data,
      context: context,
    );
    if (response != null) {
      notificationList.value = response['data'];
    }
    isLoading.value = false;
  }

  Future<void> _scrollListener() async {
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      offSet.value = offSet.value + 10;
      getNotifications();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: appbarWidget(title: 'Notifications'),
      body: Obx(
        () => isLoading.value
            ? const SizedBox()
            : notificationList.isEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        noNotification,
                      ),
                      height10,
                      Text(
                        'No Notification Yet',
                        style: mediumText24,
                      ),
                      height10,
                      Text(
                        'You have no notifications right now.\n come back later',
                        style: regularText16.copyWith(color: greyColor),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )
                : ListView.separated(
                    itemCount: notificationList.length,
                    controller: scrollController,
                    padding: const EdgeInsets.all(15),
                    separatorBuilder: (BuildContext context, int index) =>
                        height10,
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
                            children: [
                              Text(
                                notificationList[index]['type'],
                              ),
                              Text(
                                DateFormat('dd MMM yyyy HH:mm a').format(
                                    DateTime.parse(notificationList[index]
                                        ['insert_timestamp'])),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            notificationList[index]['notification_text'],
                          ),
                        ],
                      ),
                    ),
                  ),
      ),
    );
  }
}
