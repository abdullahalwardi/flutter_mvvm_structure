import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings.freezed.dart';
part 'settings.g.dart';

@freezed
abstract class Settings with _$Settings {
  const Settings._();

  const factory Settings({
    @Default(ThemeMode.system) ThemeMode themeMode,
    @LocaleStringJsonConvertor()
    Locale? locale,
  }) = _Settings;

  factory Settings.fromJson(dynamic json) =>
      _$SettingsFromJson(json);
}

class LocaleStringJsonConvertor implements JsonConverter<Locale, String> {
  const LocaleStringJsonConvertor();

  @override
  Locale fromJson(String json) {
    return Locale(json);
  }

  @override
  String toJson(Locale object) {
    return object.languageCode;
  }
}
