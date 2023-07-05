import 'package:freezed_annotation/freezed_annotation.dart';

class NullableStringConvertor implements JsonConverter<String?, String?> {
  const NullableStringConvertor();

  static const String nullData = "00000000-0000-0000-0000-000000000000";

  @override
  String? fromJson(String? json) {
    return json == null || json.isEmpty || json == nullData ? null : json;
  }

  @override
  String? toJson(String? object) {
    return object?.toString();
  }
}