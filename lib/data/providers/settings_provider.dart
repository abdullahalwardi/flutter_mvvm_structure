import 'package:app/common_lib.dart';
import 'package:app/data/client/models/settings/settings.dart';
import 'package:app/data/shared_preference/serializable_preference.dart';
import 'package:app/persistent_store.dart';
import 'package:app/theme/platform_default.dart';
import 'package:app/provider_shared_preferences.dart';
import 'package:flutter/material.dart';

final _settingsPreference =
    Provider((ref) => ProvideSerializablePreference<Settings>(
          ref.watch(sharedPreferences),
          key: "settings",
          fromJson: Settings.fromJson,
          toJson: (value) => value.toJson(),
        ));

class SettingsNotifier extends PersistentStateNotifier<Settings> {
  SettingsNotifier(ref)
      : super(const Settings(), preference: ref.read(_settingsPreference));

  void switchThemeMode(BuildContext context) {
    state = state.copyWith(
      themeMode: PlatformDefault.switchTheme(context, state.themeMode),
    );
  }

  void switchLocale() {
    state = state.copyWith(
      locale: AppLocalizations.supportedLocales.next(
        PlatformDefault.locale(state.locale),
      ),
    );
  }
}

final settingsProvider = StateNotifierProvider<SettingsNotifier, Settings>(
  (ref)=> SettingsNotifier(ref),
);
