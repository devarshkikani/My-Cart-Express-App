import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cart_express/e_commerce_app/e_controller/e_theme_controller.dart';
import 'package:my_cart_express/e_commerce_app/e_routes/e_app_pages.dart';
import 'package:my_cart_express/e_commerce_app/e_theme/e_app_theme.dart';
import 'package:my_cart_express/e_commerce_app/translations/app_translations.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<ThemeController>(
      init: ThemeController(),
      builder: (_) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: ERoutes.initial,
        themeMode: _.isDarkTheme.value ? ThemeMode.dark : ThemeMode.system,
        theme: EAppTheme.lightTheme,
        darkTheme: EAppTheme.darkTheme,
        defaultTransition: Transition.fade,
        getPages: EAppPages.pages,
        locale: const Locale('pt', 'BR'),
        translationsKeys: AppTranslation.translations,
      ),
    );
  }
}
