import 'package:flutter/material.dart';

class BotonLikes extends StatelessWidget {
  const BotonLikes({super.key});

  static NavigationDestination icono() => const NavigationDestination(
    selectedIcon: Icon(Icons.favorite, color: Color(0xFF00BECF)), // Turquesa al seleccionarse
    icon: Icon(Icons.favorite, color: Colors.white),         // Blanco por defecto
    label: '',
  );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Tus favoritos están aquí!',
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}