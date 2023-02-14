import 'dart:async';

import 'package:app/data/shared_preference/cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ObjectSharedPreference<T> implements CacheManager<T> {
  final String key;

  @protected
  final SharedPreferences sharedPreference;

  const ObjectSharedPreference(this.sharedPreference, {required this.key});

  @override
  T? maybeData();

  @override
  Future<void> setData(T value);

  @override
  Future<void> clearData() async {
    await sharedPreference.remove(key);
  }
}
