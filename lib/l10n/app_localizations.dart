import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'App Name'**
  String get appName;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @changeLanguage.
  ///
  /// In en, this message translates to:
  /// **'Change language'**
  String get changeLanguage;

  /// No description provided for @crop.
  ///
  /// In en, this message translates to:
  /// **'Crop'**
  String get crop;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @defaultErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'An error occurred, please try again later'**
  String get defaultErrorMessage;

  /// No description provided for @fieldRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get fieldRequired;

  /// No description provided for @invalidFieldValue.
  ///
  /// In en, this message translates to:
  /// **'Invalid field value'**
  String get invalidFieldValue;

  /// No description provided for @lightMode.
  ///
  /// In en, this message translates to:
  /// **'Light Mode'**
  String get lightMode;

  /// No description provided for @locationPermissionIsRequiredToContinue.
  ///
  /// In en, this message translates to:
  /// **'Location permission is required to continue'**
  String get locationPermissionIsRequiredToContinue;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @loginSuccess.
  ///
  /// In en, this message translates to:
  /// **'Logged in successfully'**
  String get loginSuccess;

  /// No description provided for @noItemsFoundError.
  ///
  /// In en, this message translates to:
  /// **'No items found'**
  String get noItemsFoundError;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @pickDate.
  ///
  /// In en, this message translates to:
  /// **'Pick date'**
  String get pickDate;

  /// No description provided for @relocate.
  ///
  /// In en, this message translates to:
  /// **'Relocate'**
  String get relocate;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @select.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get select;

  /// No description provided for @switchTheme.
  ///
  /// In en, this message translates to:
  /// **'Switch theme'**
  String get switchTheme;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystem;

  /// No description provided for @typeYourPasswordHere.
  ///
  /// In en, this message translates to:
  /// **'Type your password here'**
  String get typeYourPasswordHere;

  /// No description provided for @typeYourUsenameHere.
  ///
  /// In en, this message translates to:
  /// **'Type your username here'**
  String get typeYourUsenameHere;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @validationEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get validationEmail;

  /// No description provided for @validationMaxLength.
  ///
  /// In en, this message translates to:
  /// **'Please complete the required length'**
  String get validationMaxLength;

  /// No description provided for @validationPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid phone number'**
  String get validationPhoneNumber;

  /// No description provided for @validationRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get validationRequired;

  /// No description provided for @validationUrl.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid URL'**
  String get validationUrl;

  /// No description provided for @validatorEmail.
  ///
  /// In en, this message translates to:
  /// **'The field is not a valid email address'**
  String get validatorEmail;

  /// No description provided for @validatorMaxLength.
  ///
  /// In en, this message translates to:
  /// **'The field must be at most {n} characters long'**
  String validatorMaxLength(Object n);

  /// No description provided for @validatorMinLength.
  ///
  /// In en, this message translates to:
  /// **'The field must be at least {n} characters long'**
  String validatorMinLength(Object n);

  /// No description provided for @validatorPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'The field is not a valid phone number'**
  String get validatorPhoneNumber;

  /// No description provided for @validatorRequired.
  ///
  /// In en, this message translates to:
  /// **'The field is required'**
  String get validatorRequired;

  /// No description provided for @validatorUrl.
  ///
  /// In en, this message translates to:
  /// **'The field is not a valid URL address'**
  String get validatorUrl;

  /// No description provided for @validatorUseArabicOrKurdishLetters.
  ///
  /// In en, this message translates to:
  /// **'Please use Arabic or Kurdish letters'**
  String get validatorUseArabicOrKurdishLetters;

  /// No description provided for @validatorUseEnglishLetters.
  ///
  /// In en, this message translates to:
  /// **'Please use English letters'**
  String get validatorUseEnglishLetters;

  /// No description provided for @welcomeAgain.
  ///
  /// In en, this message translates to:
  /// **'Welcome again'**
  String get welcomeAgain;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
