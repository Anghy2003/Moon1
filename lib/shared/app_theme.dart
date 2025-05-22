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

    // Configuración de la barra de navegación
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: primaryColor,
      indicatorColor: Colors.white,
      surfaceTintColor: Colors.transparent,
    ),
  );

  // 🔥 Método global para calcular el factor de escala basado en el tamaño del dispositivo
  static double scaleFactor(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth / 400; // 400 es una referencia de tamaño base
  }
}