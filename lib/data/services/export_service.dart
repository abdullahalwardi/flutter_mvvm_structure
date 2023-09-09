// import 'dart:developer';
// import 'dart:io';

// import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
// import 'package:ffmpeg_kit_flutter/ffmpeg_kit_config.dart';
// import 'package:ffmpeg_kit_flutter/ffmpeg_session.dart';
// import 'package:ffmpeg_kit_flutter/return_code.dart';
// import 'package:ffmpeg_kit_flutter/statistics.dart';
// import 'package:flutter/material.dart';
// import 'package:video_editor/video_editor.dart';

// class ExportService {
//   static Future<void> dispose() async {
//     final executions = await FFmpegKit.listSessions();
//     if (executions.isNotEmpty) await FFmpegKit.cancel();
//   }

//   static Future<FFmpegSession> runFFmpegCommand(
//     FFmpegVideoEditorExecute execute, {
//     required void Function(File file) onCompleted,
//     void Function(Object, StackTrace)? onError,
//     void Function(Statistics)? onProgress,
//   }) async {
//     log('FFmpeg start process with command = ${execute.command}');
//     final ffSession = await FFmpegKit.executeAsync(
//       execute.command,
//       (session) async {
//         final state =
//             FFmpegKitConfig.sessionStateToString(await session.getState());
//         final code = await session.getReturnCode();
//         final output = await session.getOutput(); // Capture the FFmpeg output

//         debugPrint("FFmpeg Output: $output"); // Print the FFmpeg output

//         if (ReturnCode.isSuccess(code)) {
//           onCompleted(File(execute.outputPath));
//         } else {
//           if (onError != null) {
//             onError(
//               Exception(
//                   'FFmpeg process exited with state $state and return code $code.\n${output ?? ''}'),
//               StackTrace.current,
//             );
//           }
//           return;
//         }
//       },
//       null,
//       onProgress,
//     );
//     return ffSession;
//   }

//   Future<File> mergeAudioAndVideo(
//       String videoFilePath, String audioFilePath, String outputFilePath) async {
//     // FFmpeg command to remove original audio from video, add new audio, and trim audio to fit video length
//     String ffmpegCommand =
//         '-y -i $videoFilePath -i $audioFilePath -c:v copy -c:a aac -strict experimental -map 0:v:0 -map 1:a:0 -shortest $outputFilePath';

//     // Execute the FFmpeg command
//     await runFFmpegCommand(
//       FFmpegVideoEditorExecute(
//           command: ffmpegCommand, outputPath: outputFilePath),
//       onCompleted: (file) {
//         debugPrint('FFmpeg process completed successfully');
//       },
//       onProgress: (p0) {
//         debugPrint('FFmpeg process progress ${p0.getTime()}');
//       },
//     );

//     return Future.value(File(outputFilePath));
//     // In this code:
// // -y overwrites the output file if it exists.
// // -i $videoFilePath and -i $audioFilePath specify the input video and audio files.
// // -c:v copy and -c:a aac -strict experimental specify the codecs to use for the video and audio streams.
// // -map 0:v:0 -map 1:a:0 map the video and audio streams from the input files to the output file.
// // -shortest trims the audio to fit the length of the video.
// // -an flag is used to remove the audio from the input video.
//   }
// }
