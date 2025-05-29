import 'package:flutter/material.dart';
class IconoMeGustaDetalles extends StatelessWidget {
  const IconoMeGustaDetalles({
    super.key,
    required this.esFavorito,
  });

  final bool esFavorito;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
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
        size: 28,
        color: Colors.redAccent,
      ),
    );
  }
}
