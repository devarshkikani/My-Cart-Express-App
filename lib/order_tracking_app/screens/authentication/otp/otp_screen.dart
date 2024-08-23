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
  OtpScreen({super.key});

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
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(30),
                      child: Image.asset(
                        appLogoColorfull,
                      ),
                    ),
                    height30,
                    const Text(
                      'ENTER YOUR OTP',
                      style: regularText20,
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
                      preFilledWidget: Column(
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
                      closeKeyboardWhenCompleted: true,
                      submittedPinTheme: const PinTheme(
                          width: 56,
                          height: 56,
                          textStyle: TextStyle(
                              fontSize: 20,
                              color: Color.fromRGBO(30, 60, 87, 1)),
                          decoration: BoxDecoration()),
                      length: 6,
                    ),
                    height20,
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        maximumSize: Size(Get.width, 50),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                      ),
                      onPressed: () {
                        // if (_formKey.currentState!.validate()) {
                        //   controller.signInOnTap(
                        //     email: emailId.text.trim(),
                        //     password: password.text.trim(),
                        //     context: context,
                        //   );
                        // }
                        controller.signInOnTap(otp: otp.text, context: context);
                      },
                      child: const Text(
                        'VERIFY',
                        style: TextStyle(
                          letterSpacing: 1,
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
