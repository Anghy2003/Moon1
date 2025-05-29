import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moon_aplication/Andrea/controllers/hotelControlador.dart';
import 'package:moon_aplication/Andrea/models/hotel.dart';
import 'package:moon_aplication/Andres/widgets/menu_detalles/detalles_reserva.dart';
import 'package:moon_aplication/services/services/usuario_actual.dart';

class HoteldetallesReservaScreen extends StatefulWidget {
  final String idHotel;
  final String idReserva;

  const HoteldetallesReservaScreen({
    super.key,
    required this.idHotel,
    required this.idReserva,
  });

  @override
  State<HoteldetallesReservaScreen> createState() => _HoteldetallesReservaScreenState();
}

class _HoteldetallesReservaScreenState extends State<HoteldetallesReservaScreen> {
  String? imagenSeleccionada;
  bool esFavorito = false;
  Future<Hotel>? _hotelFuture;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _hotelFuture = obtenerHotelPorId(widget.idHotel);
    _verificarSiEsFavorito();  // ✅ Verifica favorito al abrir la pantalla
  }

  /// ✅ Función para verificar si el hotel está marcado como favorito en Firebase
  Future<void> _verificarSiEsFavorito() async {
    final String idUsuario = UsuarioActual.uid;
    if (idUsuario.isEmpty) return;

    try {
      final querySnapshot = await _db.collection('usuariosLikes')
          .where('idUsuario', isEqualTo: idUsuario)
          .where('idHotel', isEqualTo: widget.idHotel)
          .get();

      setState(() {
        esFavorito = querySnapshot.docs.isNotEmpty;  // ✅ Si existe, es favorito
      });
    } catch (e) {
      debugPrint("Error verificando favorito: $e");
    }
  }

  /// ✅ Alterna el estado de favorito en `usuariosLikes`
  Future<void> _toggleFavorito() async {
    final String idUsuario = UsuarioActual.uid;
    if (idUsuario.isEmpty) return;

    try {
      final querySnapshot = await _db.collection('usuariosLikes')
          .where('idUsuario', isEqualTo: idUsuario)
          .where('idHotel', isEqualTo: widget.idHotel)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs) {
          await doc.reference.delete(); // ✅ Si es favorito, eliminarlo
        }
      } else {
        await _db.collection('usuariosLikes').add({
          'idUsuario': idUsuario,
          'idHotel': widget.idHotel,
        }); // ✅ Si no es favorito, agregarlo
      }

      setState(() {
        esFavorito = !esFavorito;
      });
    } catch (e) {
      debugPrint("Error al alternar favorito: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6F9FF),
      body: FutureBuilder<Hotel>(
        future: _hotelFuture,
        builder: (context, snapshotHotel) {
          if (snapshotHotel.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshotHotel.hasError) {
            return Center(child: Text('Error: ${snapshotHotel.error}'));
          }
          if (!snapshotHotel.hasData) {
            return const Center(child: Text('Hotel no encontrado'));
          }

          final hotel = snapshotHotel.data!;
          imagenSeleccionada ??= hotel.imagenPrincipal;

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
                        imagenSeleccionada!,
                        height: 280,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 40,
                    left: 20,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(6),
                        child: const Icon(Icons.arrow_back, size: 28, color: Colors.black),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 40,
                    right: 20,
                    child: GestureDetector(
                      onTap: _toggleFavorito,  // ✅ Ahora cambia el estado en Firebase
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(6),
                        child: Icon(
                          esFavorito ? Icons.favorite : Icons.favorite_border,
                          size: 28,
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: DetallesReserva(hotel: hotel, idReserva: widget.idReserva),
              ),
            ],
          );
        },
      ),
    );
  }
}