import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moon_aplication/services/services/usuario_actual.dart';

class HotelesMeGustaInteractivo extends StatefulWidget {
  final String hotelId;

  const HotelesMeGustaInteractivo({super.key, required this.hotelId});

  @override
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
    if (idUsuario.isEmpty) return;

    final querySnapshot = await _db.collection('usuariosLikes')
        .where('idUsuario', isEqualTo: idUsuario)
        .where('idHotel', isEqualTo: widget.hotelId)
        .get();

    if (mounted) {
      setState(() {
        _esFavorito = querySnapshot.docs.isNotEmpty;
      });
    }
  }

  Future<void> _toggleFavorito() async {
    final String idUsuario = UsuarioActual.uid;
    if (idUsuario.isEmpty) return;

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

    if (mounted) {
      setState(() {
        _esFavorito = !_esFavorito;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleFavorito,
      child: Icon(
        _esFavorito ? Icons.favorite : Icons.favorite_border, // Ícono bordeado cuando no es favorito
        color: _esFavorito ? Colors.red : Colors.red, // Ambos tienen el mismo color rojo
        size: 24,
      ),
    );
  }
}