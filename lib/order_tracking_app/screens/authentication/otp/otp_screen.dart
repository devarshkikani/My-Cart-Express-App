import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cart_express/e_commerce_app/e_constant/e_sizedbox.dart';
import 'package:my_cart_express/e_commerce_app/e_theme/e_app_text_theme.dart';
import 'package:my_cart_express/order_tracking_app/constant/default_images.dart';
import 'package:my_cart_express/order_tracking_app/screens/authentication/otp/otp_controller.dart';
import 'package:my_cart_express/order_tracking_app/theme/colors.dart';
import 'package:my_cart_express/order_tracking_app/widget/app_bar_widget.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends GetView<OtpController> {
  final String mobileNumber;
  OtpScreen({super.key, required this.mobileNumber});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController otp = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarWidget(title: 'OTP'),
      body: GetBuilder<OtpController>(
        init: OtpController(),
        builder: (controller) {
          return Center(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(30),
                      child: Image.asset(
                        appLogoColorfull,
                        height: 40,
                      ),
                    ),
                    height20,
                    const Text(
                      'OTP Verification',
                      style: regularText20,
                    ),
                    height30,
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        "We have sent the verification code to your email address.",
                        style: regularText16,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    height10,
                    Text(
                      mobileNumber,
                      style: mediumText16,
                      textAlign: TextAlign.center,
                    ),
                    height30,
                    Pinput(
                      pinAnimationType: PinAnimationType.slide,
                      showCursor: true,

                      controller: otp,
                      cursor: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: 56,
                              height: 3,
                              decoration: BoxDecoration(
                                  color: primary,
                                  borderRadius: BorderRadius.circular(8)),
                            )
                          ]),
                      // preFilledWidget: Container(
                      //   width: 56,
                      //   height: 3,
                      //   color: ,
                      //   // decoration: BoxDecoration(
                      //   //     color: primary,
                      //   //     borderRadius: BorderRadius.circular(8)
                      //   //     ),
                      // ),
                      closeKeyboardWhenCompleted: true,
                      defaultPinTheme: PinTheme(
                        width: 56,
                        height: 56,
                        textStyle: const TextStyle(
                            fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1)),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: primary.withOpacity(0.2),
                        ),
                      ),
                      submittedPinTheme: PinTheme(
                          width: 56,
                          height: 56,
                          textStyle: const TextStyle(
                              fontSize: 20,
                              color: Color.fromRGBO(30, 60, 87, 1)),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: primary.withOpacity(0.3),
                          )),
                      length: 6,
                    ),
                    height30,
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(250, 40),
                        maximumSize: Size(Get.width, 50),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                      ),
                      onPressed: () {
                        controller.signInOnTap(otp: otp.text, context: context);
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(  
                          horizontal: 20,
                        ),
                        child: Text(
                          'Submit',
                          style: TextStyle(
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
