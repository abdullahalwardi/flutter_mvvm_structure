import 'package:app/theme/app_colors.dart';
import 'package:app/theme/app_component_themes.dart';
import 'package:app/theme/app_text_theme.dart';
import 'package:app/theme/extra_colors.dart';
import 'package:flutter/material.dart';

abstract final class AppTheme {
  static ThemeData get light {
    final scheme = AppColors.lightScheme();
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: scheme,
      extensions: const [ExtraColors.light],
      inputDecorationTheme: AppComponentThemes.inputDecoration(scheme),
      filledButtonTheme: AppComponentThemes.filledButton(),
      outlinedButtonTheme: AppComponentThemes.outlinedButton(),
      textButtonTheme: AppComponentThemes.textButton(),
    );
    return base.copyWith(textTheme: AppTextTheme.apply(base.textTheme));
  }

  static ThemeData get dark {
    final scheme = AppColors.darkScheme();
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: scheme,
      extensions: const [ExtraColors.dark],
      inputDecorationTheme: AppComponentThemes.inputDecoration(scheme),
      filledButtonTheme: AppComponentThemes.filledButton(),
      outlinedButtonTheme: AppComponentThemes.outlinedButton(),
      textButtonTheme: AppComponentThemes.textButton(),
    );
    return base.copyWith(textTheme: AppTextTheme.apply(base.textTheme));
  }
}
