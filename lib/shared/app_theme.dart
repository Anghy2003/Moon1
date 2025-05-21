import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF00BECF); 

  ThemeData getTheme() => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.light(primary: primaryColor),

    // Estilos de botones
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: primaryColor),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryColor,
        side: const BorderSide(color: primaryColor),
      ),
    ),

    // Configuración de la barra de navegación (sin iconTheme, ya que está deprecado)
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: primaryColor, // Fondo turquesa
      indicatorColor: Colors.white, // Indicador blanco
      surfaceTintColor: Colors.transparent, // Evita alteraciones de color
      // Se eliminó iconTheme para evitar deprecation.
    ),
  );
}