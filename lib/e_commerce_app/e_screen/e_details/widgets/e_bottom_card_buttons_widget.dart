import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:my_cart_express/e_commerce_app/e_controller/e_details/e_details_controller.dart';
import 'package:my_cart_express/e_commerce_app/e_screen/e_widgets/e_button_widget.dart';

class ECardBottomButtonsWidget extends StatelessWidget {
  const ECardBottomButtonsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        GetX<EDetailsController>(
          builder: (_) {
            return ERaisedButtonCustomWidget(
              icon: Icons.delete_outline,
              onPressed: () => _.delete(_.post.id),
              text: 'Delete',
            );
          },
        ),
        GetX<EDetailsController>(
          builder: (_) {
            return ERaisedButtonCustomWidget(
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
