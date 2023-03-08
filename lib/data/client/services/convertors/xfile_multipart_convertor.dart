import 'dart:io';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:json_annotation/json_annotation.dart';

class XFileMultipartConvertor implements JsonConverter<XFile, MultipartFile> {
  const XFileMultipartConvertor();

  // ignored
  @override
  XFile fromJson(MultipartFile json) {
    return XFile(json.filename ?? "");
  }

  @override
  MultipartFile toJson(XFile object) {
    return MultipartFile.fromFileSync(
      object.path,
      filename: object.path.split(Platform.pathSeparator).last,
    );
  }
}
