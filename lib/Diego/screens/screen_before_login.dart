import 'package:flutter/material.dart';
import '../theme/theme.dart';
import '../widgets/logo_widget.dart'; // Asegúrate de ajustar la ruta según tu estructura

class ScreenBeforeLogin extends StatelessWidget {
  const ScreenBeforeLogin({super.key});

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
                  const LogoWidget(), // Aquí insertamos el widget del logo

                  const SizedBox(height: 30),

                  Text(
                    "Reserva fácil y rápido",
                    style: Theme.of(context).textTheme.headlineLarge,
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 30),
                 
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
