import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; 
import 'package:moon_aplication/Andrea/models/reservas.dart';

class MostrarDetallesReservados extends StatelessWidget {
  final Reserva reserva;

  const MostrarDetallesReservados({super.key, required this.reserva});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text(
        "Detalles de la Reserva",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      tilePadding: EdgeInsets.zero,
      collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _detalleItem("📅 Fecha de inicio:", _formatFecha(reserva.fechaInicio)),
              _detalleItem("📅 Fecha de fin:", _formatFecha(reserva.fechaFin)),
              _detalleItem("👤 Responsable:", reserva.detallesUsuario.personaResponsable),
              _detalleItem("📞 Contacto:", reserva.detallesUsuario.numeroContacto),
              _detalleItem("👨‍👩‍👧‍👦 Miembros:", reserva.detallesUsuario.numMiembros.toString()),
              _detalleItem("🆔 Tipo de identificación:", reserva.detallesUsuario.tipoIdentificacion),
              _detalleItem("💳 Método de pago:", reserva.metodoPago.tipoPago),
              _detalleItem("🔢 Número de identificación:", reserva.detallesUsuario.numeroId),
            ],
          ),
        ),
      ],
    );
  }

  
  String _formatFecha(DateTime fecha) {
    return DateFormat('dd/MM/yyyy').format(fecha); 
  }

  Widget _detalleItem(String titulo, String valor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(text: titulo, style: const TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: " $valor"),
          ],
        ),
      ),
    );
  }
}