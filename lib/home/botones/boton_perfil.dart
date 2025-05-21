import 'package:flutter/material.dart';

class BotonPerfil extends StatelessWidget {
  const BotonPerfil({super.key});

  static NavigationDestination icono() => const NavigationDestination(
    selectedIcon: Icon(Icons.person, color: Color(0xFF00BECF)), // Turquesa al seleccionarse
    icon: Icon(Icons.person_outline, color: Colors.white),         // Blanco por defecto
    label: '',
  );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Este es tu perfil!',
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}