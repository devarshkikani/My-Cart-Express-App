import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cart_express/e_commerce_app/e_controller/e_details/e_details_controller.dart';
import 'package:my_cart_express/e_commerce_app/e_theme/e_app_text_theme.dart';

class ECardBottomCustomWidget extends StatelessWidget {
  const ECardBottomCustomWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: GetX<EDetailsController>(
                  builder: (_) => Text(
                        _.post.body ?? '',
                        style: regularText16,
                      )),
            ),
          ),
        ],
      ),
    );
  }
}
