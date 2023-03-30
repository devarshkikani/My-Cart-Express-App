import 'package:flutter/material.dart';
import 'package:my_cart_express/e_commerce_app/theme/color_scheme.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    colorScheme: lightColorScheme,
    fontFamily: 'Poppins',
    useMaterial3: true,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, ZoomPageTransitionsBuilder>{
        TargetPlatform.android: ZoomPageTransitionsBuilder(),
      },
    ),
  );
  static final ThemeData darkTheme = ThemeData(
    colorScheme: darkColorScheme,
    fontFamily: 'Poppins',
    useMaterial3: true,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, ZoomPageTransitionsBuilder>{
        TargetPlatform.android: ZoomPageTransitionsBuilder(),
      },
    ),
  );
}
