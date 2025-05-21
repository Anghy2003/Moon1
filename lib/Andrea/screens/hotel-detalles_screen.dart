import 'package:flutter/material.dart';
 class HoteldetallesScreen extends  StatelessWidget {
 final String hotelName;
  final String description;
  final String imageUrl;
  final List<String> facilities;
 const HoteldetallesScreen({
    super.key,
    this.hotelName = 'Nombre del hotel',
    this.description = 'Descripción de ejemplo del hotel.',
    this.imageUrl = 'https://a.travel-assets.com/findyours-php/viewfinder/images/res40/331000/331911-Grand-Fiesta-Americana-Coral-Beach-Cancun.jpg',
    this.facilities = const ['WiFi', 'Piscina', 'Gimnasio'],
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(hotelName),
        centerTitle: true,
        backgroundColor: Colors.cyan[600],
      ),
      body: Column(
        children: [
          // Imagen del hotel
          Image.network(
            imageUrl,
            height: 220,
            width: double.infinity,
            fit: BoxFit.cover,
          ),

          // Descripcion y facilidades
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  Text(
                    hotelName,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    description,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "Facilidades",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 12,
                    children: facilities.map((facility) {
                      return Chip(
                        label: Text(facility),
                        backgroundColor: Colors.cyan[100],
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),

          // boton para continuar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/select_dates');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyan[600],
                minimumSize: const Size.fromHeight(50),
              ),
              child: const Text(
                'Reservar ahora',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

 