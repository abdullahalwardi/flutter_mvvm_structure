// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app/data/models/json_types.dart';
import 'package:app/data/models/paginated.dart';
import 'package:json_annotation/json_annotation.dart';

part "paginated_response.g.dart";

@JsonSerializable(genericArgumentFactories: true, createToJson: false)
class PaginatedResponse<T> implements Paginated<T> {
  const PaginatedResponse({
    required this.result,
    required this.count,
    required this.message,
    required this.statusCode,
  });


  @override
  final List<T> result;
  final int count;
  final String message;
  final int statusCode;


  factory PaginatedResponse.fromJson(
          Map<String, dynamic> json, FromJsonT<T> fromJsonT) =>
      _$PaginatedResponseFromJson<T>(json, fromJsonT);

  PaginatedResponse<T> copyWith({
    List<T>? result,
    int? count,
    String? message,
    int? statusCode,
  }) {
    return PaginatedResponse<T>(
      result: result ?? this.result,
      count: count ?? this.count,
      message: message ?? this.message,
      statusCode: statusCode ?? this.statusCode,
    );
  }
  
  @override
  int get total => count;

}
