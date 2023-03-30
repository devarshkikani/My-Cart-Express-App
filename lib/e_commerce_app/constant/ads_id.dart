import 'dart:io';

class AdsIds {
  static String interstitialVideoAdPlacementId =
      Platform.isAndroid ? 'Interstitial_Android' : 'Interstitial_iOS';
  static String rewardedVideoAdPlacementId =
      Platform.isAndroid ? 'Rewarded_Android' : 'Rewarded_iOS';
  static String bannerAdPlacementId =
      Platform.isAndroid ? 'Banner_Android' : 'Banner_iOS';

  static String gameId = Platform.isAndroid ? '5129871' : '5129870';
}
