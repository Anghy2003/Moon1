import 'package:flutter/material.dart';
import 'package:moon_aplication/Andrea/controllers/hotelControlador.dart';
import 'package:moon_aplication/Andrea/models/hotel.dart';
import 'package:moon_aplication/Andres/controller/es_favorito_controller.dart';
import 'package:moon_aplication/Andres/widgets/menu_detalles/detalles_reserva.dart';
import 'package:moon_aplication/Andres/widgets/gradiente_color_fondo.dart'; 

class HoteldetallesReservaScreen extends StatefulWidget {
  final String idHotel;
  final String idReserva;

  const HoteldetallesReservaScreen({
    super.key,
    required this.idHotel,
    required this.idReserva,
  });

  @override
  State<HoteldetallesReservaScreen> createState() => _HoteldetallesReservaScreenState();
}

class _HoteldetallesReservaScreenState extends State<HoteldetallesReservaScreen> {
  String? imagenSeleccionada;
  bool esFavorito = false;
  Future<Hotel>? _hotelFuture;
  final FavoritoService favoritoService = FavoritoService();

  @override
  void initState() {
    super.initState();
    _hotelFuture = obtenerHotelPorId(widget.idHotel);
    _verificarFavorito();
  }

  void _verificarFavorito() async {
    bool resultado = await favoritoService.verificarSiEsFavorito(widget.idHotel);
    setState(() {
      esFavorito = resultado;
    });
  }

  void _toggleFavorito() {
    favoritoService.toggleFavorito(widget.idHotel, () {
      setState(() {
        esFavorito = !esFavorito;
      });
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
          child: FutureBuilder<Hotel>(
            future: _hotelFuture,
            builder: (context, snapshotHotel) {
              if (snapshotHotel.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshotHotel.hasError) {
                return Center(child: Text('Error: ${snapshotHotel.error}'));
              }
              if (!snapshotHotel.hasData) {
                return const Center(child: Text('Hotel no encontrado'));
              }

              final hotel = snapshotHotel.data!;
              imagenSeleccionada ??= hotel.imagenPrincipal;

              return Column(
                children: [
                  const SizedBox(height: 30),
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.network(
                            imagenSeleccionada!,
                            height: 280,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 40,
                        left: 20,
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(6),
                            child: const Icon(Icons.arrow_back, size: 28, color: Colors.black),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 40,
                        right: 20,
                        child: GestureDetector(
                          onTap: _toggleFavorito,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(6),
                            child: Icon(
                              esFavorito ? Icons.favorite : Icons.favorite_border,
                              size: 28,
                              color: Colors.redAccent,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: DetallesReserva(hotel: hotel, idReserva: widget.idReserva),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}