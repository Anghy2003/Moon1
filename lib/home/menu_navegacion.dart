// lib/home/menu_navegacion.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moon_aplication/home/botones/boton_home.dart';
import 'package:moon_aplication/home/botones/boton_likes.dart';
import 'package:moon_aplication/home/botones/boton_perfil.dart';
import 'package:moon_aplication/home/botones/boton_reservar.dart';

// Extensión para obtener la ubicación actual usando el routerDelegate
extension RouterLocationExtension on BuildContext {
  String get currentRouterLocation {
    return GoRouter.of(this).routerDelegate.currentConfiguration.uri.toString();
  }
}

class MenuNavegacion extends StatelessWidget {
  final Widget child;
  const MenuNavegacion({super.key, required this.child});

  int _getCurrentIndex(BuildContext context) {
    final location = context.currentRouterLocation;
    if (location == '/reservar') return 1;
    if (location == '/likes') return 2;
    if (location == '/perfil') return 3;
    return 0; // Para '/home' o cualquier otro caso se queda en 0.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child, // aquí se mostrará la pantalla según la ruta interna
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).navigationBarTheme.backgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: NavigationBar(
            onDestinationSelected: (int index) {
              switch (index) {
                case 0:
                  context.go('/home'); // Navega a la ruta '/home'
                  break;
                case 1:
                  context.go('/reservar');
                  break;
                case 2:
                  context.go('/likes');
                  break;
                case 3:
                  context.go('/perfil');
                  break;
              }
            },
            indicatorColor:
                Theme.of(context).navigationBarTheme.indicatorColor,
            selectedIndex: _getCurrentIndex(context),
            destinations: [
              BotonHome.icono(),
              BotonReservar.icono(),
              BotonLikes.icono(),
              BotonPerfil.icono(),
            ],
          ),
        ),
      ),
    );
  }
}