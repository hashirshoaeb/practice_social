import 'package:flutter/material.dart';

class AppTheme {
  static const String fontFamily = 'Proxima Nova';

  static ThemeData lightTheme = ThemeData(
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.black,
    fontFamily: 'Proxima Nova',
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white),
      bodySmall: TextStyle(color: Colors.white),
      titleLarge: TextStyle(color: Colors.white),
      titleMedium: TextStyle(color: Colors.white),
      titleSmall: TextStyle(color: Colors.white),
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      surface: Colors.black,
      onSurface: Colors.white,
      secondary: Colors.white,
    ),
  );
}
