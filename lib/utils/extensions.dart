import 'package:app/data/services/clients/_clients.dart';
import 'package:app/l10n/app_localizations.dart';
import 'package:app/utils/locale.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

extension DeviceHeight on BuildContext {
  double get height => MediaQuery.of(this).size.height;
}

extension DeviceWidth on BuildContext {
  double get width => MediaQuery.of(this).size.width;
}

extension ValidatorX on BuildContext {
  ValidationBuilder get validator {
    final locale = AppFormValidatorLocale(this);
    return ValidationBuilder(
      optional: false,
      requiredMessage: locale.required(),
      locale: locale,
    );
  }
}

extension FormStateX on GlobalKey<FormState> {
  bool isNotValid() => !currentState!.validate();
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


extension HttpResponseX<T> on Future<HttpResponse<T>> {
  Future<T> get data => then((value) => value.data);
}

extension ValueNotifierUpdated<T> on ValueNotifier<T> {
  void update(T newValue) => value = newValue;

  void updateNullable(T? newValue) {
    if (newValue != null) value = newValue;
  }
}

extension on ValidationBuilder {
  ValidationBuilder iraqiPhoneNumber(BuildContext context) {
    return add((v) {
      return RegExp(r"^(0|964|00964|\+964)?7[0-9]{9}$").hasMatch(v!)
          ? null
          : context.l10n.validatorPhoneNumber;
    });
  }
}

extension AppLocalizationsExtension on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
  String get locale => l10n.localeName;
}

extension DateTimeX on DateTime {
  String formatDate([String? locale]) =>
      DateFormat('yyyy/MM/dd', locale).format(this);

  String formatTime([String? locale]) =>
      DateFormat('hh:mm a', locale).format(this);

  String formatDOW([String? locale]) => DateFormat('EEEE', locale).format(this);

  String format([String? locale]) =>
      DateFormat('yyyy/MM/dd hh:mm', locale).format(this);

  String formatTimeago([String? locale]) =>
      timeago.format(this, locale: locale).toUpperCase();
}

extension AdditionalColors on ColorScheme {
  Color get primaryText => const Color(0xff035EC9);
  Color get secondaryText => const Color(0xFF7C7C7C);
  Color get defaultText => const Color(0xff202020);
  Color get otherText => const Color(0xffFD7E14);
  Color get successText => const Color(0xff198754);
  Color get dangerColor => const Color(0xffDC3747);
}