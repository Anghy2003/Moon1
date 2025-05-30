import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moon_aplication/Andrea/models/hotel.dart';
import 'package:moon_aplication/Andrea/models/reservas.dart';
import 'package:moon_aplication/Andrea/models/reservas_detalles.dart';
import 'package:moon_aplication/Andrea/models/metodo_pago.dart';
import 'package:moon_aplication/services/services/usuario_actual.dart';

class ReservasController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Hotel>> obtenerHotelesReservados() async {
    final String idUsuario = UsuarioActual.uid;
    if (idUsuario.isEmpty) {
      return [];
    }
    try {
      final querySnapshot = await _db.collection('reservas')
          .where('usuarioId', isEqualTo: idUsuario)
          .get();
      List<Hotel> hotelesReservados = [];
      for (var doc in querySnapshot.docs) {
        final hotelInfo = doc.data()['hotel'] as Map<String, dynamic>?;
        if (hotelInfo != null) {
          final String hotelId = hotelInfo['id'];
          final hotelRef = await _db.collection('hoteles').doc(hotelId).get();
          if (hotelRef.exists) {
            final hotelData = hotelRef.data();
            hotelInfo['imagen_principal'] = hotelData?['imagen_principal'];
            hotelInfo['rating'] = hotelData?['rating'];
          }
          hotelesReservados.add(Hotel.fromMap(hotelInfo, hotelId));
        }
      }
      return hotelesReservados;
    } catch (e) {
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> obtenerReservasConHoteles() async {
    final String idUsuario = UsuarioActual.uid;
    if (idUsuario.isEmpty) {
      return [];
    }
    try {
      final querySnapshot = await _db.collection('reservas')
          .where('usuarioId', isEqualTo: idUsuario)
          .get();

      List<Map<String, dynamic>> reservasConHoteles = [];

      for (var doc in querySnapshot.docs) {
        final hotelInfo = doc.data()['hotel'] as Map<String, dynamic>?;
        if (hotelInfo != null) {
          final String hotelId = hotelInfo['id'];
          final hotelRef = await _db.collection('hoteles').doc(hotelId).get();
          if (hotelRef.exists) {
            final hotelData = hotelRef.data();
            hotelInfo['imagen_principal'] = hotelData?['imagen_principal'];
            hotelInfo['rating'] = hotelData?['rating'];
          }
          reservasConHoteles.add({
            'hotel': Hotel.fromMap(hotelInfo, hotelId),
            'idReserva': doc.id,
          });
        }
      }
      return reservasConHoteles;
    } catch (e) {
      return [];
    }
  }

  Future<Reserva> obtenerReservaPorId(String idReserva) async {
  try {
    final reservaRef = await _db.collection('reservas').doc(idReserva).get();
    if (!reservaRef.exists) {
      return _reservaVacia();
    }

    final reservaData = reservaRef.data()!;

    
    final String metodoPagoTipo = reservaData['metodoPago']?.toString() ?? "";


    final String miembrosTexto = reservaData['miembros']?.toString() ?? "0 miembros";
    final int numMiembros = int.tryParse(miembrosTexto.split(" ")[0]) ?? 0;

    final detallesUsuario = ReservaDetalles(
      personaResponsable: reservaData['personaResponsable']?.toString() ?? "",
      numeroContacto: reservaData['numeroContacto']?.toString() ?? "",
      numMiembros: numMiembros, 
      tipoIdentificacion: reservaData['tipoId']?.toString() ?? "",
      numeroId: reservaData['numeroId']?.toString() ?? "",
    );

    return Reserva(
      hotelInfo: reservaData['hotel'],
      fechaInicio: DateTime.parse(reservaData['fechaCheckIn']),
      fechaFin: DateTime.parse(reservaData['fechaCheckOut']),
      detallesUsuario: detallesUsuario,
      metodoPago: MetodoPago(tipoPago: metodoPagoTipo),
      total: reservaData['total']?.toDouble() ?? 0.0,
    );
  } catch (e) {
    return _reservaVacia();
  }
}


  Reserva _reservaVacia() {
    return Reserva(
      hotelInfo: {},
      fechaInicio: DateTime.now(),
      fechaFin: DateTime.now(),
      detallesUsuario: ReservaDetalles(
        personaResponsable: "Desconocido",
        numeroContacto: "",
        numMiembros: 0,
        tipoIdentificacion: "",
        numeroId: "",
      ),
      metodoPago: MetodoPago(tipoPago: ""),
      total: 0.0,
    );
  }
}