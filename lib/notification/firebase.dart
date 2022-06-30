// import 'package:client_tggt/app.dart';
// import 'package:client_tggt/main.dart';
// import 'package:client_tggt/router/router.gr.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:get/get.dart';

// class FirebaseMessage {
//   void listenToMessage() async {

//       await Firebase.initializeApp();
//     FirebaseMessaging _messaging = FirebaseMessaging.instance;

//     NotificationSettings settings = await _messaging.requestPermission(
//       alert: true,
//       badge: true,
//       provisional: false,
//       sound: true,
//     );
//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       FirebaseMessaging.instance.getToken().then((token) {
//         print("token ${token}");
//         if (token != null) {}
//       });
//     } else {
//       print('User declined or has not accepted permission');
//     }

//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       RemoteNotification? notification = message.notification;
//       // AndroidNotification? android = message.notification?.android;
//       if (message.notification != null) {
//         if (notification != null) {
//           flutterLocalNotificationsPlugin.show(
//               notification.hashCode,
//               notification.title,
//               notification.body,
//               NotificationDetails(
//                 android: AndroidNotificationDetails(
//                   channel.id,
//                   channel.name,
//                   channelDescription: channel.description,
//                   color: Colors.blue,
//                   playSound: true,
//                   icon: '@mipmap/ic_launcher',
//                 ),
//                 iOS: const IOSNotificationDetails(),
//               ));
//         }
//       }
//     });

//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       print('A new onMessageOpenedApp event was published!');
//       RemoteNotification? notification = message.notification;
//       AndroidNotification? android = message.notification?.android;
//       final routeFromMessage = message.data["key"];
//       print("routeFromMessage: $routeFromMessage");

//       if (notification != null && android != null) {
//         print("notification title ${notification.title}");
//         print("notification.body ${notification.body}");
//         print("123");
//         Get.find<RouterController>().replace(const SigninPage());
//         print("ac");
//       }
//     });
//   }

//   // void getiOSPermission() async {
//   //   FirebaseMessaging messaging = FirebaseMessaging.instance;
//   //   NotificationSettings settings = await messaging.requestPermission(
//   //     alert: true,
//   //     announcement: false,
//   //     badge: true,
//   //     carPlay: false,
//   //     criticalAlert: false,
//   //     provisional: false,
//   //     sound: true,
//   //   );
//   //   if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//   //     print('User granted permission');
//   //   } else if (settings.authorizationStatus ==
//   //       AuthorizationStatus.provisional) {
//   //     print('User granted provisional permission');
//   //   } else {
//   //     print('User declined or has not accepted permission');
//   //   }
//   //   FirebaseMessaging.instance.getToken().then((value) => print(value));
//   // }
// }
