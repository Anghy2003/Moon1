import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moon_aplication/Andrea/models/hotel.dart';
import 'package:moon_aplication/Andres/screens/hotel_detalles_reserva_screen.dart';
import 'package:moon_aplication/Andres/widgets/menu_reservas/tarjeta_hotel_reservas.dart';
import 'package:moon_aplication/services/services/usuario_actual.dart';

class HotelSeleccionadoReservas extends StatefulWidget {
  final Hotel hotel;
  final String idReserva;
  final bool esFavorito;

  const HotelSeleccionadoReservas({
    super.key,
    required this.hotel,
    required this.idReserva,
    required this.esFavorito,
  });

  @override
  State<HotelSeleccionadoReservas> createState() => _HotelSeleccionadoReservasState();
}

class _HotelSeleccionadoReservasState extends State<HotelSeleccionadoReservas> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  late bool esFavorito;

  @override
  void initState() {
    super.initState();
    esFavorito = widget.esFavorito;
  }

  Future<void> _verificarFavorito() async {
    final String idUsuario = UsuarioActual.uid;
    if (idUsuario.isEmpty) return;

    try {
      final querySnapshot = await _db.collection('usuariosLikes')
          .where('idUsuario', isEqualTo: idUsuario)
          .where('idHotel', isEqualTo: widget.hotel.id)
          .get();

      setState(() {
        esFavorito = querySnapshot.docs.isNotEmpty;  
      });
    } catch (e) {
      debugPrint("Error verificando favorito: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return TarjetaHotelReservas(
      hotel: widget.hotel,
      onTap: () async { 
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HoteldetallesReservaScreen(
              idHotel: widget.hotel.id,
              idReserva: widget.idReserva,
            ),
          ),
        );

        _verificarFavorito(); 
      },
    );
  }
}