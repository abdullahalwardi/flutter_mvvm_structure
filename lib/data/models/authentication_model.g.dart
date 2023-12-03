// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authentication_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthenticationModelImpl _$$AuthenticationModelImplFromJson(
        Map<String, dynamic> json) =>
    _$AuthenticationModelImpl(
      token: json['token'] as String,
      refreshToken: json['refreshToken'] as String,
    );

Map<String, dynamic> _$$AuthenticationModelImplToJson(
        _$AuthenticationModelImpl instance) =>
    <String, dynamic>{
      'token': instance.token,
      'refreshToken': instance.refreshToken,
    };
