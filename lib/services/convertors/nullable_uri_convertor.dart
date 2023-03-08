import 'package:freezed_annotation/freezed_annotation.dart';

class NullableUriConvertor implements JsonConverter<Uri?, String?> {
  const NullableUriConvertor();

  static const List<String> nullData = [
    "#",
    "https://tashgheel-api.lab-logic.com/CoverPhoto/"
  ];

  @override
  Uri? fromJson(String? json) {
    return json == null || nullData.contains(json) || json.isEmpty
        ? null
        : Uri.tryParse(json);
  }

  @override
  String? toJson(Uri? object) {
    return object?.toString() ?? "#";
  }
}
