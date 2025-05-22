import 'package:flutter/material.dart';
import 'package:moon_aplication/shared/app_theme.dart';
import 'package:moon_aplication/Andres/data/listado_botones_perfil.dart';
import 'package:moon_aplication/Andres/widgets/menu_perfil/estilo_boton_perfil.dart';
import 'package:moon_aplication/Andres/widgets/menu_perfil/tarjeta_perfil.dart';

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
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(5.0 * scaleFactor),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TarjetaPerfil(scaleFactor: scaleFactor),
                SizedBox(height: 1 * scaleFactor),
                Flexible( // 🔥 Usa Flexible en lugar de Expanded
                  fit: FlexFit.loose, // 🔥 Permite ajustar el tamaño sin forzar expansión
                  child: _buildListaBotones(scaleFactor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildListaBotones(double scaleFactor) {
    return ListView.separated(
      shrinkWrap: true, // 🔥 Permite que la lista se ajuste sin expandirse infinitamente
      physics: NeverScrollableScrollPhysics(), // 🔥 Evita conflictos con SingleChildScrollView
      itemCount: listadoBotonesPerfil.length,
      separatorBuilder: (context, index) => SizedBox(height: 22 * scaleFactor),
      itemBuilder: (context, index) => EstiloBotonPerfil(boton: listadoBotonesPerfil[index]),
    );
  }
}