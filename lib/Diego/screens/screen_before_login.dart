import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // ¡Usa GoRouter!
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

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;

      // ✅ Usa GoRouter para navegar correctamente
      context.go('/login');
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
                  const SizedBox(height: 2),
                  Text(
                    "Reserva fácil y rápido",
                    style: Theme.of(context).textTheme.headlineLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 90),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
