// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'App Name';

  @override
  String get cancel => 'Cancel';

  @override
  String get changeLanguage => 'Change language';

  @override
  String get crop => 'Crop';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get defaultErrorMessage => 'An error occurred, please try again later';

  @override
  String get fieldRequired => 'This field is required';

  @override
  String get invalidFieldValue => 'Invalid field value';

  @override
  String get lightMode => 'Light Mode';

  @override
  String get locationPermissionIsRequiredToContinue =>
      'Location permission is required to continue';

  @override
  String get login => 'Login';

  @override
  String get loginSuccess => 'Logged in successfully';

  @override
  String get noItemsFoundError => 'No items found';

  @override
  String get password => 'Password';

  @override
  String get pickDate => 'Pick date';

  @override
  String get relocate => 'Relocate';

  @override
  String get retry => 'Retry';

  @override
  String get search => 'Search';

  @override
  String get select => 'Select';

  @override
  String get switchTheme => 'Switch theme';

  @override
  String get theme => 'Theme';

  @override
  String get themeDark => 'Dark';

  @override
  String get themeLight => 'Light';

  @override
  String get themeSystem => 'System';

  @override
  String get typeYourPasswordHere => 'Type your password here';

  @override
  String get typeYourUsenameHere => 'Type your username here';

  @override
  String get username => 'Username';

  @override
  String get validationEmail => 'Please enter a valid email';

  @override
  String get validationMaxLength => 'Please complete the required length';

  @override
  String get validationPhoneNumber => 'Please enter a valid phone number';

  @override
  String get validationRequired => 'This field is required';

  @override
  String get validationUrl => 'Please enter a valid URL';

  @override
  String get validatorEmail => 'The field is not a valid email address';

  @override
  String validatorMaxLength(Object n) {
    return 'The field must be at most $n characters long';
  }

  @override
  String validatorMinLength(Object n) {
    return 'The field must be at least $n characters long';
  }

  @override
  String get validatorPhoneNumber => 'The field is not a valid phone number';

  @override
  String get validatorRequired => 'The field is required';

  @override
  String get validatorUrl => 'The field is not a valid URL address';

  @override
  String get validatorUseArabicOrKurdishLetters =>
      'Please use Arabic or Kurdish letters';

  @override
  String get validatorUseEnglishLetters => 'Please use English letters';

  @override
  String get welcomeAgain => 'Welcome again';
}
