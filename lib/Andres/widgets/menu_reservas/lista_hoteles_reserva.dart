import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moon_aplication/Andrea/models/hotel.dart';
import 'package:moon_aplication/Andres/screens/hotel_detalles_reserva_screen.dart';
import 'package:moon_aplication/Andres/widgets/menu_reservas/hotel_seleccionado_reservas.dart';
import 'package:moon_aplication/services/services/usuario_actual.dart';

class ListaHotelesReserva extends StatefulWidget {
  final Future<List<Map<String, dynamic>>> futureReservas;  
  final String searchQuery;
  final Future<void> Function() onRefresh;

  const ListaHotelesReserva({
    super.key,
    required this.futureReservas,  
    required this.searchQuery,
    required this.onRefresh,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ListaHotelesReservaState createState() => _ListaHotelesReservaState();
}

class _ListaHotelesReservaState extends State<ListaHotelesReserva> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
   
  Future<bool> verificarFavorito(String idHotel) async {
    final String idUsuario = UsuarioActual.uid;
    if (idUsuario.isEmpty) return false;

    try {
      final querySnapshot = await _db.collection('usuariosLikes')
          .where('idUsuario', isEqualTo: idUsuario)
          .where('idHotel', isEqualTo: idHotel)
          .get();

      return querySnapshot.docs.isNotEmpty; 
    } catch (e) {
      debugPrint("Error verificando favorito: $e");
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: widget.onRefresh,
      child: FutureBuilder<List<Map<String, dynamic>>>(
        future: widget.futureReservas,  
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error al obtener los hoteles reservados: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay hoteles reservados'));
          }

          final List<Map<String, dynamic>> reservas = snapshot.data!;
          final String query = widget.searchQuery.toLowerCase();

          final List<Map<String, dynamic>> filteredReservas = reservas.where((reserva) {
            final Hotel hotel = reserva['hotel'] as Hotel;
            final bool matchesNombre = hotel.nombre.toLowerCase().contains(query);
            final bool matchesUbicacion = hotel.ubicacion.toLowerCase().contains(query);
            return matchesNombre || matchesUbicacion;
          }).toList();

          if (widget.searchQuery.isNotEmpty && filteredReservas.isEmpty) {
            return const Center(child: Text('No se encontraron hoteles reservados'));
          }

          return ListView.separated(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: filteredReservas.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final Hotel hotel = filteredReservas[index]['hotel'] as Hotel;
              final String idReserva = filteredReservas[index]['idReserva']?.toString() ?? 'Sin ID';

              return FutureBuilder<bool>(
                future: verificarFavorito(hotel.id),  
                builder: (context, snapshotFavorito) {
                  final bool esFavorito = snapshotFavorito.data ?? false;

                  return GestureDetector(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HoteldetallesReservaScreen(
                            idHotel: hotel.id,
                            idReserva: idReserva,
                          ),
                        ),
                      );
                      widget.onRefresh(); 
                    },
                    child: HotelSeleccionadoReservas(
                      hotel: hotel,
                      idReserva: idReserva,
                      esFavorito: esFavorito, 
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}