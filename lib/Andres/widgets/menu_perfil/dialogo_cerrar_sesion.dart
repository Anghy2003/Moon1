import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:moon_aplication/services/services/usuario_actual.dart';

void dialogoCerrarSesion(BuildContext context) {
  final User? usuario = FirebaseAuth.instance.currentUser;
  final String nombreUsuario = usuario?.displayName ?? "Usuario desconocido";

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      final theme = Theme.of(context);

      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Cerrar Sesión',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        content: Text.rich(
          TextSpan(
            children: [
              const TextSpan(text: "¿Estás seguro de salir de la cuenta de ",style: TextStyle(fontSize: 17)),
              TextSpan(
                text: nombreUsuario,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              const TextSpan(text: "?"),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Cancelar',
              style: TextStyle(color: theme.colorScheme.primary),
            ),
          ),
          TextButton(
            onPressed: () async {
              UsuarioActual.ubicacion='';
              await GoogleSignIn().signOut();
              await FirebaseAuth.instance.signOut();
              if (context.mounted) {
                Navigator.pop(context);
                context.go('/first'); // Redirige a la pantalla de login
              }
            },
            child: const Text('Cerrar', style: TextStyle(color: Colors.red)),
          ),
        ],
      );
    },
  );
}