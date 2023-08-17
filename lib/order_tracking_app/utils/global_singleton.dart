class GlobalSingleton {
  factory GlobalSingleton() {
    return globalSingleton;
  }
  GlobalSingleton._internal();
  static final GlobalSingleton globalSingleton = GlobalSingleton._internal();

  static String appVersion = '3.0.14';
}
