import 'package:flutter/material.dart';
import 'package:moon_aplication/Andres/screens/menu_principal_screen.dart';

class BotonHome extends StatelessWidget {
  const BotonHome({super.key});

  static NavigationDestination icono() => const NavigationDestination(
        selectedIcon: Icon(Icons.confirmation_number_outlined, color: Color(0xFF00BECF)), // Turquesa al seleccionarse
        icon: Icon(Icons.confirmation_number_outlined, color: Colors.white),              // Blanco por defecto
        label: '',
      );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(0),
        padding: const EdgeInsets.all(0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey),
        ),
        child: MenuPrincipalScreen(),
      ),
    );
  }
}

