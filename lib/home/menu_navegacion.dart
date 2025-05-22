import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moon_aplication/shared/app_theme.dart'; //  Importa AppTheme para obtener el scaleFactor
import 'package:moon_aplication/home/botones/boton_home.dart';
import 'package:moon_aplication/home/botones/boton_likes.dart';
import 'package:moon_aplication/home/botones/boton_perfil.dart';
import 'package:moon_aplication/home/botones/boton_reservar.dart';

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
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final double scaleFactor = AppTheme.scaleFactor(context); //  Obtiene el factor de escala dinámico
    final double bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      extendBody: true,
      body: child,
      bottomNavigationBar: SafeArea(
        bottom: false,
        child: Transform.translate(
          offset: Offset(0, -bottomPadding * 0.7),
          child: Container(
            height: 60 * scaleFactor, //  Ajusta la altura dinámicamente
            decoration: BoxDecoration(
              color: Theme.of(context).navigationBarTheme.backgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20 * scaleFactor), //  Escala el borde
                topRight: Radius.circular(20 * scaleFactor),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20 * scaleFactor),
                topRight: Radius.circular(20 * scaleFactor),
              ),
              child: NavigationBar(
                height: 60 * scaleFactor, //  Ajusta la altura dinámicamente
                destinations: [
                  _buildIcon(BotonHome.icono(), scaleFactor),
                  _buildIcon(BotonReservar.icono(), scaleFactor),
                  _buildIcon(BotonLikes.icono(), scaleFactor),
                  _buildIcon(BotonPerfil.icono(), scaleFactor),
                ],
                onDestinationSelected: (int index) {
                  switch (index) {
                    case 0: context.go('/home'); break;
                    case 1: context.go('/reservar'); break;
                    case 2: context.go('/likes'); break;
                    case 3: context.go('/perfil'); break;
                  }
                },
                indicatorColor: Theme.of(context).navigationBarTheme.indicatorColor,
                selectedIndex: _getCurrentIndex(context),
              ),
            ),
          ),
        ),
      ),
    );
  }

  ///  Escala los íconos según el tamaño del dispositivo
  Widget _buildIcon(NavigationDestination icono, double scaleFactor) {
    return NavigationDestination(
      icon: Padding(
        padding: EdgeInsets.only(top: 5 * scaleFactor), //  Escala el padding superior
        child: icono.icon,
      ),
      selectedIcon: Padding(
        padding: EdgeInsets.only(top: 5 * scaleFactor), //  También escala el ícono seleccionado
        child: icono.selectedIcon,
      ),
      label: icono.label,
    );
  }
}