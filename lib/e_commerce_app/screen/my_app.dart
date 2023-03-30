import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cart_express/e_commerce_app/controller/theme_controller.dart';
import 'package:my_cart_express/e_commerce_app/routes/app_pages.dart';
import 'package:my_cart_express/e_commerce_app/theme/app_theme.dart';
import 'package:my_cart_express/e_commerce_app/translations/app_translations.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<ThemeController>(
      init: ThemeController(),
      builder: (_) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.initial,
        themeMode: _.isDarkTheme.value ? ThemeMode.dark : ThemeMode.system,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        defaultTransition: Transition.fade,
        getPages: AppPages.pages,
        locale: const Locale('pt', 'BR'),
        translationsKeys: AppTranslation.translations,
      ),
    );
  }
}
