import 'package:flutter/material.dart';

class BuscarHoteles extends StatelessWidget {
  const BuscarHoteles({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Accede al tema definido en AppTheme

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: SizedBox(
        height: 70, // Ajusta la altura del buscador
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Buscar hotel para reservar',
            hintStyle: TextStyle(color: theme.colorScheme.onSurfaceVariant), // Color del texto desde AppTheme
            prefixIcon: Icon(Icons.search, color: theme.colorScheme.onSurfaceVariant), // Color del icono desde AppTheme
            filled: true,
            fillColor: theme.colorScheme.surface, // Fondo blanco segn AppTheme
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: theme.colorScheme.primary, width: 2), // Borde turquesa desde AppTheme
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: theme.colorScheme.primary, width: 2), // Borde turquesa desde AppTheme
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: theme.colorScheme.primary, width: 2), // Borde turquesa cuando esta enfocado
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 25, horizontal: 16), // Aumenta la altura interna
          ),
        ),
      ),
    );
  }
}