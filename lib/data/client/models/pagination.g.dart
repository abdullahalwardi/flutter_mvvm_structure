// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Pagination<T> _$$_PaginationFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    _$_Pagination<T>(
      total: json['total'] as int,
      items: (json['items'] as List<dynamic>).map(fromJsonT).toList(),
    );
