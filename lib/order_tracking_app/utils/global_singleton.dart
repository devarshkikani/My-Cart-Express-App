import 'package:package_info_plus/package_info_plus.dart';

class GlobalSingleton {
  factory GlobalSingleton() {
    return globalSingleton;
  }
  GlobalSingleton._internal();
  static final GlobalSingleton globalSingleton = GlobalSingleton._internal();

  static PackageInfo? packageInfo;
  static String? inviteUserId;
  static Map userDetails = {};
}
