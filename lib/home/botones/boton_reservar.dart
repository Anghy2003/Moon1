import 'package:flutter/material.dart';

class BotonReservar extends StatelessWidget {
  const BotonReservar({super.key});

  static NavigationDestination icono() => const NavigationDestination(
    selectedIcon: Icon(Icons.confirmation_number_outlined, color: Color(0xFF00BECF)), // Turquesa al seleccionarse
    icon: Icon(Icons.confirmation_number_outlined, color: Colors.white),         // Blanco por defecto
    label: '',
  );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Reserva tu lugar aquí!',
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}