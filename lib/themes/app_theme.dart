import 'package:flutter/material.dart';

class AppTheme {
  static const Color darkBlueBackground = Color(0xFF0A2342);
  static const Color cardBackground = Color(0xFF102C54);
  static const Color inputBackground = Color(0xFF19335A);
  static const Color advancedBackground = Color(0xFF142F4C);

  static ThemeData get darkTheme => ThemeData.dark().copyWith(
    scaffoldBackgroundColor: darkBlueBackground,
    primaryColor: Colors.blue[900],
    textTheme: ThemeData.dark().textTheme.apply(
      bodyColor: Colors.white,
      displayColor: Colors.white,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: inputBackground,
      border: OutlineInputBorder(),
      labelStyle: TextStyle(color: Colors.white),
    ),
  );

  static TextStyle get headlineStyle => const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static TextStyle get subtitleStyle => const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );

  static TextStyle get bodyStyle =>
      const TextStyle(fontSize: 14, color: Colors.white);
}
