import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moon_aplication/services/services/usuario_actual.dart';

class HotelesMeGustaInteractivo extends StatefulWidget {
  final String hotelId;

  const HotelesMeGustaInteractivo({super.key, required this.hotelId});

  @override
  // ignore: library_private_types_in_public_api
  _HotelesMeGustaInteractivoState createState() => _HotelesMeGustaInteractivoState();
}

class _HotelesMeGustaInteractivoState extends State<HotelesMeGustaInteractivo> {
  bool _esFavorito = false;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _verificarSiEsFavorito();
  }

  Future<void> _verificarSiEsFavorito() async {
    final String idUsuario = UsuarioActual.uid; 

    if (idUsuario.isEmpty) {
      return; 
    }

    final querySnapshot = await _db.collection('usuariosLikes')
        .where('idUsuario', isEqualTo: idUsuario)
        .where('idHotel', isEqualTo: widget.hotelId)
        .get();

    setState(() {
      _esFavorito = querySnapshot.docs.isNotEmpty;
    });
  }

  Future<void> _toggleFavorito() async {
    final String idUsuario = UsuarioActual.uid; 

    if (idUsuario.isEmpty) {
      return; 
    }

    if (_esFavorito) {
      final querySnapshot = await _db.collection('usuariosLikes')
          .where('idUsuario', isEqualTo: idUsuario)
          .where('idHotel', isEqualTo: widget.hotelId)
          .get();

      for (var doc in querySnapshot.docs) {
        await doc.reference.delete();
      }
    } else {
      await _db.collection('usuariosLikes').add({
        'idUsuario': idUsuario,
        'idHotel': widget.hotelId,
      });
    }

    setState(() {
      _esFavorito = !_esFavorito;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleFavorito,
      child: Icon(
        Icons.favorite,
        color: _esFavorito ? Colors.red : Colors.grey,
        size: 24,
      ),
    );
  }
}