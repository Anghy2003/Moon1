import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:moon_aplication/Andres/controller/ubicacion_service.dart';
import 'package:moon_aplication/services/services/google_auth_services.dart';
import 'package:moon_aplication/services/services/usuario_actual.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class BotonesLogin extends StatefulWidget {
  const BotonesLogin({super.key});

  @override
  State<BotonesLogin> createState() => _BotonesLoginState();
}

class _BotonesLoginState extends State<BotonesLogin>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
      lowerBound: 0.8,
      upperBound: 1.0,
    );
    _scale = CurvedAnimation(parent: _controller, curve: Curves.bounceOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _handlePressed(BuildContext context) async {
    await _controller.reverse(); // animación bounce
    await _controller.forward();

    // Mostrar diálogo de carga
    showDialog(
      context: context,
      barrierDismissible: false, // Evita que se cierre al tocar fuera
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text(
                'Cargando...',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              SpinKitSpinningLines(
                color: Color(0xFF00BECF),
                size: 50.0,
              ),
            ],
          ),
        );
      },
    );

    final userCredential = await GoogleAuthService.signInWithGoogle();
    final user = userCredential?.user;

    String ubicacionObtenida = await UbicacionService.obtenerUbicacion();
    UsuarioActual.ubicacion = ubicacionObtenida;

    // Cierra el diálogo de carga
    Navigator.of(context).pop();

    if (user != null) {
      UsuarioActual.cargarDesdeFirebase(user);
      context.go('/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Inicio de sesión cancelado')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        ScaleTransition(
          scale: _scale,
          child: OutlinedButton(
            onPressed: () => _handlePressed(context),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFF00BECF), width: 2),
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  'assets/logo_google.svg',
                  height: 24,
                  width: 24,
                ),
                const SizedBox(width: 12),
                const Text(
                  'Continuar con Google',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
