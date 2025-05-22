import 'package:flutter/material.dart';

class EstiloBotonPerfil extends StatelessWidget {
  final Map<String, dynamic> boton;

  const EstiloBotonPerfil({super.key, required this.boton});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 3),
      child: OutlinedButton(
        onPressed: () {
          if (boton.containsKey('onPressed') && boton['onPressed'] != null) {
            boton['onPressed']!(context); // 🔥 Pasa el `context` a la función
          }
        },
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          side: BorderSide(color: theme.colorScheme.primary, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 17),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                boton['text'] as String? ?? 'Sin título',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Icon(
                boton['icon'] as IconData? ?? Icons.error,
                color: theme.colorScheme.primary,
                size: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}