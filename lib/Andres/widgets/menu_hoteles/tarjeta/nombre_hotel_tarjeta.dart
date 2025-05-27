import 'package:flutter/material.dart';
import 'package:moon_aplication/Andrea/models/hotel.dart'; 

class NombreHotelTarjeta extends StatelessWidget {
  const NombreHotelTarjeta({
    super.key,
    required this.hotel,
  });

  final Hotel hotel; 

  @override
  Widget build(BuildContext context) {
    return Text(
      hotel.nombre, 
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      overflow: TextOverflow.ellipsis, 
      maxLines: 1,
    );
  }
}