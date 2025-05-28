import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moon_aplication/Andres/widgets/menu_principal/icono_me_gusta_horizontal.dart';
import 'package:moon_aplication/services/services/usuario_actual.dart';

class IconoMeGustaInteractivo extends StatefulWidget {
  final String hotelId;

  const IconoMeGustaInteractivo({super.key, required this.hotelId});

  @override
  // ignore: library_private_types_in_public_api
  _IconoMeGustaInteractivoState createState() => _IconoMeGustaInteractivoState();
}

class _IconoMeGustaInteractivoState extends State<IconoMeGustaInteractivo> {
  bool _esFavorito = false;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _verificarSiEsFavorito();
  }

  
  Future<void> _verificarSiEsFavorito() async {
    if (UsuarioActual.uid.isEmpty) {
      return; 
    }

    final querySnapshot = await _db.collection('usuariosLikes')
        .where('idUsuario', isEqualTo: UsuarioActual.uid) 
        .where('idHotel', isEqualTo: widget.hotelId)
        .get();

    setState(() {
      _esFavorito = querySnapshot.docs.isNotEmpty;
    });
  }

  
  Future<void> _toggleFavorito() async {
    if (UsuarioActual.uid.isEmpty) {
      return; 
    }

    if (_esFavorito) {
      final querySnapshot = await _db.collection('usuariosLikes')
          .where('idUsuario', isEqualTo: UsuarioActual.uid)
          .where('idHotel', isEqualTo: widget.hotelId)
          .get();

      for (var doc in querySnapshot.docs) {
        await doc.reference.delete();
      }
    } else {
      await _db.collection('usuariosLikes').add({
        'idUsuario': UsuarioActual.uid,
        'idHotel': widget.hotelId,
      });
    }

    setState(() {
      _esFavorito = !_esFavorito;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 30, minHeight: 30),
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(200),
        borderRadius: BorderRadius.circular(8),
      ),
      child: GestureDetector(
        onTap: _toggleFavorito,
        child: IconoMeGustaHorizontal(
          color: _esFavorito ? Colors.red : Colors.grey, 
        ),
      ),
    );
  }
}