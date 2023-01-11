import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:my_cart_express/constant/app_endpoints.dart';
import 'package:my_cart_express/constant/sizedbox.dart';
import 'package:my_cart_express/theme/colors.dart';
import 'package:my_cart_express/theme/text_style.dart';
import 'package:my_cart_express/utils/network_dio.dart';
import 'package:my_cart_express/widget/app_bar_widget.dart';

class MyRewardsScreen extends StatefulWidget {
  const MyRewardsScreen({super.key});

  @override
  State<MyRewardsScreen> createState() => _MyRewardsScreenState();
}

class _MyRewardsScreenState extends State<MyRewardsScreen> {
  RxString link = ''.obs;
  @override
  void initState() {
    getUserRewards();
    super.initState();
  }

  Future<void> getUserRewards() async {
    Map<String, dynamic>? response = await NetworkDio.getDioHttpMethod(
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.userRewards,
      context: context,
    );
    if (response != null) {
      link.value = response['message'];
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'My Rewards',
              style: regularText18,
            ),
          ],
        ),
        height20,
        Text(
          'Referral Link',
          style: regularText16,
        ),
        height10,
        Container(
          width: Get.width,
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 20,
          ),
          decoration: BoxDecoration(
            color: greyColor.withOpacity(0.5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Click copy to the referral to your clipboard',
              ),
              height10,
              Container(
                width: Get.width,
                padding: const EdgeInsets.all(
                  10,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: whiteColor,
                  border: Border.all(
                    color: Colors.grey,
                  ),
                ),
                child: Obx(() => Text(
                      link.value,
                      style: lightText13.copyWith(
                        color: primary,
                      ),
                    )),
              ),
              height10,
              GestureDetector(
                onTap: () async {
                  await Clipboard.setData(
                    ClipboardData(text: link.value),
                  );
                  Get.snackbar(
                    'Link Copied',
                    '',
                    snackPosition: SnackPosition.BOTTOM,
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.all(15),
                    messageText: const SizedBox(),
                  );
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Copy',
                    style: regularText14.copyWith(
                      color: primary,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
