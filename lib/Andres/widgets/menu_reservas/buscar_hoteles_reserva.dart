import 'package:flutter/material.dart';

class BuscarHotelesReserva extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const BuscarHotelesReserva({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: SizedBox(
        height: 70,
        child: TextField(
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: 'Buscar hoteles reservados',
            hintStyle: TextStyle(color: theme.colorScheme.onSurfaceVariant),
            prefixIcon: Icon(Icons.search, color: theme.colorScheme.onSurfaceVariant),
            filled: true,
            fillColor: theme.colorScheme.surface,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: theme.colorScheme.primary, width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: theme.colorScheme.primary, width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: theme.colorScheme.primary, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 25, horizontal: 16),
          ),
        ),
      ),
    );
  }
}