import 'package:flutter/material.dart';
import 'package:moon_aplication/Andrea/models/hotel.dart';
import 'package:moon_aplication/Andres/controller/hotel_controller.dart';
import 'package:moon_aplication/Andres/widgets/gradiente_color_fondo.dart';
import 'package:moon_aplication/Andres/widgets/menu_likes/buscar_hoteles_like.dart';
import 'package:moon_aplication/Andres/widgets/menu_likes/lista_hoteles_like.dart';  // Importa la nueva clase

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
    _cargarHoteles();
  }

  Future<void> _cargarHoteles() async {
    setState(() {
      _futureHoteles = obtenerTodosLosHoteles();
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
                    " Favoritos", //todo: VERIFICAR SI QUIEREN UN TITULO
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
                    onRefresh: _cargarHoteles,
                    //todo: REEMPLAZAR POR HOTELES LIKEADOS
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