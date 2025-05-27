import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: Color(0xFF1E3A8A), // Color base
    scaffoldBackgroundColor: Colors.transparent, // Para permitir fondo degradado
    textTheme: TextTheme(
      headlineLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
      bodyLarge: TextStyle(fontSize: 16, color: Colors.white),
    ),
  );

 static const LinearGradient backgroundGradient = LinearGradient(
  colors: [
    Color(0xFF00C0D5), // Color turquesa arriba
    Color(0xFFFFFFFF), // Blanco en el centro
    Color(0xFF00C0D5), // Color turquesa abajo
  ],
  stops: [0.0, 0.5, 1.0], // Define los puntos de transición
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);
}