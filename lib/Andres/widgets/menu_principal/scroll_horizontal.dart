import 'package:flutter/material.dart';
import 'package:moon_aplication/Andrea/models/hotel.dart';
import 'package:moon_aplication/Andrea/screens/hotel-detalles_screen.dart';
import 'package:moon_aplication/Andres/controller/hotel_controller.dart';
import 'package:moon_aplication/Andres/widgets/menu_principal/cada_hotel.dart';

class ScrollHorizontal extends StatefulWidget {
  const ScrollHorizontal({super.key});

  @override
  State<ScrollHorizontal> createState() => _ScrollHorizontalState();
}

class _ScrollHorizontalState extends State<ScrollHorizontal> {
  final PageController _pageController = PageController(
    viewportFraction: 0.4, 
    initialPage: 0,
  );

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Hotel>>(
      future: obtenerTopHoteles(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No hay hoteles disponibles'));
        }

        final List<Hotel> hoteles = snapshot.data!;
        return SizedBox(
          height: 230,
          child: PageView.builder(
            controller: _pageController,
            padEnds: false,
            scrollDirection: Axis.horizontal,
            itemCount: hoteles.length,
            itemBuilder: (context, index) {
              return AnimatedBuilder(
                animation: _pageController,
                builder: (context, child) {
                  double currentPage = _pageController.hasClients
                      ? _pageController.page ?? 0
                      : 0;
                  double diff = (currentPage - index).abs();
                  double scaleFactor =
                      1.0 + (1 - diff.clamp(0.0, 1.0)) * 0.2666;
                  return Center(
                    child: Transform.scale(
                      scale: scaleFactor,
                      alignment: Alignment.center,
                      child: child,
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 13),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              HoteldetallesScreen(idHotel: hoteles[index].id),
                        ),
                      );
                    },
                    child: CadaHotel(hotel: hoteles[index]),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}