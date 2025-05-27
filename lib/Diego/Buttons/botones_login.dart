import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moon_aplication/services/services/google_auth_services.dart';
import 'package:moon_aplication/services/services/usuario_actual.dart'; // Necesario para context.go


class BotonesLogin extends StatelessWidget {
  const BotonesLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Botón Iniciar sesión
        ElevatedButton(
          onPressed: () {
            print("Ir al login");
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
          ),
          child: const Text("Iniciar sesión"),
        ),

        const SizedBox(height: 20),

        // Botón Google
        ElevatedButton(
          onPressed: () async {
            final userCredential = await GoogleAuthService.signInWithGoogle();
            final user = userCredential?.user;

            if (user != null) {
              UsuarioActual.cargarDesdeFirebase(user);
              print("Nombre: ${UsuarioActual.nombre}");
              print("Correo: ${UsuarioActual.correo}");
              print("Foto URL: ${UsuarioActual.fotoUrl}");
              // Navega a /first después del inicio de sesión
              context.go('/home');
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Inicio de sesión cancelado')),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
          ),
          child: const Text('Continuar con Google'),
        ),
      ],
    );
  }
}
