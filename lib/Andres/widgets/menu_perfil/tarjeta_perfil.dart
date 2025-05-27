import 'package:flutter/material.dart';
import 'package:moon_aplication/Andres/widgets/menu_perfil/foto_perfil_circular.dart';

class TarjetaPerfil extends StatelessWidget {
  final double scaleFactor;

  const TarjetaPerfil({super.key, required this.scaleFactor});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8 * scaleFactor), 
      child: Container(
        height: 132 * scaleFactor, 
        decoration: BoxDecoration(
          color: Colors.transparent, // Hace la tarjeta completamente transparente
          borderRadius: BorderRadius.circular(20 * scaleFactor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20 * scaleFactor, 0, 3 * scaleFactor, 0),
              child: Text(
                'Mi Perfil',
                style: TextStyle(
                  fontSize: 21 * scaleFactor, 
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 100 * scaleFactor, 
                  height: 100 * scaleFactor,
                  child: FotoPerfilCircular(
                    imageUrl: "https://eduv.tecazuay.edu.ec/pluginfile.php/40622/user/icon/academi/f1?rev=594406",
                  ),
                ),
                SizedBox(width: 12 * scaleFactor), 
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Hola, Meche',
                      style: TextStyle(
                        fontSize: 18 * scaleFactor, 
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    Text(
                      'Cuenca, Ecuador',
                      style: TextStyle(
                        fontSize: 16 * scaleFactor, 
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}