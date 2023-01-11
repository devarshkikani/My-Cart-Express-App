import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:my_cart_express/constant/app_endpoints.dart';
import 'package:my_cart_express/constant/default_images.dart';
import 'package:my_cart_express/constant/sizedbox.dart';
import 'package:my_cart_express/theme/colors.dart';
import 'package:my_cart_express/theme/text_style.dart';
import 'package:my_cart_express/utils/network_dio.dart';
import 'package:my_cart_express/widget/app_bar_widget.dart';
import 'package:my_cart_express/widget/input_text_field.dart';

class SupportIndexScreen extends StatefulWidget {
  const SupportIndexScreen({super.key});

  @override
  State<SupportIndexScreen> createState() => _SupportIndexScreenState();
}

class _SupportIndexScreenState extends State<SupportIndexScreen> {
  ScrollController scrollController = ScrollController();
  RxString searchData = ''.obs;
  RxList supportList = [].obs;
  RxBool isLoading = true.obs;

  // RxInt perPage = 0.obs;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController()..addListener(_scrollListener);

    debounce<String>(searchData, validations,
        time: const Duration(milliseconds: 700));
    getSupportList(null);
  }

  Future<void> _scrollListener() async {
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      // perPage.value = perPage.value + 25;
      getSupportList(searchData.value);
    }
  }

  validations(String string) async {
    // perPage.value = 25;
    await getSupportList(string);
  }

  Future<void> getSupportList(String? value) async {
    final data = dio.FormData.fromMap({
      'search_text': value,
      'per_page': 50,
      'offset': 0,
      'status': null,
      'ticket_type': null,
    });
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.supportList,
      data: value != null ? data : null,
      context: context,
    );
    if (response != null) {
      isLoading.value = false;
      supportList.value = response['list'];
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
                onChanged: (value) {
                  searchData.value = value.toString();
                },
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
            // const Spacer(),
            // Text(
            //   'All',
            //   style: lightText14.copyWith(
            //     color: Colors.grey,
            //   ),
            // ),
            // width15,
            // Text(
            //   'Sort by',
            //   style: lightText14.copyWith(
            //     color: Colors.grey,
            //   ),
            // ),
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
    return Obx(
      () => isLoading.value
          ? const SizedBox()
          : supportList.isEmpty
              ? Image.asset(
                  emptyList,
                )
              : ListView.separated(
                  itemCount: supportList.length,
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
                                'Title :',
                                style: lightText16,
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: Text(
                                supportList[index]['title'],
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
                                supportList[index]['date'],
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
                                          supportList[index]['ticket_id'],
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
                                          supportList[index]['last_reply'],
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
                              child: ElevatedButton(
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
                                      horizontal: 15,
                                      vertical: 8,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  supportList[index]['button_text'],
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
                ),
    );
  }
}
