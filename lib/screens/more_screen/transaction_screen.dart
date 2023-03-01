// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:my_cart_express/constant/app_endpoints.dart';
import 'package:my_cart_express/constant/default_images.dart';
import 'package:my_cart_express/constant/sizedbox.dart';
import 'package:my_cart_express/theme/colors.dart';
import 'package:my_cart_express/theme/text_style.dart';
import 'package:my_cart_express/utils/network_dio.dart';
import 'package:my_cart_express/widget/app_bar_widget.dart';
import 'package:my_cart_express/widget/pdf_viewer.dart';
import 'package:permission_handler/permission_handler.dart';

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
                        height5,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
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
                        height10,
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
}
