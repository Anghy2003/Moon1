import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moon_aplication/Andrea/models/hotel.dart';
import 'package:moon_aplication/Andres/data/lista_hoteles.dart';


Future<List<Hotel>> obtenerTodosLosHoteles() async {
  final querySnapshot = await FirebaseFirestore.instance.collection('hoteles').get();
  
  return querySnapshot.docs.map((doc) {
    return Hotel.fromMap(doc.data(), doc.id);
  }).toList();
}

Future<void> guardarHotelesdeListaEnFirestore() async {
  final CollectionReference hotelesRef =
      FirebaseFirestore.instance.collection('hoteles');

  for (var hotel in listadoHoteles) {
    // Extrae y asigna valores con verificación de nulos.
    final String nombre =
        hotel['nombre']?.toString() ?? 'Sin nombre';
    final String ubicacion =
        hotel['ubicacion']?.toString() ?? 'Ubicación desconocida';
    final double rating = hotel['rating'] is num
        ? (hotel['rating'] as num).toDouble()
        : 0.0;
    
    // Aquí usamos la clave 'precioNoche'
    final String precioTexto =
        hotel['precioNoche']?.toString() ?? '0';
    // Elimina símbolos como "$" o "/noche" y trata de parsear el valor numérico.
    final double precio = double.tryParse(
            precioTexto.replaceAll(RegExp(r'[^0-9.]'), '')
          ) ??
          0.0;

    final String imagenPrincipal =
        hotel['imagen_principal']?.toString() ?? '';
    // Si deseas asignar datos para la descripción, imágenes o facilidades pero no existen en tu lista, se asignan valores por defecto.
    final String descripcion =
        hotel['descripcion']?.toString() ?? ''; // aquí usas un valor por defecto si lo requieres
    final List<String> imagenes = hotel['imagenes'] != null
        ? List<String>.from(hotel['imagenes'])
        : [];
    final List<Map<String, dynamic>> facilidades =
        hotel['facilidades'] != null
            ? List<Map<String, dynamic>>.from(hotel['facilidades'])
            : [];

    // Guarda en Firestore con la estructura deseada:
    await hotelesRef.add({
      'nombre': nombre,
      'ubicacion': ubicacion,
      'rating': rating,
      'precio': precio, // Guardamos el precio convertido a número
      'imagen_principal': imagenPrincipal,
      'descripcion': descripcion,
      'imagenes': imagenes,
      'facilidades': facilidades,
    });
  }
}
