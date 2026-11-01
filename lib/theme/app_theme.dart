import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Light Palette
  static const Color primaryColor = Color(0xFF1E3A5F);
  static const Color secondaryColor = Color(0xFF2563EB);
  static const Color accentColor = Color(0xFF059669);
  static const Color lightBg = Color(0xFFF8FAFC);
  static const Color lightSurface = Colors.white;
  static const Color lightBorder = Color(0xFFE2E8F0);
  static const Color lightTextPrimary = Color(0xFF0F172A);
  static const Color lightTextMuted = Color(0xFF64748B);

  // Dark Palette
  static const Color darkBg = Color(0xFF0B1120);
  static const Color darkSurface = Color(0xFF1E293B);
  static const Color darkCard = Color(0xFF1E293B);
  static const Color darkBorder = Color(0xFF334155);
  static const Color darkTextPrimary = Color(0xFFF8FAFC);
  static const Color darkTextMuted = Color(0xFF94A3B8);

  // Status Colors
  static const Color destructiveColor = Color(0xFFDC2626);
  static const Color successColor = Color(0xFF10B981);
  static const Color warningColor = Color(0xFFF59E0B);

  // Avatar Gradient/Accent Palette
  static const List<List<Color>> avatarGradients = [
    [Color(0xFF3B82F6), Color(0xFF1D4ED8)], // Blue
    [Color(0xFF10B981), Color(0xFF047857)], // Emerald
    [Color(0xFF8B5CF6), Color(0xFF6D28D9)], // Purple
    [Color(0xFFEC4899), Color(0xFFBE185D)], // Pink
    [Color(0xFFF97316), Color(0xFFC2410C)], // Orange
    [Color(0xFF06B6D4), Color(0xFF0E7490)], // Cyan
    [Color(0xFF6366F1), Color(0xFF4338CA)], // Indigo
    [Color(0xFF14B8A6), Color(0xFF0F766E)], // Teal
  ];

  static ThemeData lightTheme() {
    final baseTextTheme = GoogleFonts.openSansTextTheme();
    final headingTheme = GoogleFonts.poppinsTextTheme();

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: lightBg,
      colorScheme: ColorScheme.light(
        primary: primaryColor,
        onPrimary: Colors.white,
        secondary: secondaryColor,
        onSecondary: Colors.white,
        tertiary: accentColor,
        onTertiary: Colors.white,
        surface: lightSurface,
        onSurface: lightTextPrimary,
        error: destructiveColor,
        onError: Colors.white,
        outline: lightBorder,
      ),
      textTheme: baseTextTheme.copyWith(
        displayLarge: headingTheme.displayLarge?.copyWith(
          color: lightTextPrimary,
          fontWeight: FontWeight.bold,
        ),
        displayMedium: headingTheme.displayMedium?.copyWith(
          color: lightTextPrimary,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: headingTheme.headlineMedium?.copyWith(
          color: lightTextPrimary,
          fontWeight: FontWeight.w600,
        ),
        headlineSmall: headingTheme.headlineSmall?.copyWith(
          color: lightTextPrimary,
          fontWeight: FontWeight.w600,
        ),
        titleLarge: headingTheme.titleLarge?.copyWith(
          color: lightTextPrimary,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: headingTheme.titleMedium?.copyWith(
          color: lightTextPrimary,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: baseTextTheme.bodyLarge?.copyWith(
          color: lightTextPrimary,
          fontSize: 16,
        ),
        bodyMedium: baseTextTheme.bodyMedium?.copyWith(
          color: lightTextMuted,
          fontSize: 14,
        ),
        labelLarge: headingTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: lightBg,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        iconTheme: const IconThemeData(color: lightTextPrimary),
        titleTextStyle: GoogleFonts.poppins(
          color: lightTextPrimary,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      cardTheme: CardThemeData(
        color: lightSurface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: lightBorder, width: 1),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: lightBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: lightBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: destructiveColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: destructiveColor, width: 2),
        ),
        labelStyle: TextStyle(color: lightTextMuted, fontSize: 14),
        hintStyle: TextStyle(color: lightTextMuted.withValues(alpha: 0.7), fontSize: 14),
        prefixIconColor: lightTextMuted,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: GoogleFonts.poppins(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        contentTextStyle: GoogleFonts.openSans(color: Colors.white, fontSize: 14),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: lightSurface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: lightSurface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
      ),
    );
  }

  static ThemeData darkTheme() {
    final baseTextTheme = GoogleFonts.openSansTextTheme();
    final headingTheme = GoogleFonts.poppinsTextTheme();

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: darkBg,
      colorScheme: ColorScheme.dark(
        primary: const Color(0xFF60A5FA),
        onPrimary: darkBg,
        secondary: const Color(0xFF818CF8),
        onSecondary: darkBg,
        tertiary: const Color(0xFF34D399),
        onTertiary: darkBg,
        surface: darkSurface,
        onSurface: darkTextPrimary,
        error: const Color(0xFFF87171),
        onError: darkBg,
        outline: darkBorder,
      ),
      textTheme: baseTextTheme.copyWith(
        displayLarge: headingTheme.displayLarge?.copyWith(
          color: darkTextPrimary,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: headingTheme.headlineMedium?.copyWith(
          color: darkTextPrimary,
          fontWeight: FontWeight.w600,
        ),
        titleLarge: headingTheme.titleLarge?.copyWith(
          color: darkTextPrimary,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: headingTheme.titleMedium?.copyWith(
          color: darkTextPrimary,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: baseTextTheme.bodyLarge?.copyWith(
          color: darkTextPrimary,
          fontSize: 16,
        ),
        bodyMedium: baseTextTheme.bodyMedium?.copyWith(
          color: darkTextMuted,
          fontSize: 14,
        ),
        labelLarge: headingTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: darkBg,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        iconTheme: const IconThemeData(color: darkTextPrimary),
        titleTextStyle: GoogleFonts.poppins(
          color: darkTextPrimary,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      cardTheme: CardThemeData(
        color: darkCard,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: darkBorder, width: 1),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: darkSurface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: darkBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: darkBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFF60A5FA), width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: destructiveColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: destructiveColor, width: 2),
        ),
        labelStyle: TextStyle(color: darkTextMuted, fontSize: 14),
        hintStyle: TextStyle(color: darkTextMuted.withValues(alpha: 0.7), fontSize: 14),
        prefixIconColor: darkTextMuted,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2563EB),
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: GoogleFonts.poppins(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: const Color(0xFF2563EB),
        foregroundColor: Colors.white,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: darkSurface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        contentTextStyle: GoogleFonts.openSans(color: darkTextPrimary, fontSize: 14),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: darkSurface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: darkSurface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
      ),
    );
  }
}
