import 'package:flutter/material.dart';
import 'package:moon_aplication/Andrea/models/hotel.dart';
import 'package:moon_aplication/Andres/controller/hotel_controller.dart';
import 'package:moon_aplication/Andres/widgets/menu_hoteles/hotel_seleccionado.dart';

class MenuPrincipalScreen extends StatefulWidget {
  const MenuPrincipalScreen({super.key});

  @override
  State<MenuPrincipalScreen> createState() => _MenuHotelesState();
}

class _MenuHotelesState extends State<MenuPrincipalScreen> {
  late Future<List<Hotel>> _futureHoteles;
  final String _searchQuery =
      ""; // Variable para almacenar el query de búsqueda

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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              // Se actualiza el widget para que acepte el callback onChanged.
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Hoteles Populares",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),                  
                ),
              ),

              const SizedBox(height: 300),
              Expanded(child: _buildListaHoteles()),
            ],
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
            return Center(
              child: Text('Error al obtener los hoteles: ${snapshot.error}'),
            );
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay hoteles disponibles'));
          }

          final List<Hotel> hoteles = snapshot.data!;
          final String query = _searchQuery.toLowerCase();

          // Filtramos por nombre o ubicación
          final List<Hotel> filteredHoteles =
              hoteles.where((hotel) {
                final bool matchesNombre = hotel.nombre.toLowerCase().contains(
                  query,
                );
                final bool matchesUbicacion = hotel.ubicacion
                    .toLowerCase()
                    .contains(query);
                return matchesNombre || matchesUbicacion;
              }).toList();

          if (_searchQuery.isNotEmpty && filteredHoteles.isEmpty) {
            return const Center(child: Text('No se encontraron hoteles'));
          }

          return ListView.separated(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: filteredHoteles.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder:
                (context, index) =>
                    HotelSeleccionado(hotel: filteredHoteles[index]),
          );
        },
      ),
    );
  }
}
