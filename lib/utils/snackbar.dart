import 'package:app/common_lib.dart';
import 'package:app/theme/app_theme.dart';
import 'package:app/utils/extensions.dart';
import 'package:flutter/material.dart';

class Utils {
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();
  static void showErrorSnackBar(String? text) {
    if (text == null) return;
    SnackBar snackBar = SnackBar(
      content: Text(text),
      behavior: SnackBarBehavior.floating,
      backgroundColor: colorSchemeNotifier.value.error,
    );
    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static void showSuccessSnackBar(String? text) {
    if (text == null) return;
    SnackBar snackBar = SnackBar(
      content: Text(text),
      behavior: SnackBarBehavior.floating,
    );
    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static void showNotificatonSnackBar(String? title) {
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
extension SnackBarX on BuildContext {
  void showSnackBar(String text) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(text),
      behavior: SnackBarBehavior.floating,
      backgroundColor: theme.colorScheme.error,
      ),
    );
  }

  void showSuccessSnackBar(String text) {
    // final theme = Theme.of(this);

    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(text),
      behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void showErrorSnackBar(String text) {
    final theme = Theme.of(this);

    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          text,
          style: TextStyle(
            color: theme.colorScheme.onError,
          ),
        ),
        backgroundColor: theme.colorScheme.error,
      ),
    );
  }
}
