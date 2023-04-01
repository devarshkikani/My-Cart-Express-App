import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cart_express/e_commerce_app/e_controller/e_details/e_details_controller.dart';
// import 'package:shopping_cart/app/controller/home/home_controller.dart';
// import 'package:shopping_cart/app/ui/screen/details/widgets/bottom_card_widget.dart';
// import 'package:shopping_cart/app/ui/screen/details/widgets/top_card_widget.dart';
// import 'package:slimy_card/slimy_card.dart';

class EDetailsPage extends GetView<EDetailsController> {
  const EDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            width: 400,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.all(32),
            child: GetX<EDetailsController>(
              builder: (_) {
                // _.post = Get.find<HomeController>().post;
                return ListView(
                  children: const <Widget>[
                    // SlimyCard(
                    //   color: Colors.red,
                    //   width: 400,
                    //   topCardHeight: 150,
                    //   bottomCardHeight: 300,
                    //   borderRadius: 15,
                    //   topCardWidget: CardTopCustomWidget(),
                    //   bottomCardWidget: CardBottomCustomWidget(),
                    //   slimeEnabled: true,
                    // ),
                  ],
                );
              },
            )),
      ),
    );
  }
}
