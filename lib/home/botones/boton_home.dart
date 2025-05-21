import 'package:flutter/material.dart';

class BotonHome extends StatelessWidget {
  const BotonHome({super.key});

  static NavigationDestination icono() => const NavigationDestination(
    selectedIcon: Icon(Icons.home, color: Color(0xFF00BECF)), // Turquesa al seleccionarse
    icon: Icon(Icons.home, color: Colors.white),          // Blanco por defecto
    label: '',
  );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Bienvenido al Menú Principal',
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}