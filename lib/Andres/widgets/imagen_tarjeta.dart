import 'package:flutter/material.dart';
class ImagenTarjeta extends StatelessWidget {
  const ImagenTarjeta({
    super.key,
    required this.hotel,
  });

  final Map<String, dynamic> hotel;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      hotel['imageUrl'],
      width: 160,
      height: 130,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: 80,
          height: 80,
          color: Colors.grey.shade300,
          child: const Icon(Icons.error, color: Colors.red),
        );
      },
    );
  }
}