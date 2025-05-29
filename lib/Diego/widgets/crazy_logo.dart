import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CrazyLogo extends StatefulWidget {
  const CrazyLogo({super.key});

  @override
  State<CrazyLogo> createState() => _CrazyLogoState();
}

class _CrazyLogoState extends State<CrazyLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (_, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: child,
        );
      },
      child: SvgPicture.asset(
        "assets/moon_logo_512x512_fixed.svg",
        height: 200,
        fit: BoxFit.contain,
        alignment: Alignment.center,
        allowDrawingOutsideViewBox: true,
      ),
    );
  }
}
