import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // Importante para usar context.go()
import 'package:moon_aplication/Diego/widgets/crazy_logo.dart';
import '../theme/theme.dart';

class ScreenBeforeLogin extends StatefulWidget {
  const ScreenBeforeLogin({super.key});

  @override
  State<ScreenBeforeLogin> createState() => _ScreenBeforeLoginState();
}

class _ScreenBeforeLoginState extends State<ScreenBeforeLogin> {
  @override
  void initState() {
    super.initState();

    // Después de 1 segundo, navega a /login usando GoRouter
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      context.go('/login'); // <-- Usa GoRouter
    });
  }

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
                  const CrazyLogo(),
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
