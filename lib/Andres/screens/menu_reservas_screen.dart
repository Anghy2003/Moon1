import 'package:flutter/material.dart';
import 'package:moon_aplication/Andres/widgets/gradiente_color_fondo.dart';
import 'package:moon_aplication/Andres/widgets/menu_reservas/buscar_hoteles_reserva.dart';
import 'package:moon_aplication/Andres/widgets/menu_reservas/lista_hoteles_reserva.dart';
import 'package:moon_aplication/Andres/controller/reservas_controller.dart';

class MenuReservasScreen extends StatefulWidget {
  const MenuReservasScreen({super.key});

  @override
  State<MenuReservasScreen> createState() => _MenuReservasScreenState();
}

class _MenuReservasScreenState extends State<MenuReservasScreen> {
  late Future<List<Map<String, dynamic>>> _futureReservas;
  String _searchQuery = "";
  final ReservasController _reservasController = ReservasController();

  @override
  void initState() {
    super.initState();
    _cargarReservas();  // ✅ Se carga inicialmente
  }

  /// ✅ Cargar reservas cada vez que la pantalla aparece
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _cargarReservas();  // 🔥 Se ejecuta cuando la pantalla cambia
  }

  Future<void> _cargarReservas() async {
    setState(() {
      _futureReservas = _reservasController.obtenerReservasConHoteles();
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
                    " Mis Reservas",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                ),
                const SizedBox(height: 7),
                BuscarHotelesReserva(
                  onChanged: (query) {
                    setState(() {
                      _searchQuery = query;
                    });
                  },
                ),
                const SizedBox(height: 4),
                Expanded(
                  child: RefreshIndicator(  
                    onRefresh: _cargarReservas,
                    child: ListaHotelesReserva(
                      futureReservas: _futureReservas,  
                      searchQuery: _searchQuery,
                      onRefresh: _cargarReservas,
                    ),
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