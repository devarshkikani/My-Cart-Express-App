import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_cart_express/order_tracking_app/constant/app_endpoints.dart';
import 'package:my_cart_express/order_tracking_app/constant/sizedbox.dart';
import 'package:my_cart_express/order_tracking_app/theme/colors.dart';
import 'package:my_cart_express/order_tracking_app/utils/network_dio.dart';
import 'package:my_cart_express/order_tracking_app/widget/app_bar_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  RxList messagesList = [].obs;

  @override
  void initState() {
    getMessgaes();
    super.initState();
  }

  Future<void> getMessgaes() async {
    Map<String, dynamic>? response = await NetworkDio.getDioHttpMethod(
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.dashboardMessages,
      context: context,
    );
    if (response != null) {
      messagesList.value = response['message'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: appbarWidget(title: 'Messages'),
      body: Obx(
        () => ListView.separated(
          itemCount: messagesList.length,
          separatorBuilder: (BuildContext context, int index) => height10,
          itemBuilder: (BuildContext context, int index) => ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Theme(
              data:
                  Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                childrenPadding: const EdgeInsets.only(
                  bottom: 10,
                ),
                backgroundColor: greyColor.withOpacity(0.2),
                expandedCrossAxisAlignment: CrossAxisAlignment.start,
                expandedAlignment: Alignment.topCenter,
                collapsedBackgroundColor: greyColor.withOpacity(0.2),
                tilePadding: const EdgeInsets.symmetric(horizontal: 15),
                trailing: Text(
                  DateFormat('dd MMM yyyy HH:mm a').format(
                      DateTime.parse(messagesList[index]['insert_timestamp'])),
                ),
                title: Text(messagesList[index]['email_address']),
                subtitle: Text(
                  messagesList[index]['email_subject'],
                ),
                children: <Widget>[
                  html(messagesList[index]['email_content']),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget html(String data) {
    return Html(
      data: data,
      onAnchorTap: (url, ss,attributes, element) {
        if (url != null) {
          launchUrl(Uri.parse(url));
        }
      },
      onLinkTap: (url,ss, attributes, element) {
        if (url != null) {
          launchUrl(Uri.parse(url));
        }
      },
    );
  }
}
