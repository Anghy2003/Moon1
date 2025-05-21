import 'package:flutter/material.dart';
import 'package:moon_aplication/Andres/widgets/imagen_tarjeta.dart';

class TarjetaHotel extends StatelessWidget {
  final Map<String, dynamic> hotel;
  final VoidCallback onTap;

  const TarjetaHotel({super.key, required this.hotel, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final int starCount = (hotel['rating'] as num).round();

    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.symmetric(vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          height: 165, 
          padding: const EdgeInsets.fromLTRB(2, 1, 20, 1),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: ImagenTarjeta(hotel: hotel),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      hotel['name'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.location_on, color: Colors.grey, size: 18),
                        const SizedBox(width: 6),
                        Text(
                          hotel['location'],
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          hotel['rating'].toString(),
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
                    // 🔥 Precio alineado a la derecha dentro de la columna
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        hotel['price'] as String,
                        style: const TextStyle(
                          color: Colors.green,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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