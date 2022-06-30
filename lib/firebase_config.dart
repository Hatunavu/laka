import 'package:client_tggt/services/account_services.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';

class FirebaseDeepLink {
  static final FirebaseDeepLink _firebaseDeepLink =
      FirebaseDeepLink._internal();

  factory FirebaseDeepLink() {
    return _firebaseDeepLink;
  }

  FirebaseDeepLink._internal();

  Future<void> fetchFirebaseDynamicLink() async {
    var link = await FirebaseDynamicLinks.instance.getInitialLink();

    _handleLinkData(link);

    FirebaseDynamicLinks.instance.onLink.listen((dynamicLink) {
      _handleLinkData(dynamicLink);
      // getIt.get<IToast>().show(
      //     title: dynamicLinkData.link.toString(),
      //     message: dynamicLinkData.link.queryParameters["referralId"]);
    }).onError((error) {
      debugPrint(error);
    });
  }

  void _handleLinkData(PendingDynamicLinkData? data) {
    final Uri? uri = data?.link;
    if (uri != null) {
      final queryParams = uri.queryParameters;
      if (queryParams.isNotEmpty) {
        String? referralId = queryParams["referralId"];
        print("referralId $referralId");
        AccountServices().saveReferralId(referralId ?? '');
      }
    }
  }
}
