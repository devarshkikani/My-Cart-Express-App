import 'package:flutter/material.dart';
import 'package:my_cart_express/e_commerce_app/theme/app_colors.dart';

Widget dividers(double? margin, {Color? color}) {
  return Container(
    height: 1,
    color: color ?? darkGrey,
    margin: margin != null
        ? EdgeInsets.symmetric(
            vertical: margin,
          )
        : null,
  );
}
