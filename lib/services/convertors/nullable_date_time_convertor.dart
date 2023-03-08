import 'package:freezed_annotation/freezed_annotation.dart';

class NullableDateTimeConvertor implements JsonConverter<DateTime?, String?> {
  const NullableDateTimeConvertor();

  static const String nullData = "0001-01-01T00:00:00";

  @override
  DateTime? fromJson(String? json) {
    return json == null || json == nullData || json.isEmpty
        ? null
        : DateTime.parse(json);
  }

  @override
  String? toJson(DateTime? object) {
    return object?.toIso8601String();
  }
}
