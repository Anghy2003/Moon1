import 'package:moon_aplication/Andrea/models/metodo_pago.dart';

import 'package:moon_aplication/Andrea/models/reservas_detalles.dart';

class Reserva {
  final Map<String, dynamic> hotelInfo;
  final DateTime fechaInicio;
  final DateTime fechaFin;
  final ReservaDetalles detallesUsuario;
  final MetodoPago metodoPago;
  final double total;

  Reserva({
    required this.hotelInfo,
    required this.fechaInicio,
    required this.fechaFin,
    required this.detallesUsuario,
    required this.metodoPago,
    required this.total,
  });

  Map<String, dynamic> toMap() {
    return {
      'hotel': hotelInfo,
      'fechaInicio': fechaInicio.toIso8601String(),
      'fechaFin': fechaFin.toIso8601String(),
      'detallesUsuario': detallesUsuario.toMap(),
      'metodoPago': metodoPago.toMap(),
      'total': total,
    };
  }
}