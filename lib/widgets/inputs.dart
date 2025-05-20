import 'package:flutter/material.dart';

class Inputs_Login extends StatelessWidget {
  const Inputs_Login({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Usuario',
        labelStyle: const TextStyle(
          color: Color(0xFF00BECF), // Celeste
          fontWeight: FontWeight.bold,
        ),
        floatingLabelStyle: const TextStyle(
          color: Color(0xFF00BECF),
          backgroundColor:
              Colors.white, // Fondo para simular el recorte
        ),
        hintText: 'Andrea Illescas',
        hintStyle: const TextStyle(color: Colors.grey),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: const BorderSide(
            color: Color(0xFF00BECF),
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: const BorderSide(
            color: Color(0xFF00BECF),
            width: 2,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
      ),
      style: const TextStyle(fontSize: 16),
    );
  }
}
