class GlobalSingleton {
  factory GlobalSingleton() {
    return globalSingleton;
  }
  GlobalSingleton._internal();
  static final GlobalSingleton globalSingleton = GlobalSingleton._internal();

  static String appVersion = '3.0.16';
  static int showRatingPopup = 0;
  static int showUnopenedSupportmessage = 0;
}
