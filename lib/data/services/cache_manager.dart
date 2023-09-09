// import 'package:flutter/foundation.dart';
// import 'package:path_provider/path_provider.dart';
// import 'dart:io';
// import 'package:isar/isar.dart';
// import 'package:app/data/models/post_model.dart';
// import 'package:app/data/services/file_plugin.dart';

// class CacheManager {
//   static const int maxCacheSize = 1000 * 1024 * 1024; // 1000 MB

//   Future<void> clearCacheAndDatabase(Isar isar) async {
//     final cacheDir = await FilePlugin().getAppTemporaryDirectory();
//     int currentCacheSize = 0;

//     // Get a list of files in the cache directory
//     final cacheFiles = cacheDir?.listSync();

//     if (cacheFiles != null) {
//       for (final file in cacheFiles) {
//         if (file is File) {
//           currentCacheSize += file.lengthSync();
//           if (currentCacheSize > maxCacheSize) {
//             // Delete the oldest files until cache size is within limit


//             // Also remove the corresponding video data from Isar
//             final videoId = await getVideoIdFromFile(file);
//             if (videoId != null) {
//               final video =
//                   await isar.postSchemes.where().idEqualTo(videoId).findFirst();
//               if (video != null && video.id != null) {
//                 await isar.postSchemes.delete(video.id!);
//                 await file.delete();
//                 debugPrint("video deleted from cache: ${video.id}");
//               }
//             }
//           }
//         }
//       }
//     }
//   }

//   Future<int?> getVideoIdFromFile(File file) async {
//     final tempDir = await getTemporaryDirectory();
//     return int.tryParse(
//         file.path.replaceAll(tempDir.path, "").replaceAll(".mp4", ""));
//   }
// }
