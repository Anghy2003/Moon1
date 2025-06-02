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
  final TextEditingController miembrosController = TextEditingController();

  String? tipoId = 'Tarjeta de Identificacion';
  String? miembros = '1 Miembro';
  String? userId;

  @override
  void initState() {
    super.initState();
    obtenerNombreYDatos();
  }

  Future<void> obtenerNombreYDatos() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      userId = user.uid;

      try {
        final reservas = await FirebaseFirestore.instance
            .collection('reservas')
            .where('usuarioId', isEqualTo: user.uid)
            .get();

        if (reservas.docs.isNotEmpty) {
          final reserva = reservas.docs.first.data();
          setState(() {
            nombreController.text = reserva['personaResponsable'] ?? '';
            contactoController.text = reserva['numeroContacto'] ?? '';
            final m = reserva['miembros']?.toString().split(' ').first ?? '1';
            miembros = '$m Miembro${m == '1' ? '' : 's'}';
            miembrosController.text = miembros!;
          });
        } else {
          setState(() {
            nombreController.text = user.displayName ?? '';
          });
        }
      } catch (e) {
        print('Error al obtener reservas: $e');
        setState(() {
          nombreController.text = user.displayName ?? '';
        });
      }
    }
  }

  InputDecoration customInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(
        color: Colors.cyan[700],
        fontWeight: FontWeight.bold,
      ),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Colors.cyan, width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: Colors.cyan[700]!, width: 2),
      ),
    );
  }

  int calcularNoches() {
    final diferencia = widget.fechaCheckOut.difference(widget.fechaCheckIn).inDays;
    return diferencia > 0 ? diferencia : 1;
  }

  double calcularTotal() {
    return calcularNoches() * widget.hotel.precioNoche;
  }

  bool validarIdentificacion(String id) {
    if (tipoId == 'Tarjeta de Identificacion') {
      return validarCedulaEcuatoriana(id);
    } else {
      return validarPasaporte(id);
    }
  }

  bool validarCedulaEcuatoriana(String cedula) {
    if (cedula.length != 10) return false;
    final int provincia = int.parse(cedula.substring(0, 2));
    final int digitoVerificador = int.parse(cedula[9]);

    if (provincia < 1 || provincia > 24) return false;

    int suma = 0;
    for (int i = 0; i < 9; i++) {
      int valor = int.parse(cedula[i]);
      if (i % 2 == 0) {
        valor *= 2;
        if (valor > 9) valor -= 9;
      }
      suma += valor;
    }

    int decenaSuperior = ((suma ~/ 10) + 1) * 10;
    int resultado = decenaSuperior - suma;
    if (resultado == 10) resultado = 0;

    return resultado == digitoVerificador;
  }

  bool validarPasaporte(String pasaporte) {
    final regex = RegExp(r'^[A-Za-z0-9]{6,15}$');
    return regex.hasMatch(pasaporte);
  }

  void validarYContinuar() {
    if (nombreController.text.isEmpty ||
        contactoController.text.isEmpty ||
        idController.text.isEmpty ||
        tipoId == null ||
        miembrosController.text.isEmpty ||
        userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor completa todos los campos.')),
      );
      return;
    }

    if (!validarIdentificacion(idController.text)) {
      final mensajeError = tipoId == 'Tarjeta de Identificacion'
          ? 'Número de cédula inválido.'
          : 'Número de pasaporte inválido (solo letras/números, 6-15 caracteres).';

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(mensajeError)),
      );
      return;
    }

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
          miembros: miembrosController.text,
          total: total,
          userId: userId!,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final total = calcularTotal();

    return Scaffold(
      backgroundColor: const Color(0xFFE6F9FF),
      appBar: AppBar(
        title: const Text(
          '2/4',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
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
                child: Text(
                  'Reserva Detallada',
                  style: TextStyle(
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: nombreController,
                decoration: customInputDecoration('Persona Responsable'),
              ),
              const SizedBox(height: 25),
              TextField(
                controller: contactoController,
                keyboardType: TextInputType.phone,
                decoration: customInputDecoration('Número de Contacto'),
              ),
              const SizedBox(height: 25),
              TextField(
                controller: miembrosController,
                keyboardType: TextInputType.text,
                decoration: customInputDecoration('Miembros (Ej: 3 Miembros)'),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: miembros,
                decoration: customInputDecoration('Seleccionar Miembros'),
                iconEnabledColor: Colors.cyan[700],
                style: TextStyle(
                  color: Colors.cyan[700],
                  fontWeight: FontWeight.bold,
                ),
                items: List.generate(
                  10,
                  (index) => DropdownMenuItem<String>(
                    value: '${index + 1} Miembro${index == 0 ? '' : 's'}',
                    child: Text('${index + 1} Miembro${index == 0 ? '' : 's'}'),
                  ),
                ),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      miembros = value;
                      miembrosController.text = value;
                    });
                  }
                },
              ),
              const SizedBox(height: 25),
              DropdownButtonFormField<String>(
                value: tipoId,
                decoration: customInputDecoration('Tipo de ID'),
                items: ['Tarjeta de Identificacion', 'Pasaporte']
                    .map((tipo) => DropdownMenuItem(
                          value: tipo,
                          child: Text(tipo),
                        ))
                    .toList(),
                onChanged: (value) => setState(() => tipoId = value),
              ),
              const SizedBox(height: 25),
              TextField(
                controller: idController,
                keyboardType: TextInputType.text,
                decoration: customInputDecoration('Número de ID'),
              ),
              const SizedBox(height: 95),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total: \$${total.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[700],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: validarYContinuar,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyan,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Método de Pago',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
