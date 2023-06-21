import 'dart:convert';
import 'dart:developer';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../common_lib.dart';
import 'provider.dart';

mixin ObjectPreferenceProvider<State> on AutoDisposeNotifier<State> {
  @protected
  String get key;

  Map<String, dynamic> toJson(State value);

  State fromJson(Map<String, dynamic> map);

  String jsonEncode(Map<String, dynamic> data) {
    return json.encode(data);
  }

  Map<String, dynamic> jsonDecode(String raw) {
    return json.decode(raw) as Map<String, dynamic>;
  }

  Future<State> update(State Function(State state) changed) async {
    final State value = changed(state);
    try {
      final Map<String, dynamic> jsonData = toJson(value);
      final String raw = jsonEncode(jsonData);
      await ref.sharedPreferences.setString(key, raw);

      return state = value;
    } catch (e, stackTrace) {
      log("Preference: $key", error: e, stackTrace: stackTrace);
      return state;
    }
  }

  State firstBuild(State fallback) {
    final raw = ref.sharedPreferences.getString(key);
    if (raw == null) return fallback;
    try {
      log(raw.toString());
      final Map<String, dynamic> map = jsonDecode(raw);
      return fromJson(map);
    } catch (e, stackTrace) {
      log("Preference: $key", error: e, stackTrace: stackTrace);
      return fallback;
    }
  }
}

mixin NullableObjectPreferenceProvider<State> on AutoDisposeNotifier<State?> {
  @protected
  String get key;

  Map<String, dynamic>? toJson(State? value);

  State? fromJson(Map<String, dynamic>? map);

  String? jsonEncode(Map<String, dynamic>? data) {
    return data == null ? null : json.encode(data);
  }

  Map<String, dynamic> jsonDecode(String raw) {
    return json.decode(raw) as Map<String, dynamic>;
  }

  Future<State?> updateValue(State value) => update((state) => value);

  Future<State?> update(State Function(State? state) changed) async {
    final State value = changed(state);

    try {
      final Map<String, dynamic>? jsonData = toJson(value);
      final String? raw = jsonEncode(jsonData);
      if (raw == null) {
        await ref.sharedPreferences.remove(key);
      } else {
        await ref.sharedPreferences.setString(key, raw);
      }

      return state = value;
    } catch (e, stackTrace) {
      log("Preference: $key", error: e, stackTrace: stackTrace);
      return state;
    }
  }

  State? firstBuild() {
    final raw = ref.sharedPreferences.getString(key);

    if (raw == null) return null;

    try {
      final Map<String, dynamic> map = jsonDecode(raw);
      return fromJson(map);
    } catch (e, stackTrace) {
      log("Preference: $key", error: e, stackTrace: stackTrace);
      return null;
    }
  }

  Future<void> clear() async {
    await ref.sharedPreferences.remove(key);
    state = null;
  }
}
