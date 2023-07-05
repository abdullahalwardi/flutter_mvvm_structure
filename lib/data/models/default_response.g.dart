// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'default_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DefaultResponse<T> _$DefaultResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    DefaultResponse<T>(
      message: json['message'] as String,
      result: fromJsonT(json['result']),
      statusCode: (json['statusCode'] as num).toDouble(),
    );

const _$RoleEnumMap = {
  Role.supervisor: 'Supervisor',
  Role.unknown: 'unknown',
};
