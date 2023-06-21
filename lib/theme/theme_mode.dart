import 'package:app/common_lib.dart';
import 'package:app/utils/extensions.dart';
import 'package:flutter/material.dart';

extension ThemeModeCheck on ThemeMode {
  bool get isLight => this == ThemeMode.light;
  bool get isDark => this == ThemeMode.dark;
}

extension ThemeModeL10n on ThemeMode {
  String localize(BuildContext context) {
    switch (this) {
      case ThemeMode.dark:
        return context.l10n.darkMode;
      case ThemeMode.light:
        return context.l10n.lightMode;
      default:
        return "";
    }
  }
}
