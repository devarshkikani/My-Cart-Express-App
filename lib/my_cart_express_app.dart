import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:my_cart_express/splash_screen.dart';
import 'package:my_cart_express/theme/colors.dart';

final GlobalKey<NavigatorState> navigatorKey =
    GlobalKey<NavigatorState>(debugLabel: "navigator");

class MyCartExpressApp extends StatelessWidget {
  const MyCartExpressApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'My Cart Express',
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      theme: ThemeData(
        fontFamily: 'Roboto',
        primaryColor: primary,
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: primary,
          onPrimary: whiteColor,
          secondary: secondary,
          onSecondary: whiteColor,
          error: error,
          onError: error,
          background: background,
          onBackground: whiteColor,
          surface: surface,
          onSurface: surface,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
