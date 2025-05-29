import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:moon_aplication/Andrea/models/hotel.dart';
import 'package:moon_aplication/Andrea/screens/metodo_pago.dart';

class ReservaDetalladaScreen extends StatefulWidget {
  final Hotel hotel;
  final DateTime fechaCheckIn;
  final DateTime fechaCheckOut;

  const ReservaDetalladaScreen({
    super.key,
    required this.hotel,
    required this.fechaCheckIn,
    required this.fechaCheckOut,
  });

  @override
  State<ReservaDetalladaScreen> createState() => _ReservaDetalladaScreenState();
}

class _ReservaDetalladaScreenState extends State<ReservaDetalladaScreen> {
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController contactoController = TextEditingController();
  final TextEditingController idController = TextEditingController();

  String? tipoId = 'Tarjeta de Identificacion';
  String? miembros = '1 Miembro';
  String? userId;

  @override
  void initState() {
    super.initState();
    obtenerNombreUsuario();
  }

  Future<void> obtenerNombreUsuario() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        userId = user.uid;
      });
      final snapshot = await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(user.uid)
          .get();
      if (snapshot.exists) {
        final data = snapshot.data();
        setState(() {
          nombreController.text = data?['nombre'] ?? '';
        });
      }
    }
  }

  InputDecoration customInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(
          color: Colors.cyan[700], fontWeight: FontWeight.bold),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: Colors.cyan, width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: Colors.cyan[700]!, width: 2),
      ),
    );
  }

  int calcularNoches() {
    return widget.fechaCheckOut.difference(widget.fechaCheckIn).inDays;
  }

  double calcularTotal() {
    return calcularNoches() * widget.hotel.precioNoche;
  }

  void validarYContinuar() {
    if (nombreController.text.isEmpty ||
        contactoController.text.isEmpty ||
        idController.text.isEmpty ||
        tipoId == null ||
        miembros == null ||
        userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor completa todos los campos.')),
      );
    } else {
      final total = calcularTotal();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MetodoPagoScreen(
            hotel: widget.hotel,
            fechaCheckIn: widget.fechaCheckIn,
            fechaCheckOut: widget.fechaCheckOut,
            nombre: nombreController.text,
            contacto: contactoController.text,
            tipoId: tipoId!,
            numeroId: idController.text,
            miembros: miembros!,
            total: total,
            userId: userId!,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final total = calcularTotal();

    return Scaffold(
      backgroundColor: const Color(0xFFE6F9FF),
      appBar: AppBar(
        title: const Text('2/4',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        centerTitle: true,
        backgroundColor: const Color(0xFFE0F7FA),
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text('Reserva Detallada',
                    style: TextStyle(
                        fontSize: screenWidth * 0.06,
                        fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: customInputDecoration('Persona Responsable'),
                controller: nombreController,
              ),
              const SizedBox(height: 15),
              TextField(
                decoration: customInputDecoration('Número de Contacto'),
                keyboardType: TextInputType.phone,
                controller: contactoController,
              ),
              const SizedBox(height: 15),
              DropdownButtonFormField<String>(
                value: miembros,
                decoration: customInputDecoration('Miembros'),
                items: ['1 Miembro', '2 Miembros', '3 Miembros']
                    .map((value) =>
                        DropdownMenuItem(value: value, child: Text(value)))
                    .toList(),
                onChanged: (value) => setState(() => miembros = value),
              ),
              const SizedBox(height: 15),
              DropdownButtonFormField<String>(
                value: tipoId,
                decoration: customInputDecoration('Tipo de ID'),
                items: ['Tarjeta de Identificacion', 'Pasaporte']
                    .map((value) =>
                        DropdownMenuItem(value: value, child: Text(value)))
                    .toList(),
                onChanged: (value) => setState(() => tipoId = value),
              ),
              const SizedBox(height: 15),
              TextField(
                decoration: customInputDecoration('Número de ID'),
                keyboardType: TextInputType.number,
                controller: idController,
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total',
                      style: TextStyle(
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.w500)),
                  Text('\$${total.toStringAsFixed(2)}',
                      style: TextStyle(
                          fontSize: screenWidth * 0.06,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[700])),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyan,
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.06, vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: validarYContinuar,
                    child: Text('Método de Pago',
                        style: TextStyle(
                            fontSize: screenWidth * 0.045,
                            color: Colors.white)),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
