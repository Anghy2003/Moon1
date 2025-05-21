import 'package:flutter/material.dart';
import 'package:moon_aplication/home/botones/boton_home.dart';
import 'package:moon_aplication/home/botones/boton_likes.dart';
import 'package:moon_aplication/home/botones/boton_perfil.dart';
import 'package:moon_aplication/home/botones/boton_reservar.dart';

class MenuNavegacion extends StatefulWidget {
  const MenuNavegacion({super.key});

  @override
  State<MenuNavegacion> createState() => NavegacionState();
}

class NavegacionState extends State<MenuNavegacion> {
  int currentPageIndex = 0;

  final List<Widget> _pages = const [
    BotonHome(),
    BotonReservar(),
    BotonLikes(),
    BotonPerfil(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).navigationBarTheme.backgroundColor, // Fondo turquesa
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ), // Bordes redondeados superiores
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ), // Se recorta el contenido al mismo radio
          child: NavigationBar(
            onDestinationSelected: (int index) {
              setState(() {
                currentPageIndex = index;
              });
            },
            indicatorColor: Theme.of(context).navigationBarTheme.indicatorColor,
            selectedIndex: currentPageIndex,
            destinations: [
              BotonHome.icono(),
              BotonReservar.icono(),
              BotonLikes.icono(),
              BotonPerfil.icono(),
            ],
          ),
        ),
      ),
      body: _pages[currentPageIndex],
    );
  }
}