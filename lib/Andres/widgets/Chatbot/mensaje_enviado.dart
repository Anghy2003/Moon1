import 'package:flutter/material.dart';
import 'package:moon_aplication/shared/app_theme.dart';

class MensajeEnviado extends StatelessWidget {
  final String message;

  const MensajeEnviado({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight, 
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppTheme.primaryColor, 
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(40, 0, 0, 0),
              blurRadius: 6,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}