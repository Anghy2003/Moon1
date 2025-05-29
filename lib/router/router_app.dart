import 'package:go_router/go_router.dart';
import 'package:moon_aplication/Diego/screens/screen_before_login.dart';
import 'package:moon_aplication/Diego/screens/pantalla_login.dart';
import 'package:moon_aplication/home/botones/boton_home.dart';
import 'package:moon_aplication/home/botones/boton_likes.dart';
import 'package:moon_aplication/home/botones/boton_perfil.dart';
import 'package:moon_aplication/home/botones/boton_reservar.dart';
import 'package:moon_aplication/home/menu_navegacion.dart';

/// Configuración de rutas del programa
final GoRouter router = GoRouter(
  initialLocation: '/first', // Pantalla inicial
  routes: [

    // Ruta para la pantalla de bienvenida antes del login
    GoRoute(
      path: '/first',
      builder: (context, state) => const ScreenBeforeLogin(),
    ),

    // Ruta para la pantalla de login
    GoRoute(
      path: '/login',
      builder: (context, state) => const PantallaLogin(),
    ),

    // Rutas principales con menú de navegación
    ShellRoute(
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
