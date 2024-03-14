import 'package:app/common_lib.dart';
import 'package:app/utils/validation_regix.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';

class AppValidationBuilder extends ValidationBuilder {
  final BuildContext context;

  AppValidationBuilder({
    required this.context,
    required super.optional,
    super.locale,
  });

  @override
  AppValidationBuilder add(StringValidationCallback validator) {
    validations.add(validator);
    return this;
  }

  @override
  AppValidationBuilder regExp(RegExp regExp, String message) =>
      add((v) => regExp.hasMatch(v!) ? null : message);

  AppValidationBuilder value(String? message) => add((v) => message);

  AppValidationBuilder facebookProfile() => regExp(
        RegExp(
            r"(?:(?:http|https)://)?(?:www.)?facebook.com/(?:(?:w)*#!/)?(?:pages/)?(?:[?w-]*/)?(?:profile.php?id=(?=d.*))?([w-]*)?"),
        context.l10n.validationUrl,
      );

  AppValidationBuilder twitterProfile() => regExp(
        RegExp(r"^https:\/\/[a-z]{2,3}\.twitter\.com\/.*$"),
        context.l10n.validationUrl,
      );

  AppValidationBuilder linkedinProfile() => regExp(
        RegExp(r"^https:\/\/[a-z]{2,3}\.linkedin\.com\/.*$"),
        context.l10n.validationUrl,
      );

  AppValidationBuilder behanceProfile() => regExp(
        RegExp(r"^https:\/\/[a-z]{2,3}\.behance\.net\/.*$"),
        context.l10n.validationUrl,
      );

  AppValidationBuilder usernameAlter() => regExp(
        usernameRegex,
        context.l10n.invalidFieldValue,
      );
}
