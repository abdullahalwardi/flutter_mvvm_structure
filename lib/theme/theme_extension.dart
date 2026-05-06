import 'package:flutter/material.dart';

class ThemeX {
  const ThemeX._();

  static ThemeMode getOppositeThemeModeForBrightness(
    ThemeMode value,
    Brightness platformBrightness,
  ) {
    switch (value) {
      case ThemeMode.system:
        return platformBrightness == Brightness.dark
            ? ThemeMode.light
            : ThemeMode.dark;
      case ThemeMode.light:
        return ThemeMode.dark;
      case ThemeMode.dark:
        return ThemeMode.light;
    }
  }

  static ThemeMode getOppositeThemeMode(ThemeMode value, BuildContext context) {
    return getOppositeThemeModeForBrightness(
      value,
      MediaQuery.platformBrightnessOf(context),
    );
  }
}
