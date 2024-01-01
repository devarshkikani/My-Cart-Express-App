// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:my_cart_express/order_tracking_app/screens/home/main_home_screen.dart';
import 'package:my_cart_express/order_tracking_app/theme/colors.dart';
import 'package:my_cart_express/order_tracking_app/theme/text_style.dart';
import 'package:my_cart_express/order_tracking_app/utils/network_dio.dart';
import 'package:my_cart_express/order_tracking_app/constant/sizedbox.dart';
import 'package:my_cart_express/order_tracking_app/constant/app_endpoints.dart';
import 'package:my_cart_express/order_tracking_app/widget/input_text_field.dart';
import 'package:my_cart_express/e_commerce_app/e_widget/rating_bar/c_rating_bar.dart';
import 'package:my_cart_express/order_tracking_app/widget/network_image_handle.dart';

class AddFeedbackScreen extends StatefulWidget {
  final String id;
  final String staffFirstname;
  final String staffImage;
  const AddFeedbackScreen({
    super.key,
    required this.id,
    required this.staffFirstname,
    required this.staffImage,
  });

  @override
  State<AddFeedbackScreen> createState() => _AddFeedbackScreenState();
}

class _AddFeedbackScreenState extends State<AddFeedbackScreen> {
  String? emojiStatus;
  bool thanksShow = false;
  String? ratingStatus;

  TextEditingController feedbackController = TextEditingController();

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
        NetworkDio.showSuccess(
            title: 'Suceess', sucessMessage: response['message']);
        Get.offAll(
          () => MainHomeScreen(selectedIndex: 0.obs),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: thanksShow
            ? Column(
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
                    "I'm ${widget.staffFirstname}",
                    style: regularText14,
                  ),
                  height10,
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: networkImage(
                      widget.staffImage.toString(),
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
                          saveFeedBack(widget.id, context);
                        },
                        child: const Text(
                          'Submit',
                        ),
                      ),
                    ],
                  ),
                ],
              )
            : Column(
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
                  ratingButton(),
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
                          setState(() {
                            thanksShow = true;
                          });
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

  Widget ratingButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                setState(() {
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
                setState(() {
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
