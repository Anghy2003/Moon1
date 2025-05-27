import 'package:flutter/material.dart';
import 'package:moon_aplication/Andrea/models/hotel.dart';
import 'package:moon_aplication/Andrea/screens/hotel-detalles_screen.dart'; 
import 'package:moon_aplication/Andres/widgets/menu_likes/tarjeta_hotel_likes.dart';

class HotelSeleccionadoLikes extends StatelessWidget {
  final Hotel hotel; 

  const HotelSeleccionadoLikes({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    return TarjetaHotelLikes(
      hotel: hotel, 
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HoteldetallesScreen(idHotel: hotel.id), 
          ),
        );
      },
    );
  }
}