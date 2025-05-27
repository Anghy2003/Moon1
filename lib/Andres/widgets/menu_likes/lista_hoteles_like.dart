import 'package:flutter/material.dart';
import 'package:moon_aplication/Andrea/models/hotel.dart';
import 'package:moon_aplication/Andres/widgets/menu_likes/hotel_seleccionado_likes.dart';

class ListaHotelesLike extends StatelessWidget {
  final Future<List<Hotel>> futureHoteles;
  final String searchQuery;
  final Future<void> Function() onRefresh;

  const ListaHotelesLike({
    super.key,
    required this.futureHoteles,
    required this.searchQuery,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: FutureBuilder<List<Hotel>>(
        future: futureHoteles,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error al obtener los hoteles: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay hoteles disponibles'));
          }

          final List<Hotel> hoteles = snapshot.data!;
          final String query = searchQuery.toLowerCase();

          final List<Hotel> filteredHoteles = hoteles.where((hotel) {
            final bool matchesNombre = hotel.nombre.toLowerCase().contains(query);
            final bool matchesUbicacion = hotel.ubicacion.toLowerCase().contains(query);
            return matchesNombre || matchesUbicacion;
          }).toList();

          if (searchQuery.isNotEmpty && filteredHoteles.isEmpty) {
            return const Center(child: Text('No se encontraron hoteles'));
          }

          return ListView.separated(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: filteredHoteles.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) => HotelSeleccionadoLikes(hotel: filteredHoteles[index]),
          );
        },
      ),
    );
  }
}