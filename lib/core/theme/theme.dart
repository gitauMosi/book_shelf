import 'package:flutter/material.dart';

/// Light theme used across the app.
final ThemeData appThemeLight = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF46BD61),
    brightness: Brightness.light,
    primary: const Color(0xFF46BD61),
    secondary: const Color(0xFF6C8CFF),
    tertiary: const Color(0xFFFFB74D),
  ),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  typography: Typography.material2021(),
  textTheme: TextTheme(
    displayLarge: const TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.5,
    ),
    displayMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w600,
      color: Colors.grey[800],
    ),
    bodyLarge: TextStyle(fontSize: 16, height: 1.5, color: Colors.grey[700]),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.grey[50],
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: const Color(0xFF46BD61), width: 2),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
    hintStyle: TextStyle(color: Colors.grey[500]),
  ),

  bottomSheetTheme: const BottomSheetThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    backgroundColor: Colors.white,
    elevation: 0,
  ),
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  ),
  iconTheme: const IconThemeData(color: Color(0xFF46BD61), size: 24),
  dividerTheme: DividerThemeData(
    color: Colors.grey[200],
    thickness: 1,
    space: 0,
  ),
  appBarTheme: const AppBarTheme(
    elevation: 0,
    scrolledUnderElevation: 2,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    centerTitle: false,
    titleTextStyle: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
  ),
);

/// Dark theme variant for users who prefer dark mode.
final ThemeData appThemeDark = ThemeData(
  useMaterial3: true,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  typography: Typography.material2021(),
  scaffoldBackgroundColor: const Color(0xFF0B0B0C),
  textTheme: TextTheme(
    displayLarge: const TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.5,
      color: Colors.white,
    ),
    displayMedium: const TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    bodyLarge: const TextStyle(
      fontSize: 16,
      height: 1.5,
      color: Colors.white70,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.grey[900],
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: const Color(0xFF46BD61), width: 2),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
    hintStyle: TextStyle(color: Colors.grey[400]),
  ),

  bottomSheetTheme: const BottomSheetThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    backgroundColor: Color(0xFF111111),
    elevation: 0,
  ),
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  ),
  iconTheme: const IconThemeData(color: Colors.white, size: 24),
  dividerTheme: DividerThemeData(
    color: Colors.grey[800],
    thickness: 1,
    space: 0,
  ),
  appBarTheme: const AppBarTheme(
    elevation: 0,
    scrolledUnderElevation: 2,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    centerTitle: false,
    titleTextStyle: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
  ),
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF46BD61),
    brightness: Brightness.dark,
    primary: const Color(0xFF46BD61),
    secondary: const Color(0xFF6C8CFF),
    tertiary: const Color(0xFFFFB74D),
  ).copyWith(surface: const Color(0xFF0B0B0C)),
);

/// Helper to select theme by brightness.
ThemeData appThemeFor(Brightness brightness) =>
    brightness == Brightness.dark ? appThemeDark : appThemeLight;
