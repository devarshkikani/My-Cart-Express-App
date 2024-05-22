import 'package:get_storage/get_storage.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:my_cart_express/order_tracking_app/utils/global_singleton.dart';

class DynamicRepository {
  GetStorage getStorage = GetStorage();
  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

  Future<Uri> createDynamicLink(String uid) async {
    final dynamicLinkParams = DynamicLinkParameters(
      link: Uri.parse("https://mycartexpress.com/Invite=$uid"),
      uriPrefix: 'https://mycartexpress.page.link',
      androidParameters: AndroidParameters(
        packageName: "com.app.MyCartExpress",
        minimumVersion: 21,
        fallbackUrl: Uri.parse(
            'https://play.google.com/store/apps/details?id=com.app.MyCartExpress'),
      ),
      iosParameters: IOSParameters(
        bundleId: "com.ios.MCart",
        appStoreId: '1624277416',
        minimumVersion: '3.0.1',
        fallbackUrl: Uri.parse(
            'https://apps.apple.com/us/app/mycart-express/id1624277416'),
      ),
    );

    final dynamicLink = await dynamicLinks.buildShortLink(dynamicLinkParams);
    return dynamicLink.shortUrl;
  }

  Future<void> initDynamicLinks() async {
    dynamicLinks.onLink.listen((PendingDynamicLinkData? dynamicLink) async {
      final Uri? deepLink = dynamicLink?.link;
      print('Received dynamic link: $deepLink');
      if (deepLink != null) {
        // Handle the deep link here
        String invitationToken = deepLink.query.split('=')[1];
        GlobalSingleton.inviteUserId = invitationToken;
      }
    }, onError: (e) async {
      print('Error processing dynamic link: ${e.message}');
    });

    // Handle initial link if app is opened via dynamic link
    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri? deepLink = data?.link;
    print('Received initial dynamic link: $deepLink');
    if (deepLink != null) {
      // Handle the deep link here
      String invitationToken = deepLink.query.split('=')[1];
      GlobalSingleton.inviteUserId = invitationToken;
    }
  }
}
