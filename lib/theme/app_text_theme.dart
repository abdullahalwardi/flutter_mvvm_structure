import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract final class AppTextTheme {
  static TextTheme apply(TextTheme base) => GoogleFonts.cairoTextTheme(base);
}
