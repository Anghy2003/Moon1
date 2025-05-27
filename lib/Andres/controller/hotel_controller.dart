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


// Future<void> guardarHotelesdeListaEnFirestore() async {
//   final CollectionReference hotelesRef =
//       FirebaseFirestore.instance.collection('hoteles');

//   for (var hotel in listadoHoteles) {
    
//     final String nombre =
//         hotel['nombre']?.toString() ?? 'Sin nombre';
//     final String ubicacion =
//         hotel['ubicacion']?.toString() ?? 'Ubicación desconocida';
//     final double rating = hotel['rating'] is num
//         ? (hotel['rating'] as num).toDouble()
//         : 0.0;
    
    
//     final String precioTexto =
//         hotel['precioNoche']?.toString() ?? '0';
//     final double precio = double.tryParse(
//             precioTexto.replaceAll(RegExp(r'[^0-9.]'), '')
//           ) ??
//           0.0;

//     final String imagenPrincipal =
//         hotel['imagen_principal']?.toString() ?? '';
//     final String descripcion =
//         hotel['descripcion']?.toString() ?? ''; 
//     final List<String> imagenes = hotel['imagenes'] != null
//         ? List<String>.from(hotel['imagenes'])
//         : [];
//     final List<Map<String, dynamic>> facilidades =
//         hotel['facilidades'] != null
//             ? List<Map<String, dynamic>>.from(hotel['facilidades'])
//             : [];

//     // Guarda en Firestore con la estructura 
//     await hotelesRef.add({
//       'nombre': nombre,
//       'ubicacion': ubicacion,
//       'rating': rating,
//       'precio': precio, 
//       'imagen_principal': imagenPrincipal,
//       'descripcion': descripcion,
//       'imagenes': imagenes,
//       'facilidades': facilidades,
//     });
//   }
// }





