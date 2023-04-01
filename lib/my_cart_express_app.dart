import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:my_cart_express/e_commerce_app/e_controller/e_theme_controller.dart';
import 'package:my_cart_express/e_commerce_app/e_routes/e_app_pages.dart';
import 'package:my_cart_express/e_commerce_app/e_theme/e_app_theme.dart';
import 'package:my_cart_express/order_tracking_app/theme/theme.dart';
import 'package:my_cart_express/splash_screen.dart';

final GlobalKey<NavigatorState> navigatorKey =
    GlobalKey<NavigatorState>(debugLabel: "navigator");

class MyCartExpressApp extends StatelessWidget {
  const MyCartExpressApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<ThemeController>(
      init: ThemeController(),
      builder: (_) => GetMaterialApp(
        title: 'My Cart Express',
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        getPages: EAppPages.pages,
        themeMode: _.isECommerce.value
            ? _.isDarkTheme.value
                ? ThemeMode.dark
                : ThemeMode.system
            : ThemeMode.system,
        theme: _.isECommerce.value ? EAppTheme.lightTheme : AppTheme.lightTheme,
        darkTheme:
            _.isECommerce.value ? EAppTheme.darkTheme : AppTheme.lightTheme,
        home: const SplashScreen(),
      ),
    );
  }
}
