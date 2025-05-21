import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moon_aplication/router/router_app.dart';
import 'package:moon_aplication/shared/app_theme.dart';

void main() {
  final theme = AppTheme().getTheme();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: theme.colorScheme.primary,
    systemNavigationBarIconBrightness: Brightness.light,
    statusBarColor: Colors.transparent,
  ));
  
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