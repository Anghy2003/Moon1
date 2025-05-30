import 'package:flutter/material.dart';
import 'package:moon_aplication/Andres/widgets/gradiente_color_fondo.dart';
import 'package:moon_aplication/Diego/widgets/crazy_logo.dart';
import 'package:moon_aplication/shared/app_theme.dart';
import 'package:moon_aplication/Andres/data/listado_botones_perfil.dart';
import 'package:moon_aplication/Andres/widgets/menu_perfil/estilo_boton_perfil.dart';
import 'package:moon_aplication/Andres/widgets/menu_perfil/tarjeta_perfil.dart'; // Importar la nueva clase

class MenuPerfil extends StatefulWidget {
  const MenuPerfil({super.key});

  @override
  State<MenuPerfil> createState() => _MenuPerfilState();
}

class _MenuPerfilState extends State<MenuPerfil> {
  @override
  Widget build(BuildContext context) {
    final double scaleFactor = AppTheme.scaleFactor(context);

    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: Container(
        width: double.infinity, 
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: GradienteColorFondo.backgroundGradient,//FONDO
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(5.0 * scaleFactor),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TarjetaPerfil(scaleFactor: scaleFactor),
                        SizedBox(height: 1 * scaleFactor),
                        Flexible(
                          fit: FlexFit.loose,
                          child: _buildListaBotones(scaleFactor),
                        ),
                        SizedBox(height:115),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: const CrazyLogo()
                          ),
                        ),                        
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListaBotones(double scaleFactor) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: listadoBotonesPerfil.length,
      separatorBuilder: (context, index) => SizedBox(height: 22 * scaleFactor),
      itemBuilder: (context, index) => EstiloBotonPerfil(boton: listadoBotonesPerfil[index]),
    );
  }
}