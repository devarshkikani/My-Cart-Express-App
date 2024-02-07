// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cart_express/e_commerce_app/e_widget/rating_bar/c_rating_bar.dart';
import 'package:my_cart_express/order_tracking_app/constant/app_endpoints.dart';
import 'package:my_cart_express/order_tracking_app/constant/sizedbox.dart';
import 'package:my_cart_express/order_tracking_app/theme/colors.dart';
import 'package:my_cart_express/order_tracking_app/theme/text_style.dart';
import 'package:my_cart_express/order_tracking_app/utils/global_singleton.dart';
import 'package:my_cart_express/order_tracking_app/utils/network_dio.dart';
import 'package:my_cart_express/order_tracking_app/widget/input_text_field.dart';
import 'package:my_cart_express/order_tracking_app/widget/network_image_handle.dart';

RxBool isPopShown = false.obs;

class ShowFeedBackPopup {
  RxString emojiStatus = ''.obs;
  RxString ratingStatus = ''.obs;
  TextEditingController feedbackController = TextEditingController();
  Future<void> callApi({required BuildContext context}) async {
    Map<String, dynamic>? response = await NetworkDio.getDioHttpMethod(
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.getFeedbackNotAdded,
    );
    if (response != null) {
      if (response['data'].isNotEmpty) {
        saveUserFeedbackPopup(
          id: response['data']['ref_id'],
        );
        feedBackDialoag(
          context: context,
          id: response['data']['ref_id'],
          staffName: response['data']['staff_firstname'],
          staffImage: response['data']['staff_image'],
        );
      }
    }
  }

  Future<void> saveUserFeedbackPopup({
    required String id,
  }) async {
    await NetworkDio.postDioHttpMethod(
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.saveUserFeedbackPopup,
      data: dio.FormData.fromMap(
        {
          'transaction_id': id,
          'customer_id': GlobalSingleton.userDetails['user_id'],
        },
      ),
    );
  }

  void feedBackDialoag({
    required BuildContext context,
    required String id,
    required String staffName,
    required String staffImage,
  }) {
    log('FEEDBACK POP SHOW');
    isPopShown.value = true;
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
                        if (emojiStatus.value == '') {
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
                        thankYouDialogWithPhoto(
                            context: context,
                            id: id,
                            staffImage: staffImage,
                            staffName: staffName);
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

  void thankYouDialogWithPhoto({
    required BuildContext context,
    required String id,
    required String staffName,
    required String staffImage,
  }) {
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
                  "You were you assisted by $staffName.",
                  style: regularText14,
                ),
                height10,
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: networkImage(
                    staffImage,
                    fit: BoxFit.cover,
                    height: 100,
                    width: 100,
                  ),
                ),
                height10,
                Text(
                  'How was my service?',
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
                        saveFeedBack(id, ctx);
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

  Future<void> saveFeedBack(String id, BuildContext ctx) async {
    if (ratingStatus.value == '') {
      Get.showSnackbar(
        const GetSnackBar(
          message: 'Add how do you rate your Driver/Cashier interraction?',
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
        context: ctx,
        data: data,
      );
      if (response != null) {
        emojiStatus.value = '';
        ratingStatus.value = '';
        feedbackController = TextEditingController();
        NetworkDio.showSuccess(
            title: 'Suceess', sucessMessage: response['message']);
      }
      isPopShown.value = false;
      Navigator.pop(ctx);
    }
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
                  emojiStatus.value = 'Satisfied';
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: emojiStatus.value == 'Satisfied'
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
                  color: emojiStatus.value == 'Satisfied'
                      ? whiteColor
                      : blackColor,
                ),
              ),
            ),
          ),
          width10,
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                set(() {
                  emojiStatus.value = 'Unsatisfied';
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: emojiStatus.value == 'Unsatisfied'
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
                  color: emojiStatus.value == 'Unsatisfied'
                      ? whiteColor
                      : blackColor,
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
          ratingStatus.value = rating.toString();
        },
        updateOnDrag: true,
      ),
    );
  }
}
