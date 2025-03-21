// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pagination.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Pagination<T> {
  int get total;
  List<T> get items;

  /// Create a copy of Pagination
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PaginationCopyWith<T, Pagination<T>> get copyWith =>
      _$PaginationCopyWithImpl<T, Pagination<T>>(
          this as Pagination<T>, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Pagination<T> &&
            (identical(other.total, total) || other.total == total) &&
            const DeepCollectionEquality().equals(other.items, items));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, total, const DeepCollectionEquality().hash(items));

  @override
  String toString() {
    return 'Pagination<$T>(total: $total, items: $items)';
  }
}

/// @nodoc
abstract mixin class $PaginationCopyWith<T, $Res> {
  factory $PaginationCopyWith(
          Pagination<T> value, $Res Function(Pagination<T>) _then) =
      _$PaginationCopyWithImpl;
  @useResult
  $Res call({int total, List<T> items});
}

/// @nodoc
class _$PaginationCopyWithImpl<T, $Res>
    implements $PaginationCopyWith<T, $Res> {
  _$PaginationCopyWithImpl(this._self, this._then);

  final Pagination<T> _self;
  final $Res Function(Pagination<T>) _then;

  /// Create a copy of Pagination
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? total = null,
    Object? items = null,
  }) {
    return _then(_self.copyWith(
      total: null == total
          ? _self.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      items: null == items
          ? _self.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<T>,
    ));
  }
}

/// @nodoc
@JsonSerializable(createToJson: false, genericArgumentFactories: true)
class _Pagination<T> extends Pagination<T> {
  const _Pagination({required this.total, required final List<T> items})
      : _items = items,
        super._();
  factory _Pagination.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$PaginationFromJson(json, fromJsonT);

  @override
  final int total;
  final List<T> _items;
  @override
  List<T> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  /// Create a copy of Pagination
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PaginationCopyWith<T, _Pagination<T>> get copyWith =>
      __$PaginationCopyWithImpl<T, _Pagination<T>>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Pagination<T> &&
            (identical(other.total, total) || other.total == total) &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, total, const DeepCollectionEquality().hash(_items));

  @override
  String toString() {
    return 'Pagination<$T>(total: $total, items: $items)';
  }
}

/// @nodoc
abstract mixin class _$PaginationCopyWith<T, $Res>
    implements $PaginationCopyWith<T, $Res> {
  factory _$PaginationCopyWith(
          _Pagination<T> value, $Res Function(_Pagination<T>) _then) =
      __$PaginationCopyWithImpl;
  @override
  @useResult
  $Res call({int total, List<T> items});
}

/// @nodoc
class __$PaginationCopyWithImpl<T, $Res>
    implements _$PaginationCopyWith<T, $Res> {
  __$PaginationCopyWithImpl(this._self, this._then);

  final _Pagination<T> _self;
  final $Res Function(_Pagination<T>) _then;

  /// Create a copy of Pagination
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? total = null,
    Object? items = null,
  }) {
    return _then(_Pagination<T>(
      total: null == total
          ? _self.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      items: null == items
          ? _self._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<T>,
    ));
  }
}

// dart format on
