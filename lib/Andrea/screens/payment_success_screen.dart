import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PagoExitosoScreen extends StatelessWidget {
  const PagoExitosoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffebebf5),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              "PAGO\nEXITOSO",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                "Descripcion del pago exitoso dependiendo del paquete ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
            ),
            const SizedBox(height: 30),
            
            // Ícono de pago exitoso
            const FaIcon(
              FontAwesomeIcons.circleCheck,
              size: 100,
              color: Color(0xff00c4cc),
            ),
            
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Acción al continuar
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff00c4cc),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              child: const Text(
                'Continuar',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
     
    );
  }
}
