import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:my_cart_express/order_tracking_app/constant/app_endpoints.dart';
import 'package:my_cart_express/order_tracking_app/constant/sizedbox.dart';
import 'package:my_cart_express/order_tracking_app/theme/colors.dart';
import 'package:my_cart_express/order_tracking_app/theme/text_style.dart';
import 'package:my_cart_express/order_tracking_app/utils/network_dio.dart';
import 'package:my_cart_express/order_tracking_app/widget/app_bar_widget.dart';
import 'package:my_cart_express/order_tracking_app/widget/input_text_field.dart';

class FAQSScreen extends StatefulWidget {
  const FAQSScreen({super.key});

  @override
  State<FAQSScreen> createState() => _FAQSScreenState();
}

class _FAQSScreenState extends State<FAQSScreen> {
  TextEditingController searchContorller = TextEditingController();

  RxList faqList = [].obs;
  RxList serachedList = [].obs;
  RxString searchData = ''.obs;

  @override
  void initState() {
    super.initState();
    getFaqList();
    debounce<String>(searchData, validations,
        time: const Duration(milliseconds: 500));
  }

  validations(String string) {
    serachedList.value = faqList
        .where((e) =>
            e['question'].toLowerCase().contains(
                  string.toLowerCase(),
                ) ||
            e['answer'].toUpperCase().contains(
                  string.toUpperCase(),
                ))
        .toList();
  }

  void getFaqList() async {
    Map<String, dynamic>? response = await NetworkDio.getDioHttpMethod(
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.faqList,
      context: context,
    );
    if (response != null) {
      faqList.value = response['data'];
      serachedList.value = response['data'];
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
        Row(
          children: [
            Text(
              'FAQS',
              style: regularText18,
            ),
            const SizedBox(
              width: 100,
            ),
            Expanded(
              child: TextFormFieldWidget(
                hintText: 'Search',
                controller: searchContorller,
                onChanged: (String? value) {
                  searchData.value = value ?? '';
                },
              ),
            ),
          ],
        ),
        height10,
        Text(
          'ALL TOPICS',
          style: regularText16,
        ),
        height10,
        Expanded(
          child: Obx(
            () => ListView.builder(
              itemCount: serachedList.length,
              padding: EdgeInsets.zero,
              itemBuilder: (BuildContext context, int index) => Container(
                margin: const EdgeInsets.fromLTRB(0, 10, 18, 10),
                decoration: BoxDecoration(
                  color: primary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Theme(
                  data: Theme.of(context)
                      .copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    title: Text(
                      serachedList[index]['question'].trim(),
                      style: regularText14,
                    ),
                    tilePadding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    childrenPadding: EdgeInsets.zero,
                    iconColor: blackColor,
                    collapsedIconColor: blackColor,
                    // collapsedBackgroundColor: primary.withOpacity(0.2),
                    // backgroundColor: primary.withOpacity(0.5),
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: greyColor,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        width: Get.width,
                        child: html(serachedList[index]['answer'].trim()),
                        // child: Column(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     Text(
                        //       'Answer',
                        //       style: regularText16,
                        //     ),
                        //     height10,
                        //     const Text(
                        //       'Once received in Miami and processed, it can take 3-6 business days without airline delays.',
                        //     ),
                        //   ],
                        // ),
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

  Widget html(String data) {
    return Html(
      data: data,
    );
  }
}
