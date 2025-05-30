import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moon_aplication/Andrea/models/hotel.dart';

///Obtiene los 5 hoteles con mejor rating
Future<List<Hotel>> obtenerTopHoteles() async {
  final QuerySnapshot<Map<String, dynamic>> snapshot =
      await FirebaseFirestore.instance.collection('hoteles').get();

  final List<Hotel> hoteles = snapshot.docs.map((doc) {
    return Hotel.fromMap(doc.data(), doc.id);
  }).toList();

  
  hoteles.removeWhere((hotel) => hotel.rating <= 0);

  
  hoteles.sort((a, b) => b.rating.compareTo(a.rating));

  
  return hoteles.take(5).toList();
}


Future<List<Hotel>> obtenerTodosLosHoteles() async {
  final querySnapshot = await FirebaseFirestore.instance.collection('hoteles').get();
  
  return querySnapshot.docs.map((doc) {
    return Hotel.fromMap(doc.data(), doc.id);
  }).toList();
}







