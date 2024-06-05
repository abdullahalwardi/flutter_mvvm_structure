// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginatedResponse<T> _$PaginatedResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    PaginatedResponse<T>(
      result: (json['result'] as List<dynamic>).map(fromJsonT).toList(),
      count: (json['count'] as num).toInt(),
      message: json['message'] as String,
      statusCode: (json['statusCode'] as num).toInt(),
    );
