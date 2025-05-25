import 'package:flutter/material.dart';
import 'package:moon_aplication/Andrea/models/hotel.dart'; // 🔥 Importa el modelo Hotel

class NombreHotelTarjeta extends StatelessWidget {
  const NombreHotelTarjeta({
    super.key,
    required this.hotel,
  });

  final Hotel hotel; // 🔥 Ahora recibe un objeto `Hotel`

  @override
  Widget build(BuildContext context) {
    return Text(
      hotel.nombre, // 🔥 Usa `hotel.nombre` en lugar de `hotel['name']`
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      overflow: TextOverflow.ellipsis, // 🔥 Agrega "..." cuando el texto es demasiado largo
      maxLines: 1, // 🔥 Limita el texto a 1 línea
    );
  }
}