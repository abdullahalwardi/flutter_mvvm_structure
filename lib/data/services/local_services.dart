import 'package:app/data/services/clients/callback.dart';
import 'package:app/utils/extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:url_launcher/url_launcher_string.dart';

Future<void> fetchPage<T>(
  {
  int? pageKey,
  required PagingController<int, T> pagingController,
  required FuturePaginatedResponse<T> futureItems,
  String? pageSize,
  }
) async {
  try {
    final newItems = await futureItems;
    final items = newItems.data.result;
    final isLastPage = items.length < int.parse(pageSize ?? "25");

    if (isLastPage) {
      pagingController.appendLastPage(items);
    } else {
      final nextPageKey = pageKey ?? 0 + items.length;
      pagingController.appendPage(items, nextPageKey);
    }
  } catch (error) {
    pagingController.error = error;
  }
}

Future<void> launchNotNullUrlString(String? url, {VoidCallback? orElse}) async {
  if (url != null && (url.contains("https") || url.contains("http"))) {
    launchUrlString(url, mode: LaunchMode.externalApplication);
  } else {
    orElse?.call();
  }
}

Future<void> openCall(String phoneNumber) async {
  try {
    await launchUrlString("tel:$phoneNumber");
  } catch (_) {
    if (kDebugMode) print("error: tel:$phoneNumber");
  }
}

Future<void> openMail(String mail) async {
  try {
    await launchUrlString("mailto:$mail");
  } catch (_) {
    if (kDebugMode) print("error: mailto:$mail");
  }
}

Future<void> openSMSMessage(String phoneNumber, {String? message}) async {
  var uri = 'sms:$phoneNumber';
  if (message != null) uri += "?body=$message";
  if (await canLaunchUrlString(uri)) await launchUrlString(uri);
}

Future<CroppedFile?> cropImage(BuildContext context) async {
  final result = await ImagePicker().pickImage(source: ImageSource.gallery);

  final theme = Theme.of(context);
  return await ImageCropper().cropImage(
    sourcePath: result!.path,
    uiSettings: [
      AndroidUiSettings(
        toolbarTitle: context.l10n.crop,
        statusBarColor: theme.colorScheme.primary,
        toolbarColor: theme.colorScheme.primary,
        cropGridColor: theme.colorScheme.outline,
        backgroundColor: theme.colorScheme.surface,
        activeControlsWidgetColor: theme.colorScheme.primary,
        toolbarWidgetColor: theme.colorScheme.onPrimary,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: false,
      ),
      IOSUiSettings(
        title: context.l10n.crop,
      )
    ],
  );
}

String splitMoney(double value) {
  return value.toStringAsFixed(0).splitMapJoin(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        onMatch: (m) => '${m[1]},',
      );
}

List<DateTime> getDates(DateTime fromDate, DateTime toDate) {
  List<DateTime> dateList = [];
  for (int i = 0; i <= toDate.difference(fromDate).inDays; i++) {
    dateList.add(fromDate.add(Duration(days: i)));
  }
  return dateList;
}

 double calculateProgress(double value, double end) {
    if(value == 0) return 0;

    final x = value * 100;
    return x / end;
  }

  int getMonthsDifference(DateTime startDate, DateTime endDate) {
    int months = (endDate.year - startDate.year) * 12 + endDate.month - startDate.month;

    // Check if there are any remaining days in the last month
    if (endDate.day >= startDate.day) {
      months += 1;
    }

    return months;
  }

/// FNV-1a 64bit hash algorithm optimized for Dart Strings
int fastHash(String string) {
  var hash = 0xcbf29ce484222325;

  var i = 0;
  while (i < string.length) {
    final codeUnit = string.codeUnitAt(i++);
    hash ^= codeUnit >> 8;
    hash *= 0x100000001b3;
    hash ^= codeUnit & 0xFF;
    hash *= 0x100000001b3;
  }

  return hash;
}

String getCompletedPhoneNumber(String phoneNumber, String countryCode) {
  if (phoneNumber.startsWith("0")) {
    return phoneNumber.replaceFirst("0", countryCode);
  }else{
    return "$countryCode$phoneNumber";
  }
}


String getEncodedComponent(String component) => Uri.encodeComponent(component);

// Future<void> initializeFirebaseMessaging() async {
//   FirebaseMessaging messaging = FirebaseMessaging.instance;

//   await messaging.requestPermission();

//   // Retrieve the FCM token
//   Future<void> retrieveFCMAndAPNsToken() async {
//     // Request permission for remote notifications
//     await messaging.requestPermission();

//     // Retrieve the FCM token
//     final fcmToken = await messaging.getToken();
//     final apnsToken = await messaging.getAPNSToken();
//     debugPrint('FCM Token: $fcmToken');
//     debugPrint('APNs Token: $apnsToken');
//   }

//   await retrieveFCMAndAPNsToken();

//   await messaging.subscribeToTopic("all");


// }

// Widget handleSnapshotState<T>(
//   BuildContext context,
//   AsyncSnapshot<T?> snapshot, {
//   required Widget Function() onLoading,
//   required Widget Function(Object?) onError,
//   required Widget Function(T?) onData,
// }) {
//   if (snapshot.connectionState == ConnectionState.waiting) {
//           return onLoading();
//         } else if (snapshot.hasError) {
//           return onError(snapshot.error);
//         } else if (snapshot.hasData) {
//           return onData(snapshot.data);
//         } else {
//           return onLoading();
//         }
// }

// Widget handleQueryBuilderSnapshotState<T>(
//   BuildContext context,
//   FirestoreQueryBuilderSnapshot<T> snapshot, {
//   required Widget Function() onLoading,
//   required Widget Function(Object?) onError,
//   required Widget Function(List<QueryDocumentSnapshot<T>>) onData,
// }) {
//   if (snapshot.isFetching) {
//           return onLoading();
//         } else if (snapshot.hasError) {
//           return onError(snapshot.error);
//         } else if (snapshot.hasData) {
//           return onData(snapshot.docs);
//         } else {
//           return onLoading();
//         }
// }

// Widget buildError(BuildContext context, Object? error) {
//   debugPrint(error.toString());
//   if (error is FirebaseException) {
//     return Center(
//         child: Text(error.message ?? context.l10n.defaultErrorMessage));
//   } else {
//     return Center(
//         child: Text(error?.toString() ?? context.l10n.defaultErrorMessage));
//   }
// }

// void handleErrorMessageSnackBar(BuildContext context, Object? error){
//   if(error is FirebaseException){
//     context.showErrorSnackBar(error.message ?? context.l10n.defaultErrorMessage);
//   }else{
//     context.showErrorSnackBar(error?.toString() ?? context.l10n.defaultErrorMessage);
//   }
// }

// String getImageFromYoutubeUrl(String url) {
//   String? id = YoutubePlayer.convertUrlToId(url);
//   if (id != null) {
//     return "https://img.youtube.com/vi/$id/0.jpg";
//   }
//   return "";
// }

// Future<Uint8List?> convertWidgetToImage(GlobalKey globalKey) async {
//   RenderRepaintBoundary boundary =
//       globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
//   ui.Image image = await boundary.toImage(pixelRatio: 100);
//   ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
//   Uint8List? pngBytes = byteData?.buffer.asUint8List();
//   return pngBytes;
// }