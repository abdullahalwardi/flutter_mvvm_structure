import 'package:app/theme/theme_mode.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const ColorScheme lightTheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xff6AB1FD),
  onPrimary: Colors.white,
  secondary: Color(0xff6AB1FD),
  onSecondary: Colors.white,
  error: Colors.red,
  onError: Colors.white,
  background: Colors.white,
  onBackground: Colors.black,
  surface: Colors.white,
  onSurface: Colors.black,
);

const ColorScheme darkTheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xff407BFF),
  onPrimary: Colors.white,
  secondary: Color(0xff407BFF),
  onSecondary: Colors.white,
  error: Colors.red,
  onError: Colors.white,
  background: Colors.black,
  onBackground: Colors.white,
  surface: Colors.black,
  onSurface: Colors.white,
);

ThemeData getThemeData(ThemeMode themeMode) {
  final isLight = themeMode.isLight;
  final colorScheme = isLight ? lightTheme : darkTheme;

  return ThemeData(
    useMaterial3: false,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: colorScheme.background,
    textTheme: GoogleFonts.jetBrainsMonoTextTheme(
      isLight ? ThemeData.light().textTheme : ThemeData.dark().textTheme,
    ),
  );
}
