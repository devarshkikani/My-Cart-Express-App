import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_cart_express/e_commerce_app/constant/storage_key.dart';

class ThemeController extends GetxController {
  GetStorage box = GetStorage();
  RxBool isDarkTheme = false.obs;

  @override
  void onInit() {
    // getThemeFromStore();
    super.onInit();
  }

  RxBool get getThemeFromStore {
    final Brightness brightness =
        SchedulerBinding.instance.window.platformBrightness;
    final bool isDarkMode = brightness == Brightness.dark;

    isDarkTheme.value = box.read(StorageKey.isDarkMode) ?? isDarkMode;
    return isDarkTheme;
  }

  void _updateStoreThemeSetting(bool boolData) {
    box.write(StorageKey.isDarkMode, boolData);
    isDarkTheme.value = box.read(StorageKey.isDarkMode) ?? false;
  }

  void changeTheme({
    required bool isDarkMode,
    required ThemeMode themeMode,
  }) {
    Get.changeThemeMode(themeMode);
    _updateStoreThemeSetting(isDarkMode);
    isDarkTheme.value = isDarkMode;
  }
}
