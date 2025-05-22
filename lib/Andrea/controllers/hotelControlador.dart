import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moon_aplication/Andrea/models/hotel.dart';

Future<Hotel> obtenerHotelPorId(String idHotel) async {
  final doc = await FirebaseFirestore.instance.collection('hoteles').doc(idHotel).get();

  if (doc.exists) {
    return Hotel.fromMap(doc.data()!, doc.id);
  } else {
    throw Exception('Hotel no encontrado');
  }
}
