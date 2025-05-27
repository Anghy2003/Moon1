import 'package:flutter/material.dart';
import 'package:moon_aplication/Andrea/models/hotel.dart';
import 'package:moon_aplication/Andres/widgets/menu_principal/icono_me_gusta_horizontal.dart';

class CadaHotel extends StatelessWidget {
  final Hotel hotel;

  const CadaHotel({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150, 
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5)],
        image: DecorationImage(
          image: NetworkImage(hotel.imagenPrincipal),
          fit: BoxFit.cover,
        ),
      ),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.black.withAlpha(200),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  hotel.nombre,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 5),
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(200),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        "⭐ ${hotel.rating}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    // Usando el nuevo widget con detección de clics mejorada
                    GestureDetector(
                      onTap: () {
                        // Acción del clic en el corazón
                      },
                      child: IconoMeGustaInteractivo(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class IconoMeGustaInteractivo extends StatefulWidget {
  const IconoMeGustaInteractivo({super.key});

  @override
  _IconoMeGustaInteractivoState createState() => _IconoMeGustaInteractivoState();
}

class _IconoMeGustaInteractivoState extends State<IconoMeGustaInteractivo> {
  bool _esFavorito = false;

  void _toggleFavorito() {
    setState(() {
      _esFavorito = !_esFavorito;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 30, minHeight: 30), // Área táctil ajustada
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(200),
        borderRadius: BorderRadius.circular(8),
      ),
      child: GestureDetector(
        onTap: _toggleFavorito,
        child: IconoMeGustaHorizontal(
          color: _esFavorito ? Colors.grey : Colors.red,
        ),
      ),
    );
  }
}