import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moon_aplication/Andrea/models/hotel.dart';
import 'package:moon_aplication/Andres/widgets/gradiente_color_fondo.dart';
import 'package:moon_aplication/Andres/widgets/menu_likes/buscar_hoteles_like.dart';
import 'package:moon_aplication/Andres/widgets/menu_likes/lista_hoteles_like.dart';
import 'package:moon_aplication/services/services/usuario_actual.dart';

class MenuLikes extends StatefulWidget {
  const MenuLikes({super.key});

  @override
  State<MenuLikes> createState() => _MenuLikesState();
}

class _MenuLikesState extends State<MenuLikes> {
  late Future<List<Hotel>> _futureHoteles;
  String _searchQuery = "";

  @override
  void initState() {
    super.initState();
    _futureHoteles = obtenerHotelesLike(); 
  }

  
  Future<List<Hotel>> obtenerHotelesLike() async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    final String idUsuario = UsuarioActual.uid;

    if (idUsuario.isEmpty) {
      return [];
    }

    final querySnapshot = await db.collection('usuariosLikes')
        .where('idUsuario', isEqualTo: idUsuario)
        .get();

    List<Hotel> hotelesLiked = [];

    for (var doc in querySnapshot.docs) {
      final hotelRef = await db.collection('hoteles').doc(doc['idHotel']).get();
      if (hotelRef.exists) {
        hotelesLiked.add(Hotel.fromMap(hotelRef.data()!, hotelRef.id));
      }
    }

    return hotelesLiked;
  }

  Future<void> _cargarHotelesLikeados() async {
    setState(() {
      _futureHoteles = obtenerHotelesLike();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: Container(
        width: double.infinity, 
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: GradienteColorFondo.backgroundGradient,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    " Favoritos", 
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                ),
                const SizedBox(height: 7),
                BuscarHotelesLiked(
                  onChanged: (query) {
                    setState(() {
                      _searchQuery = query;
                    });
                  },
                ),
                const SizedBox(height: 4),
                Expanded(
                  child: ListaHotelesLike(
                    futureHoteles: _futureHoteles, 
                    searchQuery: _searchQuery,
                    onRefresh: _cargarHotelesLikeados,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}