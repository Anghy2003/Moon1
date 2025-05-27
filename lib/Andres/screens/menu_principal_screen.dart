import 'package:flutter/material.dart';
import 'package:moon_aplication/Andres/widgets/gradiente_color_fondo.dart';
import 'package:moon_aplication/Andres/widgets/menu_hoteles/buscar_hoteles.dart';
import 'package:moon_aplication/Andres/widgets/menu_principal/lista_hoteles_home.dart';
import 'package:moon_aplication/Andres/widgets/menu_principal/scroll_horizontal.dart'; // Importar la clase de gradiente

class MenuPrincipalScreen extends StatefulWidget {
  const MenuPrincipalScreen({super.key});

  @override
  State<MenuPrincipalScreen> createState() => _MenuPrincipalScreenState();
}

class _MenuPrincipalScreenState extends State<MenuPrincipalScreen> {
  String _searchQuery = "";

  Future<void> _recargarHoteles() async {
    setState(() {});
    await Future.delayed(const Duration(seconds: 2)); 
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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "¿Cuál será tu destino?",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  const SizedBox(height: 7),
                  BuscarHoteles(
                    onChanged: (query) {
                      setState(() {
                        _searchQuery = query;
                      });
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _recargarHoteles,
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            SizedBox(height: 7),
                            Text(
                              "Popular",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 21),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: const ScrollHorizontal(),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            SizedBox(height: 7),
                            Text(
                              "Ofertas",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return ListaHotelesHome(searchQuery: _searchQuery);
                        },
                        childCount: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}