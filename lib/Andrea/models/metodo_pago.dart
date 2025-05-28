import 'package:moon_aplication/Andrea/models/hotel.dart';

class MetodoPago {
  final String tipoPago; 

  MetodoPago({required this.tipoPago});

  Map<String, dynamic> toMap() {
    return {
      'tipoPago': tipoPago,
    };
  }
}

Map<String, dynamic> hotelParaReserva(Hotel hotel) {
  return {
    'id': hotel.id,
    'nombre': hotel.nombre,
    'descripcion': hotel.descripcion,
    'precioNoche': hotel.precioNoche,
  };
}