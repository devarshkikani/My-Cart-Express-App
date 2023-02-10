// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:my_cart_express/constant/app_endpoints.dart';
import 'package:my_cart_express/constant/sizedbox.dart';
import 'package:my_cart_express/theme/colors.dart';
import 'package:my_cart_express/theme/text_style.dart';
import 'package:my_cart_express/utils/network_dio.dart';
import 'package:my_cart_express/widget/input_text_field.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportChatScreen extends StatefulWidget {
  SupportChatScreen({super.key, required this.data});

  Map data;

  @override
  State<SupportChatScreen> createState() => _SupportChatScreenState();
}

class _SupportChatScreenState extends State<SupportChatScreen> {
  TextEditingController messageController = TextEditingController();
  RxList repliesList = [].obs;
  File? selectedFile;
  RxString fileName = ''.obs;
  RxInt replyFlag = 0.obs;
  RxInt assistanceFlag = 0.obs;
  RxInt stillAssistanceFlag = 0.obs;
  RxInt selfClosedAssistanceFlag = 0.obs;

  @override
  void initState() {
    getSupportDetails();
    super.initState();
  }

  Future<void> getSupportDetails() async {
    final data = dio.FormData.fromMap({
      'ticket_id': widget.data['ticket_id'],
    });
    Map<String, dynamic>? supportDetails = await NetworkDio.postDioHttpMethod(
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.supportDetails,
      data: data,
      context: context,
    );
    if (supportDetails != null) {
      repliesList.value = (supportDetails['replies'] as List).reversed.toList();
      replyFlag.value = supportDetails['reply_flag'];
      assistanceFlag.value = supportDetails['assistance_flag'];
      stillAssistanceFlag.value = supportDetails['still_assistance_flag'];
      selfClosedAssistanceFlag.value =
          supportDetails['self_closed_assistance_flag'];
    }
  }

  Future<void> sendMessage() async {
    final data = dio.FormData.fromMap({
      'ticket_id': widget.data['ticket_id'],
      'reply_message': messageController.text,
      'files': selectedFile != null
          ? await dio.MultipartFile.fromFile(
              selectedFile!.path,
              filename: fileName.value,
            )
          : null,
    });
    Map<String, dynamic>? supportDetails = await NetworkDio.postDioHttpMethod(
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.sendReply,
      data: data,
      context: context,
    );
    if (supportDetails != null) {
      messageController.clear();
      selectedFile = null;
      fileName.value = '';
      getSupportDetails();
    }
  }

  Future<void> selfCloseTicketFunction() async {
    final data = dio.FormData.fromMap({
      'ticket_id': widget.data['ticket_id'],
    });
    Map<String, dynamic>? supportDetails = await NetworkDio.postDioHttpMethod(
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.selfCloseTicket,
      data: data,
      context: context,
    );
    if (supportDetails != null) {
      messageController.clear();
      selectedFile = null;
      fileName.value = '';
      Get.back();
    }
  }

  Future<void> needAssistanceFunction() async {
    final data = dio.FormData.fromMap({
      'ticket_id': widget.data['ticket_id'],
    });
    Map<String, dynamic>? supportDetails = await NetworkDio.postDioHttpMethod(
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.needAssistance,
      data: data,
      context: context,
    );
    if (supportDetails != null) {
      messageController.clear();
      selectedFile = null;
      fileName.value = '';
      Get.back();
    }
  }

  Future<void> pickFile(FilePickerResult? result) async {
    if (result != null) {
      selectedFile = File(result.files.first.path!);
      fileName.value = result.files.first.name;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.data['title'],
          style: regularText14.copyWith(
            color: whiteColor,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            chatView(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Obx(
                () => assistanceFlag.value == 1
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Do you need further assistance?',
                            style: regularText20,
                          ),
                          height15,
                          buttons(
                            "No I'm done",
                            () async {
                              await needAssistanceFunction();
                            },
                          ),
                          height10,
                          buttons(
                            "Yes, I need further assistance",
                            () async {
                              await selfCloseTicketFunction();
                            },
                          ),
                        ],
                      )
                    : stillAssistanceFlag.value == 1
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Do you need still help?',
                                style: regularText20,
                              ),
                              height15,
                              buttons(
                                "Yes",
                                () async {
                                  await selfCloseTicketFunction();
                                },
                              ),
                              height10,
                              buttons(
                                "No",
                                () async {
                                  await needAssistanceFunction();
                                },
                              ),
                            ],
                          )
                        : selfClosedAssistanceFlag.value == 1
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Do you need further assistance?',
                                    style: regularText20,
                                  ),
                                  height15,
                                  Row(
                                    children: [
                                      buttons(
                                        "No I'm done",
                                        () async {
                                          await needAssistanceFunction();
                                        },
                                      ),
                                      width10,
                                      const Icon(
                                        Icons.check_circle,
                                        color: Colors.green,
                                      ),
                                    ],
                                  ),
                                  height10,
                                  buttons(
                                    "Yes, I need further assistance",
                                    () async {
                                      await selfCloseTicketFunction();
                                    },
                                  ),
                                ],
                              )
                            : Column(
                                children: [
                                  if (fileName.value != '')
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(fileName.value),
                                    ),
                                  Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            child: TextFormFieldWidget(
                                              controller: messageController,
                                              hintText: "Message",
                                              onFieldSubmitted: (value) {
                                                messageController.clear();
                                              },
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () async {
                                              FocusManager.instance.primaryFocus
                                                  ?.unfocus();
                                              FilePickerResult? result =
                                                  await FilePicker.platform
                                                      .pickFiles(
                                                type: FileType.custom,
                                                allowedExtensions: [
                                                  'jpg',
                                                  'tiff',
                                                  'png',
                                                  'jpeg',
                                                  'pdf',
                                                  'doc',
                                                ],
                                              );
                                              await pickFile(
                                                result,
                                              );
                                            },
                                            icon: const Icon(Icons.attachment),
                                          ),
                                          IconButton(
                                            onPressed: () async {
                                              FocusManager.instance.primaryFocus
                                                  ?.unfocus();
                                              await sendMessage();
                                            },
                                            icon: const Icon(Icons.send),
                                          ),
                                        ],
                                      )),
                                ],
                              ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget chatView() {
    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Obx(
          () => ListView.builder(
            shrinkWrap: true,
            reverse: true,
            // controller: controller.scrollController,
            physics: const BouncingScrollPhysics(),
            itemCount: repliesList.length,
            padding: const EdgeInsets.all(10),
            itemBuilder: (BuildContext context, int index) {
              final bool isMe = repliesList[index]['sender'] != 0;

              return Row(
                mainAxisAlignment:
                    isMe ? MainAxisAlignment.start : MainAxisAlignment.end,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: isMe
                        ? CrossAxisAlignment.start
                        : CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        repliesList[index]['customer_name'],
                        style: regularText14.copyWith(
                          color: blackColor.withOpacity(0.5),
                        ),
                      ),
                      height5,
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: Get.width / 1.5,
                        ),
                        margin: const EdgeInsets.only(bottom: 5),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: isMe ? lightColor : greyColor,
                        ),
                        child: isMe
                            ? html(repliesList[index]['messages'])
                            : Text(
                                repliesList[index]['messages'],
                                maxLines: 11000000000,
                                style: regularText14.copyWith(
                                  color: isMe ? whiteColor : blackColor,
                                ),
                              ),
                      ),
                      Text(
                        repliesList[index]['message_date'],
                        style: regularText14.copyWith(
                          color: blackColor.withOpacity(0.5),
                        ),
                      ),
                      height10,
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget html(String data) {
    return Html(
      data: data,
      onAnchorTap: (url, context, attributes, element) {
        if (url != null) {
          launchUrl(Uri.parse(url));
        }
      },
      onLinkTap: (url, context, attributes, element) {
        if (url != null) {
          launchUrl(Uri.parse(url));
        }
      },
    );
  }

  Widget buttons(String title, Function()? onTap) {
    return ElevatedButton(
      onPressed: onTap,
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
        title,
        style: regularText14.copyWith(
          letterSpacing: 0.9,
          color: whiteColor,
        ),
      ),
    );
  }
}
