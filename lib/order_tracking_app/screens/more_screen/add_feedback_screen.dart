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

class AddFeedbackScreen extends StatefulWidget {
  final String id;
  const AddFeedbackScreen({super.key, required this.id});

  @override
  State<AddFeedbackScreen> createState() => _AddFeedbackScreenState();
}

class _AddFeedbackScreenState extends State<AddFeedbackScreen> {
  String? emojiStatus;

  String? ratingStatus;

  TextEditingController feedbackController = TextEditingController();

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
        Get.offAll(
          () => MainHomeScreen(
            selectedIndex: 4.obs,
          ),
        );
        NetworkDio.showSuccess(
            title: 'Suceess', sucessMessage: response['message']);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
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
                'How satisfied are you with this transaction?',
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
                    Get.offAll(
                      () => MainHomeScreen(
                        selectedIndex: 4.obs,
                      ),
                    );
                  },
                  child: const Text(
                    'Close',
                  ),
                ),
                width15,
                ElevatedButton(
                  onPressed: () {
                    saveFeedBack(widget.id);
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
