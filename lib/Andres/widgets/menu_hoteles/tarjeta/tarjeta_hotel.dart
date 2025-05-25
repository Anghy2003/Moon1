import 'package:flutter/material.dart';
import 'package:moon_aplication/Andrea/models/hotel.dart';
import 'package:moon_aplication/Andres/widgets/menu_hoteles/tarjeta/imagen_tarjeta.dart';
import 'package:moon_aplication/Andres/widgets/menu_hoteles/tarjeta/nombre_hotel_tarjeta.dart';
import 'package:moon_aplication/Andres/widgets/menu_hoteles/tarjeta/precio_hotel_tarjeta.dart';
import 'package:moon_aplication/Andres/widgets/menu_hoteles/tarjeta/ubicacion_hotel_tarjeta.dart';
import 'package:moon_aplication/shared/app_theme.dart'; 

class TarjetaHotel extends StatelessWidget {
  final Hotel hotel; 
  final VoidCallback onTap;

  const TarjetaHotel({super.key, required this.hotel, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final double scaleFactor = AppTheme.scaleFactor(context);

    final int starCount = hotel.rating.round(); 

    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 3 * scaleFactor,
        margin: const EdgeInsets.symmetric(vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          height: 165,
          padding: const EdgeInsets.fromLTRB(2, 1, 20, 1),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: ImagenTarjeta(hotel: hotel,),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    NombreHotelTarjeta(hotel: hotel),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.location_on, color: Colors.grey, size: 18),
                        const SizedBox(width: 6),
                        UbicacionHotelTarjeta(hotel: hotel),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          hotel.rating.toString(), 
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 6),
                        Row(
                          children: List.generate(
                            starCount,
                            (index) => const Icon(Icons.star, color: Colors.yellow, size: 18),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: PrecioHotelTarjeta(hotel: hotel),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}