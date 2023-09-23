// import 'dart:convert';

// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class LocalNotificationsServices {
//   const LocalNotificationsServices();
//   Future<void> initalize() async {
//     const AndroidInitializationSettings initializationSettingsAndroid =
//     AndroidInitializationSettings('mipmap/ic_launcher');
// const DarwinInitializationSettings initializationSettingsDarwin =
//     DarwinInitializationSettings();
// const LinuxInitializationSettings initializationSettingsLinux =
//     LinuxInitializationSettings(
//         defaultActionName: 'Open notification');
// const InitializationSettings initializationSettings = InitializationSettings(
//     android: initializationSettingsAndroid,
//     iOS: initializationSettingsDarwin,
//     linux: initializationSettingsLinux);
//  await FlutterLocalNotificationsPlugin().initialize(initializationSettings);
//   }

//   Future<NotificationDetails> _notificationDetails() async {
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

//   Future<void> showNotification(RemoteMessage message) async {
//     final details = await _notificationDetails();
//     await FlutterLocalNotificationsPlugin().show(
//         3, message.data["title"], message.data["body"], details,
//         payload: jsonEncode(message.data));
//   }
  
// }
