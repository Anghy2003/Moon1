import 'package:flutter/material.dart';
import 'package:moon_aplication/Andrea/screens/hotel-detalles_screen.dart';
import 'package:moon_aplication/Andres/widgets/menu_hoteles/tarjeta_hotel.dart';

class HotelSeleccionado extends StatelessWidget {
  final Map<String, dynamic> hotel;

  const HotelSeleccionado({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    return TarjetaHotel(
      hotel: hotel,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HoteldetallesScreen(), 
          ),
        );
      },
    );
  }
}