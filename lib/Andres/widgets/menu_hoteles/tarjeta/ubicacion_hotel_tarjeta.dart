import 'package:flutter/material.dart';
import 'package:moon_aplication/Andrea/models/hotel.dart'; // 🔥 Importa el modelo Hotel

class UbicacionHotelTarjeta extends StatelessWidget {
  const UbicacionHotelTarjeta({
    super.key,
    required this.hotel,
  });

  final Hotel hotel; // 🔥 Ahora recibe un objeto `Hotel`

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        hotel.ubicacion, // 🔥 Usa la propiedad correcta definida en `Hotel`
        style: const TextStyle(fontSize: 16),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
  }
}