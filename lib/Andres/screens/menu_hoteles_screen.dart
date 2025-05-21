import 'package:flutter/material.dart';
import 'package:moon_aplication/Andres/data/lista_hoteles.dart';
import 'package:moon_aplication/Andres/widgets/buscar_hoteles.dart';
import 'package:moon_aplication/Andres/widgets/hotel_seleccionado.dart';

class MenuHoteles extends StatefulWidget {
  const MenuHoteles({super.key});

  @override
  State<MenuHoteles> createState() => _MenuHotelesState();
}

class _MenuHotelesState extends State<MenuHoteles> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0), // 🔥 Eliminamos el AppBar dinámico
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              const BuscarHoteles(),
              const SizedBox(height: 16),
              Expanded(child: _buildListaHoteles()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListaHoteles() {
    return ListView.separated(
      itemCount: listadoHoteles.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) => HotelSeleccionado(hotel: listadoHoteles[index]),
    );
  }
}