import 'dart:developer';
import 'package:client_tggt/services/account_services.dart';

import 'package:firebase_messaging/firebase_messaging.dart';

void registerNotification(void Function(RemoteMessage message) onInactive,
    void Function(RemoteMessage message) onActive) async {
  FirebaseMessaging _messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await _messaging.requestPermission(
    alert: true,
    badge: true,
    provisional: false,
    sound: true,
  );

  _messaging.getInitialMessage().then((value) {
    if (value != null) {
      onInactive(value);
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    onInactive(message);
  });

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    FirebaseMessaging.instance.getToken().then((token) async {
      if (token != null) {
        // ignore: unnecessary_null_comparison
        AccountServices().saveNotificationToken(token);
      }
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      onActive(message);
    });
  } else {
    log('User declined or has not accepted permission');
  }
}
