import 'package:flutter/material.dart';
import 'package:moon_aplication/Andrea/controllers/hotelControlador.dart';
import 'package:moon_aplication/Andrea/models/hotel.dart';


class HoteldetallesScreen extends StatelessWidget {
  final String idHotel;

  const HoteldetallesScreen({super.key, required this.idHotel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFebebf5),
      body: FutureBuilder<Hotel>(
        future: obtenerHotelPorId(idHotel),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('Hotel no encontrado'));
          }

          final hotel = snapshot.data!;

          return Column(
            children: [
              const SizedBox(height: 30),
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.network(
                        hotel.imagenPrincipal,
                        height: 280,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 30,
                    right: 30,
                    child: SizedBox(
                      height: 60,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: hotel.imagenes.map((imgUrl) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 6),
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                image: NetworkImage(imgUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  )
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ListView(
                    children: [
                      Text(
                        hotel.nombre,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 20),
                          SizedBox(width: 4),
                          Text("4.5 (355 Reviews)", style: TextStyle(fontSize: 14)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        hotel.descripcion,
                        style: const TextStyle(fontSize: 15),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        "Facilidades",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: hotel.facilidades.map((f) {
                            final icon = _getIconFromString(f.icon);
                            return Container(
                              width: 80,
                              margin: const EdgeInsets.only(right: 12),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                children: [
                                  Icon(icon, color: Colors.grey[500]),
                                  const SizedBox(height: 8),
                                  Text(
                                    f.label,
                                    style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Total",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "\$${hotel.precio.toStringAsFixed(2)}",
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back, size: 30, color: Colors.cyan),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// Esta función convierte un nombre de ícono a IconData
IconData _getIconFromString(String iconName) {
  switch (iconName) {
    case 'wifi':
      return Icons.wifi;
    case 'pool':
      return Icons.pool;
    case 'restaurant':
      return Icons.restaurant;
    case 'bathtub':
      return Icons.bathtub;
    case 'heater':
      return Icons.fireplace;
    default:
      return Icons.help_outline;
  }
}
