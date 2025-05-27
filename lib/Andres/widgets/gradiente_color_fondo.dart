import 'package:flutter/material.dart';

class GradienteColorFondo {
  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 209, 245, 254),
      Color.fromARGB(255, 255, 255, 255),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}