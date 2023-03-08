import 'package:flutter/services.dart';

final RegExp iraqiPhoneNumberRegex = RegExp("7[3-9][0-9]{8}");
final RegExp emailRegex = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9\-\_]+(\.[a-zA-Z]+)*$");
final RegExp jwtRegex =
    RegExp(r"/^([a-zA-Z0-9_=]+)\.([a-zA-Z0-9_=]+)\.([a-zA-Z0-9_\-\+\/=]*)/gm");
final RegExp nonDigitsRegex = RegExp(r'[^\d]');
final RegExp englishLetterRegex = RegExp(r'[A-Za-z]');
final RegExp youtubeRegex = RegExp(
    r'^(http(s)??\:\/\/)?(www\.)?((youtube\.com\/watch\?v=)|(youtu.be\/))([a-zA-Z0-9\-_])+');
final RegExp urlRegex = RegExp(
    r'(https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|www\.[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9]+\.[^\s]{2,}|www\.[a-zA-Z0-9]+\.[^\s]{2,})');
final RegExp usernameRegex = RegExp(r"^(?!.*\.\.)(?!.*\.$)[^\W][\w.]{0,29}$");
final englishLettersOnly =
    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]"));
final asciiOnly = FilteringTextInputFormatter.allow(RegExp("[ -~]"));
