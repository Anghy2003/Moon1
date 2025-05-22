class Hotel {
  final String nombre;
  final String descripcion;
  final double precio;
  final String imagenPrincipal;
  final List<String> imagenes;
  final List<Facilidad> facilidades;

  Hotel({
    required this.nombre,
    required this.descripcion,
    required this.precio,
    required this.imagenPrincipal,
    required this.imagenes,
    required this.facilidades,
  });

  factory Hotel.fromMap(Map<String, dynamic> data, String id) {
    return Hotel(
      nombre: data['nombre'] ?? '',
      descripcion: data['descripcion'] ?? '',
      precio: (data['precio'] ?? 0).toDouble(),
      imagenPrincipal: data['imagen_principal'] ?? '',
      imagenes: List<String>.from(data['imagenes'] ?? []),
      facilidades: (data['facilidades'] as List<dynamic>? ?? [])
          .map((f) => Facilidad.fromMap(f))
          .toList(),
    );
  }
}

class Facilidad {
  final String icon;
  final String label;

  Facilidad({required this.icon, required this.label});

  factory Facilidad.fromMap(Map<String, dynamic> data) {
    return Facilidad(
      icon: data['icon'] ?? '',
      label: data['label'] ?? '',
    );
  }
}
