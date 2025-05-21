// main.dart
import 'package:flutter/material.dart';
import 'package:moon_aplication/home/menu_navegacion.dart';
import 'package:moon_aplication/shared/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Moon Reservas',
      theme: AppTheme().getTheme(), // Aplica tu tema personalizado
      home: const MenuNavegacion(), // Se inicia con MenuNavegacion
    );
  }
}