import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; 

void dialogoCerrarSesion(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, 
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
        content: const Text('¿Estás seguro de salir de la cuenta de Meche?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); 
            },
            child: Text('Cancelar', style: TextStyle(color: theme.colorScheme.primary)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); 
              context.go('/first'); 
            },
            child: const Text('Cerrar', style: TextStyle(color: Colors.red)),
          ),
        ],
      );
    },
  );
}