import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moon_aplication/Andrea/models/hotel.dart';
import 'package:moon_aplication/Andrea/screens/payment_success_screen.dart';
import 'package:moon_aplication/services/services/usuario_actual.dart';


class MetodoPagoScreen extends StatefulWidget {
  final Hotel hotel;
  final DateTime fechaCheckIn;
  final DateTime fechaCheckOut;
  final String nombre;
  final String contacto;
  final String tipoId;
  final String numeroId;
  final String miembros;

  const MetodoPagoScreen({
    super.key,
    required this.hotel,
    required this.fechaCheckIn,
    required this.fechaCheckOut,
    required this.nombre,
    required this.contacto,
    required this.tipoId,
    required this.numeroId,
    required this.miembros, required double total, required String userId,
  });

  @override
  State<MetodoPagoScreen> createState() => _MetodoPagoScreenState();
}

class _MetodoPagoScreenState extends State<MetodoPagoScreen> {
  String _selectedMethod = 'credit_card';

  Future<void> _procesarPago() async {
    // Calcular cantidad de noches
    int cantidadNoches = widget.fechaCheckOut.difference(widget.fechaCheckIn).inDays;
    double total = cantidadNoches * widget.hotel.precioNoche;

    final reservaData = {
      'usuarioId': UsuarioActual.uid, // Solo el ID del usuario
      'hotel': {
        'id': widget.hotel.id,
        'nombre': widget.hotel.nombre,
        'descripcion': widget.hotel.descripcion,
        'precioNoche': widget.hotel.precioNoche,
      },
      'fechaCheckIn': widget.fechaCheckIn.toIso8601String(),
      'fechaCheckOut': widget.fechaCheckOut.toIso8601String(),
      'personaResponsable': widget.nombre,
      'numeroContacto': widget.contacto,
      'tipoId': widget.tipoId,
      'numeroId': widget.numeroId,
      'miembros': widget.miembros,
      'metodoPago': _selectedMethod,
      'total': total,
      'fechaReserva': DateTime.now().toIso8601String(),
    };

    await FirebaseFirestore.instance.collection('reservas').add(reservaData);

    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => PagoExitosoScreen(
          descripcionHotel: widget.hotel.descripcion,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final total = widget.hotel.precioNoche *
        widget.fechaCheckOut.difference(widget.fechaCheckIn).inDays;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '3/4',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFE0F7FA),
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFE0F7FA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Center(
                child: Text(
                  'Método de Pago',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.06,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              _buildPaymentOption(
                icon: Icons.credit_card,
                label: 'Tarjeta de Crédito',
                value: 'credit_card',
              ),
              const SizedBox(height: 16),
              _buildPaymentOption(
                icon: Icons.account_balance_wallet,
                label: 'PayPal',
                value: 'paypal',
              ),
              const SizedBox(height: 16),
              _buildPaymentOption(
                icon: Icons.phone_iphone,
                label: 'Apple Pay',
                value: 'apple_pay',
              ),
              const SizedBox(height: 24),
              Center(
                child: TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add_circle_outline),
                  label: const Text('Add more'),
                  style: TextButton.styleFrom(foregroundColor: Colors.black),
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Total'),
                      Text(
                        '\$${total.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: _procesarPago,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyan,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text(
                      'Procesar Pago',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentOption({
    required IconData icon,
    required String label,
    required String value,
  }) {
    final isSelected = _selectedMethod == value;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.blueAccent),
        title: Text(label),
        trailing: Checkbox(
          value: isSelected,
          onChanged: (_) {
            setState(() {
              _selectedMethod = value;
            });
          },
        ),
        onTap: () {
          setState(() {
            _selectedMethod = value;
          });
        },
      ),
    );
  }
}
