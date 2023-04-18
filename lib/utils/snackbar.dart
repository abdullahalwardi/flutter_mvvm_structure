import 'package:app/theme/theme.dart';
import 'package:flutter/material.dart';

class Utils {
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();
  static showErrorSnackBar(String? text) {
    if (text == null) return;
    SnackBar snackBar = SnackBar(
      content: Text(text),
      behavior: SnackBarBehavior.floating,
      backgroundColor: lightColorScheme.error,
    );
    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static showSuccessSnackBar(String? text) {
    if (text == null) return;
    SnackBar snackBar = SnackBar(
      content: Text(text),
      behavior: SnackBarBehavior.floating,
    );
    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
    static showNotificatonSnackBar(String? title) {
    if (title == null) return;
    SnackBar snackBar = SnackBar(
      
      content: Text(title),
      
      behavior: SnackBarBehavior.floating,
    );
    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}