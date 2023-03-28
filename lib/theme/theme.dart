import 'package:app/utils/constants/border_size.dart';
import 'package:app/utils/constants/stroke_width.dart';
import 'package:app/theme/theme_mode.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary:  Color(0xFF006A62),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFF72F8E9),
  onPrimaryContainer: Color(0xFF00201D),
  secondary: Color(0xFF666000),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFF4E71C),
  onSecondaryContainer: Color(0xFF1F1C00),
  tertiary: Color(0xFF984061),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFFFD9E2),
  onTertiaryContainer: Color(0xFF3E001D),
  error: Color(0xFFBA1A1A),
  errorContainer: Color(0xFFFFDAD6),
  onError: Color(0xFFFFFFFF),
  onErrorContainer: Color(0xFF410002),
  background: Color(0xFFF8FDFF),
  onBackground: Color(0xFF001F25),
  surface: Color(0xFFF8FDFF),
  onSurface: Color(0xFF001F25),
  surfaceVariant: Color(0xFFE7E3D0),
  onSurfaceVariant: Color(0xFF49473A),
  outline: Color(0xFF7A7768),
  onInverseSurface: Color(0xFFD6F6FF),
  inverseSurface: Color(0xFF00363F),
  inversePrimary: Color(0xFFD6CA00),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF666000),
  outlineVariant: Color(0xFFCBC7B5),
  scrim: Color(0xFF000000),
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFF51DBCD),
  onPrimary: Color(0xFF003733),
  primaryContainer: Color(0xFF00504A),
  onPrimaryContainer: Color(0xFF72F8E9),
  secondary: Color(0xFFD6CA00),
  onSecondary: Color(0xFF353100),
  secondaryContainer: Color(0xFF4D4800),
  onSecondaryContainer: Color(0xFFF4E71C),
  tertiary: Color(0xFFFFB1C8),
  onTertiary: Color(0xFF5E1133),
  tertiaryContainer: Color(0xFF7B2949),
  onTertiaryContainer: Color(0xFFFFD9E2),
  error: Color(0xFFFFB4AB),
  errorContainer: Color(0xFF93000A),
  onError: Color(0xFF690005),
  onErrorContainer: Color(0xFFFFDAD6),
  background: Color(0xFF001F25),
  onBackground: Color(0xFFA6EEFF),
  surface: Color(0xFF001F25),
  onSurface: Color(0xFFA6EEFF),
  surfaceVariant: Color(0xFF49473A),
  onSurfaceVariant: Color(0xFFCBC7B5),
  outline: Color(0xFF949181),
  onInverseSurface: Color(0xFF001F25),
  inverseSurface: Color(0xFFA6EEFF),
  inversePrimary: Color(0xFF666000),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFFD6CA00),
  outlineVariant: Color(0xFF49473A),
  scrim: Color(0xFF000000),
);

ThemeData getThemeData(ThemeMode themeMode) {
  final isLight = themeMode.isLight;
  final colorScheme = isLight ? lightColorScheme : darkColorScheme;
  final borderSide = BorderSide(
      width: BorderWidth.small,
      color: colorScheme.outline,
    );

    final borderRadius = BorderRadius.circular(BorderSize.medium);
  final border = OutlineInputBorder(
      borderSide: borderSide,
      borderRadius: borderRadius,
    );
  
  

  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: colorScheme.background,
    textTheme: GoogleFonts.cairoTextTheme(
      isLight ? ThemeData.light().textTheme : ThemeData.dark().textTheme,
    ),
    dividerTheme: DividerThemeData(
        thickness: BorderWidth.extraSmall,
        color: colorScheme.outline,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        elevation: 0,
      ),
    inputDecorationTheme: InputDecorationTheme(
      isDense: true,
      
        border: border,
        focusColor: colorScheme.primary,
        enabledBorder: border,
        focusedBorder: border.copyWith(
          
          borderSide: borderSide.copyWith(color: colorScheme.primary),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(
            width: BorderWidth.small,
            color: colorScheme.error,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(borderRadius: borderRadius, borderSide: BorderSide(
          color: colorScheme.error,
        ),),
        
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(const Size(0, 55)),
        maximumSize: MaterialStateProperty.all(const Size(double.infinity, double.infinity)),
      ),
    
    )
  );
}
