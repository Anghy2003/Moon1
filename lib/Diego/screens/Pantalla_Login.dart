import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import '../theme/theme.dart';
import '../Buttons/botones_login.dart';

class PantallaLogin extends StatelessWidget {
  const PantallaLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.backgroundGradient,
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo SVG
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 20),
                  //   child: AspectRatio(
                  //     aspectRatio: 1,
                  //     child: SvgPicture.asset(
                  //       "assets/moon_logo.svg", // Asegúrate que el archivo esté en tu carpeta assets
                  //       fit: BoxFit.contain,
                  //       alignment: Alignment.center,
                  //     ),
                  //   ),
                  // ),

                  const SizedBox(height: 30),

                  // Título
                  Text(
                    "Reserva fácil y rápido",
                    style: Theme.of(context).textTheme.headlineLarge,
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 30),

                  // Botones de autenticación
                  const BotonesLogin(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
