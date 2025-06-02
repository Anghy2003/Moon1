import 'package:flutter/material.dart';

class IconoMeGustaHorizontal extends StatelessWidget {
  final bool esFavorito;

  const IconoMeGustaHorizontal({
    super.key,
    required this.esFavorito,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(0),
        shape: BoxShape.circle,
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(6),
      child: Icon(
        esFavorito ? Icons.favorite : Icons.favorite_border,
        size: 22,
        color: Colors.redAccent,
      ),
    );
  }
}