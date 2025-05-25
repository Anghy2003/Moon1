import 'package:flutter/material.dart';
import 'package:moon_aplication/Andrea/models/hotel.dart'; // 🔥 Importa el modelo Hotel

class ImagenTarjeta extends StatelessWidget {
  const ImagenTarjeta({
    super.key,
    required this.hotel,
  });

  final Hotel hotel; // 🔥 Ahora recibe un objeto `Hotel`

  @override
  Widget build(BuildContext context) {
    return Image.network(
      hotel.imagenPrincipal, // 🔥 Usa `hotel.imagenPrincipal` en lugar de `hotel['imageUrl']`
      width: 160,
      height: 130,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: 80,
          height: 80,
          color: Colors.grey.shade300,
          child: const Icon(Icons.error, color: Colors.red),
        );
      },
    );
  }
}