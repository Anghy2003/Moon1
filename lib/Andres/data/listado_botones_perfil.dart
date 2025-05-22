import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moon_aplication/Andres/widgets/menu_perfil/dialogo_cerrar_sesion.dart';

final List<Map<String, dynamic>> listadoBotonesPerfil = [
  {
    'text': 'Informacion Personal',
    'icon': Icons.account_circle,
    'onPressed': (BuildContext context) {
      context.go('/home'); 
    },
  },
  {
    'text': 'Mis Reservas',
    'icon': Icons.calendar_month,
    'onPressed': (BuildContext context) {
      context.go('/reservar'); 
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