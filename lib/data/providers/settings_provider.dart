// ignore_for_file: avoid_build_context_in_providers
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../theme/theme_extension.dart';
import 'object_preference_provider.dart';
import 'package:app/data/shared_preference/preferences.dart';

part 'settings_provider.freezed.dart';
part 'settings_provider.g.dart';

@freezed
abstract class AppSettings with _$AppSettings {
  const AppSettings._();

  const factory AppSettings({
    @Default(ThemeMode.system) ThemeMode themeMode,
    @Default(null) String? localeCode,
  }) = _AppSettings;

  Locale? get locale => localeCode == null ? null : Locale(localeCode!);

  factory AppSettings.fromJson(Map<String, dynamic> json) =>
      _$AppSettingsFromJson(json);
}

@riverpod
class Settings extends _$Settings with ObjectPreferenceProvider {
  @override
  @protected
  String get key => Preferences.settings;

  @override
  AppSettings fromJson(Map<String, dynamic> map) => AppSettings.fromJson(map);

  @override
  Map<String, dynamic> toJson(AppSettings value) => value.toJson();

  @override
  AppSettings build() => firstBuild(const AppSettings());


  Future<void> toggleThemeMode(BuildContext context) =>
      update((state) => state.copyWith(
          themeMode: ThemeX.getOppositeThemeMode(state.themeMode, context)));

  Future<void> setLocale(Locale? locale) =>
      update((state) => state.copyWith(localeCode: locale?.languageCode));
  
  Future<void> toggleLocale() => update((state) => state.copyWith(
      localeCode: state.locale?.languageCode == "en" ? "ar" : "en"));
}
