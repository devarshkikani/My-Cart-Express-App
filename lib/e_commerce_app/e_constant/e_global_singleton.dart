class EGlobalSingleton {
  factory EGlobalSingleton() {
    return globalSingleton;
  }
  EGlobalSingleton._internal();
  static final EGlobalSingleton globalSingleton = EGlobalSingleton._internal();

  final String appVersion = '3.4';

  String? deviceToken;
}
