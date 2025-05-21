import 'package:flutter/material.dart';


class HoteldetallesScreen extends StatelessWidget {
  const HoteldetallesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final facilities = [
      {'icon': Icons.wifi, 'label': '1 Heater'},
      {'icon': Icons.restaurant, 'label': 'Dinner'},
      {'icon': Icons.bathtub, 'label': '1 Tub'},
      {'icon': Icons.pool, 'label': 'Pool'},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFebebf5),
      body: Column(
        children: [
          const SizedBox(height: 30), // o más alto según cuánto quieras bajar la foto

          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.network(
                    'https://a.travel-assets.com/findyours-php/viewfinder/images/res40/331000/331911-Grand-Fiesta-Americana-Coral-Beach-Cancun.jpg',
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
                    children: List.generate(6, (index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: NetworkImage(
                              'https://picsum.photos/id/10$index/200/200',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }),
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
                  const Text(
                    "Punta Cana",
                    style: TextStyle(
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
                  const Text(
                    "Estadía para 3 personas en el lujoso Paradisus Palma Real, con comidas incluidas. "
                    "Disfruta tours a Isla Saona y Altos de Chavón, con transporte incluido.",
                    style: TextStyle(fontSize: 15),
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
                      children: facilities.map((facility) {
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
                              Icon(facility['icon'] as IconData?, color: Colors.grey[500]),
                              const SizedBox(height: 8),
                              Text(
                               facility['label'] as String,
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
                  const Text(
                    "\$799",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green),
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
                  const SizedBox(height: 10),
                 
                ],
              ),
            ),
          ),
        ],
      ),
      
    );
  }
}
