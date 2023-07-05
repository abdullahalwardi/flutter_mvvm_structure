// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authentication_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AuthenticationModel _$$_AuthenticationModelFromJson(
        Map<String, dynamic> json) =>
    _$_AuthenticationModel(
      token: json['token'] as String,
      refreshToken: json['refresh_token'] as String,
    );

Map<String, dynamic> _$$_AuthenticationModelToJson(
        _$_AuthenticationModel instance) =>
    <String, dynamic>{
      'token': instance.token,
      'refresh_token': instance.refreshToken,
    };
