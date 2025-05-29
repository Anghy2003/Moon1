import 'package:flutter/material.dart';
import 'package:moon_aplication/Andres/screens/menu_reservas_screen.dart';
import 'package:moon_aplication/Andres/widgets/menu_perfil/dialogo_cerrar_sesion.dart';

final List<Map<String, dynamic>> listadoBotonesPerfil = [
  // {
  //   'text': 'Informacion Personal',
  //   'icon': Icons.account_circle,
  //   'onPressed': (BuildContext context) {
  //     context.go('/home'); 
  //   },
  // },
  {
    'text': 'Mis Reservas',
    'icon': Icons.calendar_month,
    'onPressed': (BuildContext context) {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>MenuReservasScreen()));
    },
  },
  
  
  {
    'text': 'Cerrar Sesión',
    'icon': Icons.logout,
    'onPressed': (BuildContext context) {
      dialogoCerrarSesion(context); 
    },
  },







];