// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:my_cart_express/Order_tracking_app/theme/colors.dart';
import 'package:my_cart_express/Order_tracking_app/theme/text_style.dart';
import 'package:my_cart_express/Order_tracking_app/utils/network_dio.dart';
import 'package:my_cart_express/Order_tracking_app/widget/pdf_viewer.dart';
import 'package:my_cart_express/Order_tracking_app/constant/sizedbox.dart';
import 'package:my_cart_express/Order_tracking_app/widget/app_bar_widget.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:my_cart_express/Order_tracking_app/widget/input_text_field.dart';
import 'package:my_cart_express/Order_tracking_app/constant/app_endpoints.dart';
import 'package:my_cart_express/Order_tracking_app/constant/default_images.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  ScrollController scrollController = ScrollController();
  RxInt limit = 10.obs;
  String? emojiStatus;
  String? ratingStatus;
  TextEditingController feedbackController = TextEditingController();
  RxList transactionList = [].obs;
  RxBool isLoading = true.obs;
  RxBool isDownloading = false.obs;

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

  Future<void> getPDFUrl(String id, bool isPreview) async {
    Map<String, dynamic>? response = await NetworkDio.getDioHttpMethod(
      url: '${ApiEndPoints.apiEndPoint}${ApiEndPoints.download}$id/download',
      context: context,
    );
    if (response != null) {
      if (isPreview) {
        Get.to(
          () => PdfViewerPage(
            pdfUrl: response['url'],
          ),
        );
      } else {
        downloadProfile(response['url'], id);
      }
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

  Future<void> downloadProfile(String downloadUrl, String id) async {
    try {
      late Directory dir;
      if (Platform.isIOS) {
        dir = await getApplicationDocumentsDirectory();
      } else {
        var status = await Permission.storage.status;
        if (status != PermissionStatus.granted) {
          status = await Permission.storage.request();
        }
        if (status.isGranted) {
          const downloadsFolderPath = '/storage/emulated/0/Download/';
          dir = Directory(downloadsFolderPath);
        } else {
          NetworkDio.showError(
            title: 'Error',
            errorMessage:
                'Permission required, Turn on storage permission from settings',
          );
          return;
        }
      }
      isDownloading.value = true;
      var response =
          await Dio().download(downloadUrl, '${dir.path}/Invoice-$id.pdf');
      isDownloading.value = false;
      if (response.statusCode == 200) {
        NetworkDio.showSuccess(
          title: 'Success',
          sucessMessage:
              '''Pdf download successfully completed on this path.\n${dir.path}/Invoice-$id.pdf''',
        );
      } else {
        NetworkDio.showError(
          title: 'Error',
          errorMessage: 'Some thing went wrong, please try agian later',
        );
      }
    } catch (e) {
      NetworkDio.showError(
        title: 'Error',
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> saveFeedBack(String id) async {
    if (emojiStatus == null) {
      Get.showSnackbar(
        const GetSnackBar(
          message: 'Add how satisfied are you with this transaction?',
          duration: Duration(
            seconds: 3,
          ),
        ),
      );
    } else if (ratingStatus == null) {
      Get.showSnackbar(
        const GetSnackBar(
          message: 'Add how do you rate your Driver/Cashier interraction?',
          duration: Duration(
            seconds: 3,
          ),
        ),
      );
    } else if (feedbackController.text == '') {
      Get.showSnackbar(
        const GetSnackBar(
          message: 'Add your feedback first',
          duration: Duration(
            seconds: 3,
          ),
        ),
      );
    } else {
      final data = dio.FormData.fromMap({
        'transaction_id': id,
        'satisfied': emojiStatus,
        'rating': ratingStatus,
        'feedback': feedbackController.text,
      });
      Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
        url: ApiEndPoints.apiEndPoint + ApiEndPoints.feedbackSend,
        context: context,
        data: data,
      );
      if (response != null) {
        emojiStatus = null;
        ratingStatus = null;
        feedbackController = TextEditingController();
        Navigator.pop(context);
        getTransaction();
        NetworkDio.showSuccess(
            title: 'Suceess', sucessMessage: response['message']);
      }
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
    return Obx(() => Stack(
          children: [
            Column(
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
            ),
            if (isDownloading.value)
              const Center(
                child: CircularProgressIndicator(),
              )
          ],
        ));
  }

  Widget transactionsListView() {
    return Obx(
      () => isLoading.value
          ? Row(
              children: const [
                SizedBox(),
              ],
            )
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
                    decoration: BoxDecoration(
                      color: greyColor.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        height15,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
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
                        ),
                        height5,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
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
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
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
                              ElevatedButton(
                                onPressed: transactionList[index]
                                            ['hide_leave_feedback'] >
                                        0
                                    ? () {}
                                    : () {
                                        feedBackDialoag(context,
                                            transactionList[index]['id']);
                                      },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: transactionList[index]
                                              ['hide_leave_feedback'] >
                                          0
                                      ? Colors.grey
                                      : secondary,
                                  fixedSize: const Size(130, 30),
                                  minimumSize: const Size(130, 30),
                                  padding: EdgeInsets.zero,
                                ),
                                child: Text(
                                  transactionList[index]
                                              ['hide_leave_feedback'] >
                                          0
                                      ? 'Feedback Left'
                                      : 'Leave Feedback',
                                  style: lightText12.copyWith(
                                    color: whiteColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            buttonDecoration(
                              title: 'Preview',
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                              ),
                              backgroundColor: primary,
                              onTap: () async {
                                await getPDFUrl(
                                    transactionList[index]['id'], true);
                              },
                            ),
                            buttonDecoration(
                              title: 'Download',
                              borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(10),
                              ),
                              backgroundColor: orangeColor,
                              onTap: () async {
                                await getPDFUrl(
                                    transactionList[index]['id'], false);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }

  buttonDecoration({
    required String title,
    required BorderRadius borderRadius,
    required Color backgroundColor,
    required Function() onTap,
  }) {
    return Expanded(
      flex: 2,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 30,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: borderRadius,
          ),
          child: Text(
            title,
            style: regularText14.copyWith(color: whiteColor),
          ),
        ),
      ),
    );
  }

  void feedBackDialoag(BuildContext context, String id) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            height15,
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(
                'Leave Feedback',
                style: mediumText18,
              ),
            ),
            const Divider(),
            height10,
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(
                'How satisfied are you with this trasaction?',
                style: regularText14,
              ),
            ),
            height10,
            emojiRating(),
            height10,
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(
                'How do you rate your Driver/Cashier interraction?',
                style: regularText14,
              ),
            ),
            height10,
            starRating(),
            height10,
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(
                'Write your feedback',
                style: regularText14,
              ),
            ),
            height10,
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 280,
                    height: 90,
                    child: TextFormFieldWidget(
                      maxLines: 3,
                      controller: feedbackController,
                      contentPadding: const EdgeInsets.all(10),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: secondary,
                  ),
                  onPressed: () {
                    emojiStatus = null;
                    ratingStatus = null;
                    feedbackController = TextEditingController();
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Close',
                  ),
                ),
                width15,
                ElevatedButton(
                  onPressed: () {
                    saveFeedBack(id);
                  },
                  child: const Text(
                    'Send Feedback',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget emojiRating() {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: RatingBar.builder(
        itemCount: 5,
        unratedColor: Colors.grey,
        itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
        itemBuilder: (context, index) {
          switch (index) {
            case 0:
              return Icon(
                Icons.sentiment_very_dissatisfied,
                color: emojiStatus == 'Very unsatisfied'
                    ? Colors.red
                    : Colors.grey,
              );
            case 1:
              return Icon(
                Icons.sentiment_dissatisfied,
                color: emojiStatus == 'Unsatisfied'
                    ? Colors.redAccent
                    : Colors.grey,
              );
            case 2:
              return Icon(
                Icons.sentiment_neutral,
                color: emojiStatus == 'Neutral' ? Colors.amber : Colors.grey,
              );
            case 3:
              return Icon(
                Icons.sentiment_satisfied,
                color: emojiStatus == 'Satisfied'
                    ? Colors.lightGreen
                    : Colors.grey,
              );
            case 4:
              return Icon(
                Icons.sentiment_very_satisfied,
                color: emojiStatus == 'Very Satisfied'
                    ? Colors.green
                    : Colors.grey,
              );
            default:
              return Container();
          }
        },
        onRatingUpdate: (rating) {
          setState(() {
            if (rating == 1.0) {
              emojiStatus = 'Very unsatisfied';
            } else if (rating == 2.0) {
              emojiStatus = 'Unsatisfied';
            } else if (rating == 3.0) {
              emojiStatus = 'Neutral';
            } else if (rating == 4.0) {
              emojiStatus = 'Satisfied';
            } else if (rating == 5.0) {
              emojiStatus = 'Very Satisfied';
            }
          });
        },
        updateOnDrag: true,
      ),
    );
  }

  Widget starRating() {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: RatingBar.builder(
        minRating: 1,
        unratedColor: greyColor.withOpacity(0.5),
        glowColor: greyColor,
        itemCount: 5,
        itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
        itemBuilder: (context, _) => const Icon(
          Icons.star,
          color: Colors.amber,
        ),
        onRatingUpdate: (rating) {
          setState(() {
            ratingStatus = rating.toString();
          });
        },
        updateOnDrag: true,
      ),
    );
  }
}
