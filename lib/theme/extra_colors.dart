import 'package:flutter/material.dart';

class ExtraColors extends ThemeExtension<ExtraColors> {
  final Color success;
  final Color onSuccess;
  final Color error;

  const ExtraColors({
    required this.success,
    required this.onSuccess,
    required this.error,
  });

  @override
  ThemeExtension<ExtraColors> copyWith({
    Color? success,
    Color? onSuccess,
    Color? error,
  }) {
    return ExtraColors(
      success: success ?? this.success,
      onSuccess: onSuccess ?? this.onSuccess,
      error: error ?? this.error,
    );
  }

  @override
  ThemeExtension<ExtraColors> lerp(
      covariant ThemeExtension<ExtraColors>? other, double t) {
    if (other is! ExtraColors) return this;

    return ExtraColors(
      success: Color.lerp(success, other.success, t)!,
      onSuccess: Color.lerp(onSuccess, other.onSuccess, t)!,
      error: Color.lerp(error, other.error, t)!,
    );
  }
}

extension ExtraColorsX on ThemeData {
  ExtraColors get extraColors => extension<ExtraColors>()!;
}
