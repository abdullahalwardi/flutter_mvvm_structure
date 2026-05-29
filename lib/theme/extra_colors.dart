import 'package:app/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ExtraColors extends ThemeExtension<ExtraColors> {
  final Color success;
  final Color onSuccess;

  const ExtraColors({
    required this.success,
    required this.onSuccess,
  });

  static const ExtraColors light = ExtraColors(
    success: AppColors.successLight,
    onSuccess: AppColors.onSuccessLight,
  );

  static const ExtraColors dark = ExtraColors(
    success: AppColors.successDark,
    onSuccess: AppColors.onSuccessDark,
  );

  @override
  ExtraColors copyWith({
    Color? success,
    Color? onSuccess,
  }) {
    return ExtraColors(
      success: success ?? this.success,
      onSuccess: onSuccess ?? this.onSuccess,
    );
  }

  @override
  ExtraColors lerp(covariant ExtraColors? other, double t) {
    if (other == null) return this;
    return ExtraColors(
      success: Color.lerp(success, other.success, t)!,
      onSuccess: Color.lerp(onSuccess, other.onSuccess, t)!,
    );
  }
}

extension ExtraColorsX on ThemeData {
  ExtraColors get extraColors => extension<ExtraColors>()!;
}
