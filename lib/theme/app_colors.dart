import 'package:flutter/material.dart';

abstract final class AppColors {
  static const Color seed = Color(0xFF113D80);

  static const Color successLight = Color.fromARGB(255, 28, 101, 30);
  static const Color onSuccessLight = Colors.white;

  static const Color successDark = Color.fromARGB(255, 56, 160, 59);
  static const Color onSuccessDark = Colors.black;

  static ColorScheme lightScheme() {
    return ColorScheme.fromSeed(
      seedColor: seed,
      brightness: Brightness.light,
    ).copyWith(
      outline: ColorScheme.fromSeed(
        seedColor: seed,
        brightness: Brightness.light,
      ).outline.withValues(alpha: 0.5),
    );
  }

  static ColorScheme darkScheme() {
    return ColorScheme.fromSeed(
      seedColor: seed,
      brightness: Brightness.dark,
    ).copyWith(
      outline: ColorScheme.fromSeed(
        seedColor: seed,
        brightness: Brightness.dark,
      ).outline.withValues(alpha: 0.5),
    );
  }
}
