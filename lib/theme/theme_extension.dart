import 'package:flutter/material.dart';

class ThemeX {
  const ThemeX._();

  static ThemeMode getOppositeThemeMode(ThemeMode value, BuildContext context) {
    switch (value) {
      case ThemeMode.system:
        final brightness = MediaQuery.platformBrightnessOf(context);
        return brightness == Brightness.dark ? ThemeMode.light : ThemeMode.dark;
      case ThemeMode.light:
        return ThemeMode.dark;
      case ThemeMode.dark:
        return ThemeMode.light;
    }
  }
}
