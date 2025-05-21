import 'package:flutter/material.dart';
import 'package:moon_aplication/router/router_app.dart';
import 'package:moon_aplication/shared/app_theme.dart'; // Asegúrate de importar el archivo de router

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Moon Reservas',
      theme: AppTheme().getTheme(),
      routerConfig: router,
    );
  }
}