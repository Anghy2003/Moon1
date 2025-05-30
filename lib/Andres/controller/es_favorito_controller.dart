import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moon_aplication/services/services/usuario_actual.dart';

class FavoritoService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  
  Future<bool> verificarSiEsFavorito(String idHotel) async {
    final String idUsuario = UsuarioActual.uid;
    if (idUsuario.isEmpty) return false;

    try {
      final querySnapshot = await _db.collection('usuariosLikes')
          .where('idUsuario', isEqualTo: idUsuario)
          .where('idHotel', isEqualTo: idHotel)
          .get();

      return querySnapshot.docs.isNotEmpty;  
    } catch (e) {
      debugPrint("Error verificando favorito: $e");
      return false;
    }
  }

 
  Future<void> toggleFavorito(String idHotel, VoidCallback actualizarEstado) async {
    final String idUsuario = UsuarioActual.uid;
    if (idUsuario.isEmpty) return;

    try {
      final querySnapshot = await _db.collection('usuariosLikes')
          .where('idUsuario', isEqualTo: idUsuario)
          .where('idHotel', isEqualTo: idHotel)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs) {
          await doc.reference.delete();  
        }
      } else {
        await _db.collection('usuariosLikes').add({
          'idUsuario': idUsuario,
          'idHotel': idHotel,
        });
      }

      actualizarEstado(); 
    } catch (e) {
      debugPrint("Error al alternar favorito: $e");
    }
  }
}