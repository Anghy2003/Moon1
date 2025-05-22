import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; 

void dialogoCerrarSesion(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, //  Evita que se cierre al tocar fuera del cuadro
    builder: (BuildContext context) {
      final theme = Theme.of(context);

      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text(
          'Cerrar Sesión',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        content: const Text('¿Estás seguro de salir de la cuenta de Andrea Illescas?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); //  Cierra el dialogo sin cerrar sesion
            },
            child: Text('Cancelar', style: TextStyle(color: theme.colorScheme.primary)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); //  Cierra el dialogo
              context.go('/home'); 
            },
            child: const Text('Cerrar', style: TextStyle(color: Colors.red)),
          ),
        ],
      );
    },
  );
}