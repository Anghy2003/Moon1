import 'package:flutter/material.dart';
//import 'package:moon_aplication/Diego/widgets/logo_widget.dart';
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
               //   const LogoWidget(), // Aquí insertamos el widget del logo

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
