class Usuarioslike {
  final String id;
  final String idUsuario;
  final String idHotel;

  Usuarioslike({
    required this.id,
    required this.idUsuario,
    required this.idHotel,
  });

  /// Convierte un documento de Firestore a un objeto Usuarioslike
  factory Usuarioslike.fromMap(Map<String, dynamic> data, String id) {
    return Usuarioslike(
      id: id,
      idUsuario: data['idUsuario'] ?? '',
      idHotel: data['idHotel'] ?? '',
    );
  }

  /// Convierte el objeto Usuarioslike a un Map para guardarlo en Firestore
  Map<String, dynamic> toMap() {
    return {
      'idUsuario': idUsuario,
      'idHotel': idHotel,
    };
  }
}