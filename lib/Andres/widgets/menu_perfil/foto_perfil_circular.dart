import 'package:flutter/material.dart';

class FotoPerfilCircular extends StatelessWidget {
  final String imageUrl; 

  const FotoPerfilCircular({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: CircleAvatar(
        radius: 40,
        backgroundImage: NetworkImage(imageUrl),
      ),
    );
  }
}