import 'dart:developer';

import 'package:get_storage/get_storage.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class DynamicRepository {
  static GetStorage getStorage = GetStorage();

  Future<Uri> createDynamicLink(String uid) async {
    String url = "https://mycartexpress.page.link/Invite=$uid";
    String uriPrefix = "https://mycartexpress.page.link";
    final dynamicLinkParams = DynamicLinkParameters(
      link: Uri.parse(url),
      uriPrefix: uriPrefix,
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

    final unguessableDynamicLink =
        await FirebaseDynamicLinks.instance.buildShortLink(
      dynamicLinkParams,
      shortLinkType: ShortDynamicLinkType.short,
    );
    log(unguessableDynamicLink.shortUrl.toString());
    return unguessableDynamicLink.shortUrl;
  }

  static Future<void> initDynamicLinks() async {
    PendingDynamicLinkData? dynamicLink =
        await FirebaseDynamicLinks.instance.getInitialLink();
    log('Dynamic Link ++++ $dynamicLink');
    if (dynamicLink != null) {
      await onSuccessLink(dynamicLink);
    }
  }

  static Future<void> onSuccessLink(
    PendingDynamicLinkData? dynamicLink,
  ) async {
    if (dynamicLink != null) {
      String? query = dynamicLink.link.query;
      if (query.contains('user_id=')) {
        String invitationToken = query.split('=')[1];
        getStorage.write('inviteUserId', invitationToken);
      }
    }
  }
}
