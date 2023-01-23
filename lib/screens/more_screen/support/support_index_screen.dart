import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:my_cart_express/constant/app_endpoints.dart';
import 'package:my_cart_express/constant/default_images.dart';
import 'package:my_cart_express/constant/sizedbox.dart';
import 'package:my_cart_express/screens/more_screen/support/add_ticket_screen.dart';
import 'package:my_cart_express/screens/more_screen/support/support_chat_screen.dart';
import 'package:my_cart_express/theme/colors.dart';
import 'package:my_cart_express/theme/text_style.dart';
import 'package:my_cart_express/utils/network_dio.dart';
import 'package:my_cart_express/widget/app_bar_widget.dart';

class SupportIndexScreen extends StatefulWidget {
  const SupportIndexScreen({super.key});

  @override
  State<SupportIndexScreen> createState() => _SupportIndexScreenState();
}

class _SupportIndexScreenState extends State<SupportIndexScreen> {
  ScrollController scrollController = ScrollController();
  RxList openTicketList = [].obs;
  RxList closeTicketList = [].obs;
  RxBool isLoading = true.obs;

  // RxInt perPage = 0.obs;

  @override
  void initState() {
    super.initState();
    // scrollController = ScrollController()..addListener(_scrollListener);

    getSupportOpenList();
  }

  // Future<void> _scrollListener() async {
  //   if (scrollController.position.pixels ==
  //           scrollController.position.maxScrollExtent &&
  //       !scrollController.position.outOfRange) {
  //     // perPage.value = perPage.value + 25;
  //     getSupportList();
  //   }
  // }

  Future<void> getSupportOpenList() async {
    final data = dio.FormData.fromMap({
      'per_page': 50,
      'offset': 0,
      'status': 'Open',
      'ticket_type': null,
    });
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.supportList,
      data: data,
      context: context,
    );
    if (response != null) {
      openTicketList.value = response['list'];
    }
    getSupportClosedList();
  }

  Future<void> getSupportClosedList() async {
    final data = dio.FormData.fromMap({
      'per_page': 50,
      'offset': 0,
      'status': 'Resolved',
      'ticket_type': null,
    });
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.supportList,
      data: data,
      context: context,
    );
    if (response != null) {
      isLoading.value = false;
      closeTicketList.value = response['list'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Container(
          width: Get.width,
          height: Get.height,
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
              width: 80,
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Get.to(() => const AddTicketScreen())?.then((value) {
                    if (value == true) {
                      getSupportOpenList();
                    }
                  });
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(primary),
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
                  'Contact Agent',
                  style: regularText14.copyWith(
                    letterSpacing: 0.9,
                    color: whiteColor,
                  ),
                ),
              ),
            ),
          ],
        ),
        height5,
        Row(
          children: [
            Text(
              'Your Tickets',
              style: lightText14.copyWith(
                color: Colors.grey,
              ),
            ),
          ],
        ),
        TabBar(
          tabs: [
            Tab(
              icon: Text(
                'Open',
                style: mediumText14,
              ),
            ),
            Tab(
              icon: Text(
                'Closed',
                style: mediumText14,
              ),
            ),
          ],
        ),
        Expanded(
          child: TabBarView(
            children: [
              ticketList(openTicketList, true),
              ticketList(closeTicketList, false),
            ],
          ),
        ),
      ],
    );
  }

  Widget ticketList(List data, bool isOpen) {
    return Column(
      children: [
        height15,
        Expanded(
          child: Obx(
            () => isLoading.value
                ? const SizedBox()
                : data.isEmpty
                    ? Image.asset(
                        emptyList,
                      )
                    : ListView.separated(
                        itemCount: data.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        separatorBuilder: (BuildContext context, int index) =>
                            height10,
                        itemBuilder: (BuildContext context, int index) =>
                            InkWell(
                          onTap: data[index]['status'] == 'Open'
                              ? () {
                                  Get.to(() => SupportChatScreen(
                                        data: data[index],
                                      ));
                                }
                              : null,
                          child: Container(
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
                                        data[index]['title'],
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
                                        data[index]['date'],
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
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
                                                  data[index]['ticket_id'],
                                                  style: lightText16,
                                                ),
                                              ),
                                            ],
                                          ),
                                          height5,
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
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
                                                  isOpen
                                                      ? data[index]
                                                          ['last_reply']
                                                      : '',
                                                  style: lightText16.copyWith(
                                                      color: primary),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: isOpen &&
                                              ((data[index] as Map).containsKey(
                                                      'button_text') ||
                                                  data[index]['status'] ==
                                                      'Open')
                                          ? ElevatedButton(
                                              onPressed: data[index]
                                                          ['status'] ==
                                                      'Open'
                                                  ? () {
                                                      Get.to(() =>
                                                          SupportChatScreen(
                                                            data: data[index],
                                                          ));
                                                    }
                                                  : null,
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        primary),
                                                tapTargetSize:
                                                    MaterialTapTargetSize
                                                        .shrinkWrap,
                                                minimumSize:
                                                    MaterialStateProperty.all(
                                                  const Size(0, 0),
                                                ),
                                                padding:
                                                    MaterialStateProperty.all(
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 15,
                                                    vertical: 8,
                                                  ),
                                                ),
                                              ),
                                              child: Text(
                                                data[index]['status'] == 'Open'
                                                    ? "Replay"
                                                    : data[index]
                                                        ['button_text'],
                                                style: regularText14.copyWith(
                                                  letterSpacing: 0.9,
                                                  color: whiteColor,
                                                ),
                                              ),
                                            )
                                          : const SizedBox(),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
          ),
        ),
      ],
    );
  }
}
