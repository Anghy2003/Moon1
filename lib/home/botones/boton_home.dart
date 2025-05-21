import 'package:flutter/material.dart';

class BotonHome extends StatelessWidget {
  const BotonHome({super.key});

  static NavigationDestination icono() => const NavigationDestination(
    selectedIcon: Icon(Icons.home_filled, color: Color(0xFF00BECF)), // Turquesa al seleccionarse
    icon: Icon(Icons.home_filled, color: Colors.white),         // Blanco por defecto
    label: '',
  );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Menucito',
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}