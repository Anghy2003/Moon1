import 'package:flutter/material.dart';
import 'package:moon_aplication/Andrea/models/hotel.dart';

class UbicacionHotelTarjeta extends StatelessWidget {
  const UbicacionHotelTarjeta({
    super.key,
    required this.hotel,
  });

  final Hotel hotel; 

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        hotel.ubicacion, 
        style: const TextStyle(fontSize: 16),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
  }
}