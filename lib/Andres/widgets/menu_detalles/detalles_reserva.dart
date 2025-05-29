import 'package:flutter/material.dart';
import 'package:moon_aplication/Andrea/models/hotel.dart';
import 'package:moon_aplication/Andrea/models/reservas.dart';
import 'package:moon_aplication/Andres/controller/reservas_controller.dart';
import 'package:moon_aplication/Andres/widgets/menu_detalles/mostrar_detalles_reservados.dart'; // ✅ Importa el widget

class DetallesReserva extends StatefulWidget {
  final String idReserva;
  final Hotel hotel;

  const DetallesReserva({
    super.key,
    required this.idReserva,
    required this.hotel,
  });

  @override
  // ignore: library_private_types_in_public_api
  _DetallesReservaState createState() => _DetallesReservaState();
}

class _DetallesReservaState extends State<DetallesReserva> {
  Future<Reserva>? _reservaFuture;
  final ReservasController _reservasController = ReservasController();

  @override
  void initState() {
    super.initState();
    _reservaFuture = _reservasController.obtenerReservaPorId(widget.idReserva);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: FutureBuilder<Reserva>(
        future: _reservaFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error obteniendo reserva: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No se encontraron detalles para esta reserva'));
          }

          final reserva = snapshot.data!;

          return ListView(
            children: [
              Text(
                widget.hotel.nombre,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 20),
                  const SizedBox(width: 4),
                  Text("${widget.hotel.rating.toStringAsFixed(1)} (355 Reviews)", style: const TextStyle(fontSize: 14)),
                ],
              ),
              const SizedBox(height: 10),
              Text(widget.hotel.descripcion, style: const TextStyle(fontSize: 15)),
              const SizedBox(height: 24),
              const Text("Facilidades", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: widget.hotel.facilidades.map((f) {
                    final icon = _getIconFromString(f.icon);
                    return Container(
                      width: 80,
                      margin: const EdgeInsets.only(right: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        // ignore: deprecated_member_use
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Icon(icon, color: Colors.grey[500]),
                          const SizedBox(height: 8),
                          Text(f.label, style: TextStyle(fontSize: 13, color: Colors.grey[600]), textAlign: TextAlign.center),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
                child: MostrarDetallesReservados(reserva: reserva),  
              ),
              const Text("Total", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text("\$${widget.hotel.precio.toStringAsFixed(2)}",
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green)),
              const SizedBox(height: 20),
            ],
          );
        },
      ),
    );
  }
}

IconData _getIconFromString(String iconName) {
  switch (iconName) {
    case 'wifi': return Icons.wifi;
    case 'pool': return Icons.pool;
    case 'restaurant': return Icons.restaurant;
    case 'bathtub': return Icons.bathtub;
    case 'heater': return Icons.fireplace;
    default: return Icons.help_outline;
  }
}