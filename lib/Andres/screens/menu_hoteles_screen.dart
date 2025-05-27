import 'package:flutter/material.dart';
import 'package:moon_aplication/Andrea/models/hotel.dart';
import 'package:moon_aplication/Andres/controller/hotel_controller.dart';
import 'package:moon_aplication/Andres/widgets/gradiente_color_fondo.dart';
import 'package:moon_aplication/Andres/widgets/menu_hoteles/buscar_hoteles.dart';
import 'package:moon_aplication/Andres/widgets/menu_hoteles/hotel_seleccionado.dart';// Importar la clase de gradiente

class MenuHoteles extends StatefulWidget {
  const MenuHoteles({super.key});

  @override
  State<MenuHoteles> createState() => _MenuHotelesState();
}

class _MenuHotelesState extends State<MenuHoteles> {
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
          gradient: GradienteColorFondo.backgroundGradient, // Llamada al gradiente
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Ofertas",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                ),
                const SizedBox(height: 7),
                BuscarHoteles(
                  onChanged: (query) {
                    setState(() {
                      _searchQuery = query;
                    });
                  },
                ),
                const SizedBox(height: 4),
                Expanded(child: _buildListaHoteles()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildListaHoteles() {
    return RefreshIndicator(
      onRefresh: _cargarHoteles,
      child: FutureBuilder<List<Hotel>>(
        future: _futureHoteles,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error al obtener los hoteles: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay hoteles disponibles'));
          }

          final List<Hotel> hoteles = snapshot.data!;
          final String query = _searchQuery.toLowerCase();

          // Filtramos por nombre o ubicación
          final List<Hotel> filteredHoteles = hoteles.where((hotel) {
            final bool matchesNombre = hotel.nombre.toLowerCase().contains(query);
            final bool matchesUbicacion = hotel.ubicacion.toLowerCase().contains(query);
            return matchesNombre || matchesUbicacion;
          }).toList();

          if (_searchQuery.isNotEmpty && filteredHoteles.isEmpty) {
            return const Center(child: Text('No se encontraron hoteles'));
          }

          return ListView.separated(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: filteredHoteles.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) => HotelSeleccionado(hotel: filteredHoteles[index]),
          );
        },
      ),
    );
  }
}