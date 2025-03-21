// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'authentication_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AuthenticationModel {
  String get token;
  String get refreshToken;

  /// Create a copy of AuthenticationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AuthenticationModelCopyWith<AuthenticationModel> get copyWith =>
      _$AuthenticationModelCopyWithImpl<AuthenticationModel>(
          this as AuthenticationModel, _$identity);

  /// Serializes this AuthenticationModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AuthenticationModel &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, token, refreshToken);

  @override
  String toString() {
    return 'AuthenticationModel(token: $token, refreshToken: $refreshToken)';
  }
}

/// @nodoc
abstract mixin class $AuthenticationModelCopyWith<$Res> {
  factory $AuthenticationModelCopyWith(
          AuthenticationModel value, $Res Function(AuthenticationModel) _then) =
      _$AuthenticationModelCopyWithImpl;
  @useResult
  $Res call({String token, String refreshToken});
}

/// @nodoc
class _$AuthenticationModelCopyWithImpl<$Res>
    implements $AuthenticationModelCopyWith<$Res> {
  _$AuthenticationModelCopyWithImpl(this._self, this._then);

  final AuthenticationModel _self;
  final $Res Function(AuthenticationModel) _then;

  /// Create a copy of AuthenticationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = null,
    Object? refreshToken = null,
  }) {
    return _then(_self.copyWith(
      token: null == token
          ? _self.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      refreshToken: null == refreshToken
          ? _self.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@jsonSerializable
class _AuthenticationModel extends AuthenticationModel {
  const _AuthenticationModel({required this.token, required this.refreshToken})
      : super._();
  factory _AuthenticationModel.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationModelFromJson(json);

  @override
  final String token;
  @override
  final String refreshToken;

  /// Create a copy of AuthenticationModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AuthenticationModelCopyWith<_AuthenticationModel> get copyWith =>
      __$AuthenticationModelCopyWithImpl<_AuthenticationModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AuthenticationModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AuthenticationModel &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, token, refreshToken);

  @override
  String toString() {
    return 'AuthenticationModel(token: $token, refreshToken: $refreshToken)';
  }
}

/// @nodoc
abstract mixin class _$AuthenticationModelCopyWith<$Res>
    implements $AuthenticationModelCopyWith<$Res> {
  factory _$AuthenticationModelCopyWith(_AuthenticationModel value,
          $Res Function(_AuthenticationModel) _then) =
      __$AuthenticationModelCopyWithImpl;
  @override
  @useResult
  $Res call({String token, String refreshToken});
}

/// @nodoc
class __$AuthenticationModelCopyWithImpl<$Res>
    implements _$AuthenticationModelCopyWith<$Res> {
  __$AuthenticationModelCopyWithImpl(this._self, this._then);

  final _AuthenticationModel _self;
  final $Res Function(_AuthenticationModel) _then;

  /// Create a copy of AuthenticationModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? token = null,
    Object? refreshToken = null,
  }) {
    return _then(_AuthenticationModel(
      token: null == token
          ? _self.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      refreshToken: null == refreshToken
          ? _self.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
