class ReservaDetalles {
  final String personaResponsable;
  final String numeroContacto;
  final int numMiembros;
  final String tipoIdentificacion;
  final String numeroId;

  ReservaDetalles({
    required this.personaResponsable,
    required this.numeroContacto,
    required this.numMiembros,
    required this.tipoIdentificacion,
    required this.numeroId,
  });

  Map<String, dynamic> toMap() {
    return {
      'personaResponsable': personaResponsable,
      'numeroContacto': numeroContacto,
      'numMiembros': numMiembros,
      'tipoIdentificacion': tipoIdentificacion,
      'numeroId': numeroId,
    };
  }
}
