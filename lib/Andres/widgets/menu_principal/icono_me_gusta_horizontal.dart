import 'package:flutter/material.dart';

class IconoMeGustaHorizontal extends StatelessWidget {
  final Color color; // Permite cambiar el color dinámicamente

  const IconoMeGustaHorizontal({
    super.key,
    this.color = Colors.red, // Rojo por defecto
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.favorite,
      color: color, // Usa el color pasado como parámetro
      size: 22,
    );
  }
}