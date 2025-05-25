
import 'package:go_router/go_router.dart';
import 'package:moon_aplication/home/botones/boton_home.dart';
import 'package:moon_aplication/home/botones/boton_likes.dart';
import 'package:moon_aplication/home/botones/boton_perfil.dart';
import 'package:moon_aplication/home/botones/boton_reservar.dart';
import 'package:moon_aplication/home/menu_navegacion.dart';

//Aqui pondremos todas las rutas que tendra el programita Ü
final GoRouter router = GoRouter(
  initialLocation: '/home',
  routes: [
    ShellRoute(
      // El ShellRoute envuelve las rutas hijas con MenuNavegacion,
      // de modo que el scaffold y la barra se mantienen fijos.
      builder: (context, state, child) {
        return MenuNavegacion(child: child);
      },
      routes: [

        GoRoute(
          path: '/home',
          builder: (context, state) => const BotonHome(),
        ),

        GoRoute(
          path: '/reservar',
          builder: (context, state) => const BotonReservar(),
        ),

        GoRoute(
          path: '/likes',
          builder: (context, state) => const BotonLikes(),
        ),

        GoRoute(
          path: '/perfil',
          builder: (context, state) => const BotonPerfil(),
        ),

        

      ],
    ),
  ],
);