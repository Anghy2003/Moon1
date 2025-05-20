import 'package:flutter/material.dart';

class ApTheme {
 ThemeData getTheme() => ThemeData(
  
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF00BECF),
      brightness: Brightness.light, // O Brightness.dark si prefieres
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF00BECF),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: const Color(0xFF00BECF),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFF00BECF),
        side: const BorderSide(color: Color(0xFF00BECF)),
      ),
    ),
  );
}
