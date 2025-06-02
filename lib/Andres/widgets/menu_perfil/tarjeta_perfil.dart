import 'package:flutter/material.dart';
import 'package:moon_aplication/Andres/widgets/menu_perfil/foto_perfil_circular.dart';
import 'package:moon_aplication/services/services/usuario_actual.dart';

class TarjetaPerfil extends StatefulWidget {
  final double scaleFactor;

  const TarjetaPerfil({super.key, required this.scaleFactor});

  @override
  _TarjetaPerfilState createState() => _TarjetaPerfilState();
}

class _TarjetaPerfilState extends State<TarjetaPerfil> {
  String ubicacion = UsuarioActual.ubicacion;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8 * widget.scaleFactor),
      child: Container(
        height: 132 * widget.scaleFactor,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20 * widget.scaleFactor),
        ),
        child: Builder(
          builder: (context) {
            final theme = Theme.of(context);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20 * widget.scaleFactor),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    20 * widget.scaleFactor,
                    0,
                    3 * widget.scaleFactor,
                    0,
                  ),
                  child: Text(
                    'Mi Perfil',
                    style: TextStyle(
                      fontSize: 20 * widget.scaleFactor,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 80 * widget.scaleFactor, // Ajustado para evitar overflow
                        height: 80 * widget.scaleFactor,
                        child: FotoPerfilCircular(
                          imageUrl: UsuarioActual.fotoUrl,
                        ),
                      ),
                      SizedBox(width: 12 * widget.scaleFactor),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Hola, ${UsuarioActual.nombre}',
                              style: TextStyle(
                                fontSize: 18 * widget.scaleFactor,
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.onSurface,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              ubicacion,
                              style: TextStyle(
                                fontSize: 16 * widget.scaleFactor,
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}