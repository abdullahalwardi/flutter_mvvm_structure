// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app/data/models/json_types.dart';
import 'package:app/data/models/paginated.dart';
import 'package:json_annotation/json_annotation.dart';

part 'paginated_response.g.dart';

@JsonSerializable(genericArgumentFactories: true, createToJson: false)
class PaginatedResponse<T> implements Paginated<T> {
  const PaginatedResponse({
    required this.result,
    required this.count,
    required this.message,
    required this.statusCode,
  });

  /// API payload list (JSON key `result`).
  final List<T> result;
  final int count;
  final String message;
  final int statusCode;

  @override
  List<T> get items => result;

  @override
  int get totalCount => count;

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
}

