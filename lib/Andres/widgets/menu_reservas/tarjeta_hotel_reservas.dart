import 'package:flutter/material.dart';
import 'package:moon_aplication/Andrea/models/hotel.dart';
import 'package:moon_aplication/Andres/widgets/menu_hoteles/tarjeta/imagen_tarjeta.dart';
import 'package:moon_aplication/Andres/widgets/menu_likes/hoteles_megusta_interactivo.dart';
import 'package:moon_aplication/shared/app_theme.dart';

class TarjetaHotelReservas extends StatelessWidget {
  final Hotel hotel;
  final VoidCallback onTap;

  const TarjetaHotelReservas({super.key, required this.hotel, required this.onTap});

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
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Container(
            height: 180, 
            padding: const EdgeInsets.fromLTRB(2, 1, 20, 1),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: SizedBox(
                    width: 120, 
                    height: 160,
                    child: ImagenTarjeta(hotel: hotel),
                  ),
                ),
                const SizedBox(width: 20),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              hotel.nombre,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          HotelesMeGustaInteractivo(hotelId: hotel.id),
                        ],
                      ),
                      const SizedBox(height: 8),

                      Text(
                        "\$${hotel.precioNoche} / noche",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(height: 8),

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
                      const SizedBox(height: 8),

                      Flexible(
                        child: Column(
                          children: [
                            Text(
                              hotel.descripcion,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 2), 
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}