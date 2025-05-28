import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        height: 200, // Puedes ajustar el tamaño aquí
        child: SvgPicture.asset(
          "assets/moon_logo.svg",
          fit: BoxFit.contain,
          alignment: Alignment.center,
          placeholderBuilder: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorBuilder: (context, error, stackTrace) => const Icon(
            Icons.broken_image,
            size: 80,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
