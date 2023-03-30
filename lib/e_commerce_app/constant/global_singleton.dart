class GlobalSingleton {
  factory GlobalSingleton() {
    return globalSingleton;
  }
  GlobalSingleton._internal();
  static final GlobalSingleton globalSingleton = GlobalSingleton._internal();

  final String appVersion = '3.4';

  String? deviceToken;
}
