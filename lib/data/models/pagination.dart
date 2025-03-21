import "_models.dart";

part 'pagination.freezed.dart';
part 'pagination.g.dart';

@freezedResponseGeneric
abstract class Pagination<T> with _$Pagination<T> {
  const Pagination._();

  const factory Pagination({
    required int total,
    required List<T> items,
  }) = _Pagination<T>;

  factory Pagination.fromJson(
          Map<String, dynamic> json, FromJsonT<T> fromJsonT) =>
      _$PaginationFromJson<T>(json, fromJsonT);
}
