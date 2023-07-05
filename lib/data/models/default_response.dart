import 'package:app/data/models/json_types.dart';
import 'package:json_annotation/json_annotation.dart';

part 'default_response.g.dart';

@JsonSerializable(
  createToJson: false,
  explicitToJson: true,
  genericArgumentFactories: true,
)
class DefaultResponse<T> {
  // "message": "تم بنجاح",
  final String message;
  // "result": {},
  final T result;
  // "statusCode": 200
  final double statusCode;

  const DefaultResponse({
    required this.message,
    required this.result,
    required this.statusCode,
  });

  factory DefaultResponse.fromJson(
          Map<String, dynamic> json, FromJsonT<T> fromJsonT) =>
      _$DefaultResponseFromJson<T>(json, fromJsonT);

  DefaultResponse<T> copyWith({
    final String? message,
    // "data": {},
    final T? result,
    // "error": true
    final double? statusCode,
  }) {
    return DefaultResponse<T>(
        message: message ?? this.message,
        result: result ?? this.result,
        statusCode: statusCode ?? this.statusCode);
  }
}

@JsonEnum(alwaysCreate: true)
enum Role {
  @JsonValue("Supervisor")
  supervisor,
  unknown;

  String toJson() => _$RoleEnumMap[this]!;
}
