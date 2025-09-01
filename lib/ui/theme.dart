import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color kPrimary = Color(0xFF00838F);
const Color kSecondary = Color(0xFFD2E101);

ThemeData buildAppTheme(Brightness brightness) {
  final base = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: kPrimary,
      brightness: brightness,
    ).copyWith(
      primary: kPrimary,
      secondary: kSecondary,
    ),
  );

  final textTheme = GoogleFonts.interTextTheme(base.textTheme).copyWith(
    headlineMedium: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 24),
    titleLarge: GoogleFonts.inter(fontWeight: FontWeight.w600),
    labelLarge: GoogleFonts.inter(fontWeight: FontWeight.w600),
  );

  return base.copyWith(
    textTheme: textTheme,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      foregroundColor: base.colorScheme.onBackground,
    ),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: kPrimary,
      contentTextStyle: const TextStyle(color: Colors.white),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
}
