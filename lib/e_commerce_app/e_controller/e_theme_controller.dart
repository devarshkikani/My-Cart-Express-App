import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_cart_express/e_commerce_app/e_constant/e_storage_key.dart';
import 'package:my_cart_express/order_tracking_app/constant/storage_key.dart';

class ThemeController extends GetxController {
  GetStorage box = GetStorage();
  RxBool isDarkTheme = false.obs;
  RxBool isECommerce = false.obs;

  @override
  void onInit() {
    // getThemeFromStore();
    getAppFromStore();
    super.onInit();
  }

  RxBool get getThemeFromStore {
    final Brightness brightness =
        SchedulerBinding.instance.window.platformBrightness;
    final bool isDarkMode = brightness == Brightness.dark;

    isDarkTheme.value = box.read(EStorageKey.eIsDarkMode) ?? isDarkMode;
    return isDarkTheme;
  }

  RxBool get getAppFromStore {
    isECommerce.value = box.read(StorageKey.isECommerce) ?? false;
    return isDarkTheme;
  }

  void _updateStoreThemeSetting(bool boolData) {
    box.write(EStorageKey.eIsDarkMode, boolData);
    isDarkTheme.value = box.read(EStorageKey.eIsDarkMode) ?? false;
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
