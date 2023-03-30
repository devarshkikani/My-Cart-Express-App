import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:my_cart_express/e_commerce_app/controller/details/details_controller.dart';
import 'package:my_cart_express/e_commerce_app/screen/widgets/button_widget.dart';

class CardBottomButtonsWidget extends StatelessWidget {
  const CardBottomButtonsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        GetX<DetailsController>(
          builder: (_) {
            return RaisedButtonCustomWidget(
              icon: Icons.delete_outline,
              onPressed: () => _.delete(_.post.id),
              text: 'Delete',
            );
          },
        ),
        GetX<DetailsController>(
          builder: (_) {
            return RaisedButtonCustomWidget(
              icon: Icons.edit,
              onPressed: () => _.editar(_.post),
              text: 'Editar',
            );
          },
        )
      ],
    );
  }
}
