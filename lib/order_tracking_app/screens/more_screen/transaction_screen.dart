// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously

import 'dart:io';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:my_cart_express/order_tracking_app/widget/network_image_handle.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:my_cart_express/order_tracking_app/theme/colors.dart';
import 'package:my_cart_express/order_tracking_app/theme/text_style.dart';
import 'package:my_cart_express/order_tracking_app/utils/network_dio.dart';
import 'package:my_cart_express/order_tracking_app/widget/pdf_viewer.dart';
import 'package:my_cart_express/order_tracking_app/constant/sizedbox.dart';
import 'package:my_cart_express/order_tracking_app/widget/app_bar_widget.dart';
import 'package:my_cart_express/order_tracking_app/constant/app_endpoints.dart';
import 'package:my_cart_express/order_tracking_app/constant/default_images.dart';
import 'package:my_cart_express/order_tracking_app/widget/input_text_field.dart';

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

  Future<void> getTransaction() async {
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
          await dio.Dio().download(downloadUrl, '${dir.path}/Invoice-$id.pdf');
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

  Future<void> saveFeedBack(String id, BuildContext ctx) async {
    if (ratingStatus == null) {
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
        Navigator.pop(ctx);
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
        width: Get.width,
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
          ? const Row(
              children: [
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
                                        feedBackDialoag(context, index);
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

  void feedBackDialoag(BuildContext context, int index) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: StatefulBuilder(builder: (ctx, set) {
          return AlertDialog(
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
                    'How was your latest transcation with us?',
                    style: regularText14,
                  ),
                ),
                height10,
                ratingButton(set),
                height10,
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text(
                    'Write your feedback (Optional)',
                    style: regularText14,
                  ),
                ),
                height10,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
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
                      onPressed: () {
                        if (emojiStatus == null) {
                          Get.showSnackbar(
                            const GetSnackBar(
                              message:
                                  'Add how satisfied are you with this transaction?',
                              duration: Duration(
                                seconds: 3,
                              ),
                            ),
                          );
                          return;
                        }
                        Navigator.pop(ctx);
                        thankYouDialogWithPhoto(context, index);
                      },
                      child: const Text(
                        'Send Feedback',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  void thankYouDialogWithPhoto(
    BuildContext context,
    int index,
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: StatefulBuilder(builder: (context, set) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                height15,
                Text(
                  'Thank You for choosing us!',
                  style: mediumText18,
                ),
                const Divider(),
                height10,
                Text(
                  "I'm ${transactionList[index]['staff_firstname']}",
                  style: regularText14,
                ),
                height10,
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: networkImage(
                    transactionList[index]['staff_image'].toString(),
                    fit: BoxFit.cover,
                    height: 100,
                    width: 100,
                  ),
                ),
                height10,
                Text(
                  'How way my service?',
                  style: regularText14,
                ),
                height10,
                starRating(),
                height10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        saveFeedBack(transactionList[index]['id'], ctx);
                      },
                      child: const Text(
                        'Submit',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget ratingButton(void Function(void Function()) set) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                set(() {
                  emojiStatus = 'Satisfied';
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: emojiStatus == 'Satisfied'
                    ? success
                    : secondary.withOpacity(.2),
                elevation: 0,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
              child: Text(
                'Satisfied',
                style: TextStyle(
                  letterSpacing: 0.5,
                  color: emojiStatus == 'Satisfied' ? whiteColor : blackColor,
                ),
              ),
            ),
          ),
          width10,
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                set(() {
                  emojiStatus = 'Unsatisfied';
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: emojiStatus == 'Unsatisfied'
                    ? error
                    : secondary.withOpacity(.2),
                elevation: 0,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
              child: Text(
                'Unsatisfied',
                style: TextStyle(
                  letterSpacing: 0.5,
                  color: emojiStatus == 'Unsatisfied' ? whiteColor : blackColor,
                ),
              ),
            ),
          ),
        ],
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
