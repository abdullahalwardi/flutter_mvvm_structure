// import 'dart:convert';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:riverpod_state/riverpod_state.dart';
// import 'package:app/data/services/clients/_clients.dart';

// part 'notifications_provider.g.dart';

// @riverpod
// class SendNotifiactionByTopic extends _$SendNotifiactionByTopic
//     with AsyncXNotifierMixin<dynamic> {
//   @override
//   BuildXCallback<dynamic> build() => idle();

//   @useResult
//   RunXCallback<dynamic> run(String topic,
//           {required String title, required String body}) =>
//       handle(() async {
//         try {
//           String serverKey =
//               "AAAAP3D52Go:APA91bFgDt5zecCmwSZcpbadMeuishqDwwzdWmdeqS7SIKTDoHYF99Sqi_y7lfH0Q1tIwDVUz0EDgmKFLf5cea2VN6gkjsl7w-N50mUhVA58rc5ewhmRkrVMlHrtHZljrnXlGJCJxK-k";
//           // final accessToken = await FirebaseAdmin.instance.app()?.options.credential
//           //     .getAccessToken();
//           // final accessToken =
//           //     await FirebaseAuth.instance.currentUser?.getIdToken();
//           // const url =
//           //     'https://fcm.googleapis.com/v1/projects/shorjah-80124/messages:send';
//           final response = await http.post(
//             Uri.parse("https://fcm.googleapis.com/fcm/send"),
//             headers: <String, String>{
//               "Content-Type": "application/json; charset=UTF-8",
//               "Authorization": "key=$serverKey"
//             },
//             body: jsonEncode({
//               'to': '/topics/$topic',
//               'data': {
//                 'via': 'FlutterFire Cloud Messaging!!!',
//               },
//               'notification': {
//                 'title': title,
//                 'body': body,
//               },
//               // "message": {
//               //   "topic": topic,
//               //   "notification": {"title": title, "body": body},
//               // }
//             }),
//           );
//           debugPrint("Response: ${response.body}");
//           await FirebaseFirestore.instance.collection("notifications").add({
//             "title": title,
//             "body": body,
//             "userId": topic == "all" ? "admin" : topic,
//             "createdDate": DateTime.now().toString(),
//           });
//         } catch (e) {
//           debugPrint("Error sending notification: $e");
//           if (e is http.ClientException) {
//             debugPrint("Response body: ${e.message}");
//           }
//         }
//       });
// }
