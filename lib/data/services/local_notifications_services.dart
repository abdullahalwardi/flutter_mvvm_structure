// import 'dart:convert';

// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// abstract class LocalNotificationsServices {
//   const LocalNotificationsServices();
//   static Future<void> initalize() async {
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('mipmap/ic_launcher');
//     DarwinInitializationSettings initializationSettingsDarwin =
//         DarwinInitializationSettings(
//       onDidReceiveLocalNotification: (id, title, body, payload) async {
//         final details = await _notificationDetails();
//        await FlutterLocalNotificationsPlugin()
//             .show(id, title, body, details, payload: payload);
//       },
//     );
//     const LinuxInitializationSettings initializationSettingsLinux =
//         LinuxInitializationSettings(defaultActionName: 'Open notification');
//      InitializationSettings initializationSettings =
//         InitializationSettings(
//             android: initializationSettingsAndroid,
//             iOS: initializationSettingsDarwin,
//             linux: initializationSettingsLinux);
//     await FlutterLocalNotificationsPlugin().initialize(initializationSettings);
//   }

//   static Future<NotificationDetails> _notificationDetails() async {
//     const AndroidNotificationDetails androidNotificationDetails =
//         AndroidNotificationDetails("channel_id", "MainNotifications",
//             channelDescription: "Main Notifications",
//             priority: Priority.max,
//             importance: Importance.max,
//             playSound: true);
//     const DarwinNotificationDetails iosNotificationDetails =
//         DarwinNotificationDetails();

//     return const NotificationDetails(
//         android: androidNotificationDetails, iOS: iosNotificationDetails);
//   }

//   static Future<void> showNotification(RemoteMessage message) async {
//     final details = await _notificationDetails();
//     await FlutterLocalNotificationsPlugin().show(
//         3, message.notification?.title, message.notification?.body, details,
//         payload: jsonEncode(message.data));
//   }
// }
