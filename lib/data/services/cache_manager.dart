// import 'package:path_provider/path_provider.dart';
// import 'dart:io';
// import 'package:isar/isar.dart';
// import 'package:app/data/models/post_model.dart';

// class CacheManager {
//   static const int maxCacheSize = 1000 * 1024 * 1024; // 500 MB

//   Future<void> clearCacheAndDatabase(Isar isar) async {
//     final cacheDir = await getTemporaryDirectory();
//     int currentCacheSize = 0;

//     // Get a list of files in the cache directory
//     final cacheFiles = cacheDir.listSync();

//     for (final file in cacheFiles) {
//       if (file is File) {
//         currentCacheSize += file.lengthSync();
//         if (currentCacheSize > maxCacheSize) {
//           // Delete the oldest files until cache size is within limit
//           await file.delete();

//           // Also remove the corresponding video data from Isar
//           final videoId = await getVideoIdFromFile(file);
//           if (videoId != null) {
//             final video = await isar.postSchemes
//                 .where()
//                 .isarIdEqualTo(videoId)
//                 .findFirst();
//             if (video != null) {
//               await isar.postSchemes.delete(video.isarId);
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
