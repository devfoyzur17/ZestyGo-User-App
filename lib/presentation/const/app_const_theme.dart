import 'package:flutter/material.dart';

class AppConstTheme {
  static ThemeData defaultTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,

    splashFactory: NoSplash.splashFactory,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,

    fontFamily: 'Roboto',

    scaffoldBackgroundColor: AppConstColor.backgroundWhite,
    cardColor: AppConstColor.cardColor,
    dividerColor: AppConstColor.dividerColor,
    disabledColor: AppConstColor.disabledColor,

    primaryColor: AppConstColor.primaryColor,
    primarySwatch: AppConstColor.primaryColorColorSwatch,

    colorScheme: const ColorScheme.light(
      primary: AppConstColor.primaryColor,
      secondary: AppConstColor.primaryColor,
      background: AppConstColor.backgroundWhite,
      surface: AppConstColor.cardColor,

      onPrimary: Colors.black,
      onSecondary: Colors.black,
      onBackground: Colors.black,
      onSurface: Colors.black,

      error: Colors.red,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: AppConstColor.primaryColor,
      elevation: 0,
      centerTitle: true,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.black,
        letterSpacing: 0.5,
      ),
      iconTheme: IconThemeData(color: Colors.black),
    ),

    textTheme: _textTheme,
  );

  static const TextTheme _textTheme = TextTheme(
    headlineLarge: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w700,
      color: AppConstColor.textBlackColor,
    ),
    headlineMedium: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: AppConstColor.textBlackColor,
    ),
    titleLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: AppConstColor.textBlackColor,
    ),
    titleMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppConstColor.textBlackColor,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppConstColor.textBlackColor,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppConstColor.textBlackColor,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: AppConstColor.hintColor,
    ),
    labelMedium: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: AppConstColor.textBlackColor,
    ),
  );
}

class AppConstColor {
  // Main Brand Color
  static const Color primaryColor = Color(0xFFFEBC2F);

  static const MaterialColor primaryColorColorSwatch = MaterialColor(
    0xFFFEBC2F,
    <int, Color>{
      50: Color(0xFFFFF8E6),
      100: Color(0xFFFFEDB0),
      200: Color(0xFFFFE17A),
      300: Color(0xFFFFD544),
      400: Color(0xFFFECB1F),
      500: Color(0xFFFEBC2F),
      600: Color(0xFFE6A800),
      700: Color(0xFFCC9600),
      800: Color(0xFFB38300),
      900: Color(0xFF806000),
    },
  );

  // Backgrounds
  static const Color backgroundWhite = Color(0xFFFFFFFF);
  static const Color backgroundGray = Color(0xFFF8F9FB);

  // Cards & Containers
  static const Color cardColor = Color(0xFFFFFFFF);

  // Text Colors
  static const Color textWhiteColor = Color(0xFFFFFFFF);
  static const Color textBlackColor = Color(0xFF111827);

  // Utility Colors
  static const Color dividerColor = Color(0xFFE5E7EB);
  static const Color disabledColor = Color(0xFF9CA3AF);
  static const Color hintColor = Color(0xFF6B7280);
  static const Color indicatorColor = Color(0xFFFEBC2F);

  // Status Colors
  static const Color returnStatusColor = Color(0xFFEF4444);
  static const Color deliveryStatusColor = Color(0xFF22C55E);
  static const Color airportStatusColor = Color(0xFF14B8A6);
  static const Color pickupStatusColor = Color(0xFFA855F7);
  static const Color a2bStatusColor = Color(0xFFF97316);

  // Neutral Gray Swatch
  static const MaterialColor grayPrimaryColorSwatch =
  MaterialColor(0xFF9CA3AF, <int, Color>{
    50: Color(0xFFF9FAFB),
    100: Color(0xFFF3F4F6),
    200: Color(0xFFE5E7EB),
    300: Color(0xFFD1D5DB),
    400: Color(0xFF9CA3AF),
    500: Color(0xFF6B7280),
    600: Color(0xFF4B5563),
    700: Color(0xFF374151),
    800: Color(0xFF1F2937),
    900: Color(0xFF111827),
  });

  // Extra / UI
  static const Color splashYellow = Color(0xFFF8B429);
}