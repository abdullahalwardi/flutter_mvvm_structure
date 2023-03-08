
import 'package:app/theme/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:form_validator/form_validator.dart';

class AppFormValidatorLocale extends FormValidatorLocale {
  final BuildContext context;

  AppFormValidatorLocale(this.context);

  @override
  String email(String v) => context.l10n.validationEmail;

  @override
  String maxLength(String v, int n) => context.l10n.validationMaxLength;

  @override
  String minLength(String v, int n) => context.l10n.validationMaxLength;

  @override
  String required() => context.l10n.validationRequired;

  @override
  String url(String v) => context.l10n.validationUrl;

  @override
  String name() => "all";

  @override
  String phoneNumber(String v) => context.l10n.validationPhoneNumber;

  @override
  String ip(String v) => "";

  @override
  String ipv6(String v) => "";
}
