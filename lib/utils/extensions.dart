
import 'package:app/utils/app_validator.dart';
import 'package:app/utils/locale.dart';
import 'package:app/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DeviceHeight on BuildContext {
  double get height => MediaQuery.of(this).size.height;
}

extension DeviceWidth on BuildContext {
  double get width => MediaQuery.of(this).size.width;
}

extension ValidationExtension on BuildContext {
  AppValidationBuilder get validator {
    return AppValidationBuilder(
      context: this,
      locale: AppFormValidatorLocale(this),
      optional: false,
    );
  }

  AppValidationBuilder get optionalValidator {
    return AppValidationBuilder(
      context: this,
      locale: AppFormValidatorLocale(this),
      optional: true,
    );
  }
}

extension DateTimeExtension on DateTime {
  String format() {
    var inputFormat = DateFormat('MM/dd/yyyy HH:mm');
    return inputFormat.format(this);
  }

  String formatDate() {
    var inputFormat = DateFormat('MM/dd/yyyy');
    return inputFormat.format(this);
  }
}

extension NullableDateTimeExtension on DateTime? {
  String formatDate() {
    var inputFormat = DateFormat('MM/dd/yyyy');

    return this == null ? "" : inputFormat.format(this!);
  }
}

extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  ColorScheme get colorScheme => theme.colorScheme;

  TextTheme get textTheme => theme.textTheme;
}

extension SnackBarExtension on BuildContext {
  void showErrorSnackBar(String message) {
    Utils.showErrorSnackBar(message);
  }

  void showSuccessSnackBar(String message) {
    Utils.showSuccessSnackBar(message);
  }
}
