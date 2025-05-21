import 'package:flutter/material.dart';
import 'package:moon_aplication/Andres/widgets/imagen_tarjeta.dart';

class TarjetaHotel extends StatelessWidget {
  final Map<String, dynamic> hotel;
  final VoidCallback onTap; // ✅ Agregamos la función de clic

  const TarjetaHotel({super.key, required this.hotel, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // ✅ Se activa el clic en la tarjeta
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.symmetric(vertical: 10), // Aumenta la separación entre tarjetas
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          height: 150, // Ajusta la altura de la tarjeta
          padding: const EdgeInsets.all(12), // Espaciado interno más amplio
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: ImagenTarjeta(hotel: hotel),
              ),
              const SizedBox(width: 20), // Más espacio entre imagen y texto
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      hotel['name'],
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const SizedBox(height: 6), // Espaciado extra entre título y ubicación
                    Row(
                      children: [
                        const Icon(Icons.location_on, color: Colors.grey, size: 18), // Icono de ubicación gris
                        const SizedBox(width: 6),
                        Text(
                          hotel['location'],
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8), // Más espacio antes del rating
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.yellow, size: 20),
                        const SizedBox(width: 4),
                        Text(hotel['rating'].toString()),
                      ],
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