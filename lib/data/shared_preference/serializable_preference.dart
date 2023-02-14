import 'dart:convert';

import 'package:app/data/shared_preference/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef FromJson<T> = T Function(Map<String, dynamic> json);
typedef ToJson<T> = Map<String, dynamic> Function(T value);

class ProvideSerializablePreference<T> extends SerializablePreference<T> {
  final ToJson<T> _toJson;

  final FromJson<T> _fromJson;

  ProvideSerializablePreference(
    super.shared, {
    required super.key,
    required ToJson<T> toJson,
    required FromJson<T> fromJson,
  })  : _toJson = toJson,
        _fromJson = fromJson;

  @override
  T fromJson(Map<String, dynamic> json) => _fromJson(json);

  @override
  Map<String, dynamic> toJson(T value) => _toJson(value);
}

/// json serializable shared preference
///
/// Example:
/// class AuthenticationPreference extends SerializablePreference<Authentication> {
///  const AuthenticationPreference(super.sharedPreference)
///      : super(key: "AuthenticationKey");
///
///  @override
///  Authentication fromJson(JsonMap json) => Authentication.fromJson(json);
///
///  @override
///  JsonMap toJson(Authentication value) => value.toJson();
/// }
abstract class SerializablePreference<T> implements ObjectSharedPreference<T> {
  @override
  final String key;

  @override
  @protected
  final SharedPreferences sharedPreference;

  const SerializablePreference(
    this.sharedPreference, {
    required this.key,
  });

  @protected
  Map<String, dynamic> toJson(T value);

  @protected
  T fromJson(Map<String, dynamic> json);

  /// Read data from [sharedPreference] by it's [key] and then [json.decode]
  /// and [fromJson] it
  @mustCallSuper
  @override
  T? maybeData() {
    final value = sharedPreference.getString(key);
    try {
      return value == null ? null : fromJson(json.decode(value));
    } catch (e) {
      return null;
    }
  }

  /// Starting by [toJson] then [json.encode] object and
  /// Set it in the [sharedPreference] by it's [key]
  @mustCallSuper
  @override
  Future<void> setData(T value) async {
    final Map<String, dynamic> newValue = toJson(value);
    final data = json.encode(newValue);
    await sharedPreference.setString(key, data);
  }

  @override
  Future<void> clearData() async {
    await sharedPreference.remove(key);
  }
}
