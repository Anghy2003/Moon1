import 'package:flutter/material.dart';
import 'package:moon_aplication/Andrea/screens/payment_success_screen.dart';

class MetodoPagoScreen extends StatefulWidget {
  const MetodoPagoScreen({super.key});

  @override
  State<MetodoPagoScreen> createState() => _MetodoPagoScreenState();
}

class _MetodoPagoScreenState extends State<MetodoPagoScreen> {
  String _selectedMethod = 'credit_card';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '3/4',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true, // ⬅️ Esto centra el título
        backgroundColor: const Color(0xFFE0F7FA),
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      
      backgroundColor: const Color(0xFFE0F7FA), // Celeste claro
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [       
              const SizedBox(height: 16),
              Center(
                child: Text(
                  'Metodo de Pago',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.06,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              // Opciones de pago
              _buildPaymentOption(
                icon: Icons.credit_card,
                label: 'Tarjeta de Credito',
                value: 'credit_card',
              ),
              const SizedBox(height: 16),
              _buildPaymentOption(
                icon: Icons.account_balance_wallet,
                label: 'Pay Pal',
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
              // Total + botón
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Total'),
                      Text(
                        '\$799',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PagoExitosoScreen(),
                        ), // tu widget de destino
                      );
                    },

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
