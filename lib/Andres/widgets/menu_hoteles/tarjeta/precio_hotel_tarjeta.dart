import 'package:flutter/material.dart';
import 'package:moon_aplication/Andrea/models/hotel.dart'; 

class PrecioHotelTarjeta extends StatelessWidget {
  const PrecioHotelTarjeta({
    super.key,
    required this.hotel,
  });

  final Hotel hotel; 
  @override
  Widget build(BuildContext context) {
    return Text(
      "\$${hotel.precioNoche.toStringAsFixed(2)}/noche",
      style: const TextStyle(
        color: Colors.green,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}