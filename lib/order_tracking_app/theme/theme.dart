import 'package:flutter/material.dart';
import 'package:my_cart_express/order_tracking_app/theme/color_scheme.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    colorScheme: lightColorScheme,
    fontFamily: 'roboto',
    // useMaterial3: true,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, ZoomPageTransitionsBuilder>{
        TargetPlatform.android: ZoomPageTransitionsBuilder(),
      },
    ),
  );
}
