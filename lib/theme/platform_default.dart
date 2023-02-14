import 'dart:io';

import 'package:flutter/material.dart';

class PlatformDefault {
  const PlatformDefault._();

  static const List<ThemeMode> selectableThemes = [
    ThemeMode.light,
    ThemeMode.dark
  ];

  static ThemeMode switchTheme(BuildContext context, ThemeMode themeMode) {
    final selectedThemeMode = getThemeMode(context, themeMode);
    return selectableThemes.next(selectedThemeMode);
  }

  static ThemeMode getThemeMode(BuildContext context, ThemeMode themeMode) {
    if (themeMode == ThemeMode.system) {
      try {
        switch (MediaQuery.of(context).platformBrightness) {
          case Brightness.dark:
            return ThemeMode.dark;
          case Brightness.light:
            return ThemeMode.light;
        }
      } catch (e) {
        return ThemeMode.light;
      }
    } else {
      return themeMode;
    }
  }

  static Locale locale(Locale? locale) {
    if (locale == null) {
      return Locale(Platform.localeName.split("_").first);
    } else {
      return locale;
    }
  }
}

// handle list as circular linked list
extension Cycle<T> on List<T> {
  T next(T current) => this[(indexOf(current) + 1) % length];
  T back(T current) => this[(indexOf(current) - 1) % length];
}

