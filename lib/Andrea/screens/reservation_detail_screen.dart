import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ReservaDetalladaScreen extends StatelessWidget {
  const ReservaDetalladaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

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
          borderSide: BorderSide(color: Colors.cyan, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.cyan[700]!, width: 2),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Color(0xFFE6F9FF), // Color de fondo celeste suave
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: Colors.black),
        centerTitle: true,
        title: const Text('2/4', style: TextStyle(color: Colors.black)),
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
              const SizedBox(height: 20),
              TextField(
                decoration: customInputDecoration('Persona Responsable'),
                controller: TextEditingController(text: 'Andrea Illescas'),
              ),
              const SizedBox(height: 15),
              TextField(
                decoration: customInputDecoration('Numero de Contacto'),
                keyboardType: TextInputType.phone,
                controller: TextEditingController(text: '+59399842000'),
              ),
              const SizedBox(height: 15),
              DropdownButtonFormField<String>(
                value: '2 Miembros',
                decoration: customInputDecoration('Miembro'),
                items: ['1 Miembro', '2 Miembros', '3 Miembros']
                    .map((value) => DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        ))
                    .toList(),
                onChanged: (value) {},
              ),
              const SizedBox(height: 15),
              DropdownButtonFormField<String>(
                value: 'Tarjeta de Identificacion',
                decoration: customInputDecoration('Tipo ID'),
                items: ['Tarjeta de Identificacion', 'Pasaporte']
                    .map((value) => DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        ))
                    .toList(),
                onChanged: (value) {},
              ),
              const SizedBox(height: 15),
              TextField(
                decoration: customInputDecoration('Numero de ID'),
                keyboardType: TextInputType.number,
                controller: TextEditingController(text: '002215487861'),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '\$799',
                    style: TextStyle(
                      fontSize: screenWidth * 0.06,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[700],
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyan,
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.06,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                       context.go('/metodo-pago');
                    },
                    child: Text(
                      'Metodo de Pago',
                      style: TextStyle(
                        fontSize: screenWidth * 0.045,
                        color: Colors.white,
                      ),
                    ),
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
