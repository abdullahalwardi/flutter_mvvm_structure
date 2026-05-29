import 'package:app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

abstract final class AppComponentThemes {
  static const BorderRadius _borderRadius =
      BorderRadius.all(Radius.circular(BorderSize.extraSmall));

  static const EdgeInsets _padding =
      EdgeInsets.symmetric(vertical: 16, horizontal: 14);

  static InputDecorationTheme inputDecoration(ColorScheme scheme) {
    OutlineInputBorder border(Color color, {double width = 1}) =>
        OutlineInputBorder(
          borderRadius: _borderRadius,
          borderSide: BorderSide(color: color, width: width),
        );

    return InputDecorationTheme(
      contentPadding: _padding,
      fillColor: scheme.surfaceContainerHighest.withValues(alpha: 0.5),
      filled: true,
      activeIndicatorBorder: BorderSide.none,
      border: border(scheme.outline.withValues(alpha: 0.5)),
      errorBorder: border(scheme.error),
      enabledBorder: border(scheme.outline.withValues(alpha: 0.5)),
      focusedBorder: border(scheme.primary),
      focusedErrorBorder: border(scheme.error, width: 2),
      disabledBorder: border(scheme.outline.withValues(alpha: 0.5)),
    );
  }

  static FilledButtonThemeData filledButton() {
    return FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size(0, 55),
        maximumSize: const Size(double.infinity, double.infinity),
        shape: const RoundedRectangleBorder(borderRadius: _borderRadius),
      ),
    );
  }

  static OutlinedButtonThemeData outlinedButton() {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        padding: _padding,
        shape: const RoundedRectangleBorder(borderRadius: _borderRadius),
      ),
    );
  }

  static TextButtonThemeData textButton() {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        padding: _padding,
        shape: const RoundedRectangleBorder(borderRadius: _borderRadius),
      ),
    );
  }
}
