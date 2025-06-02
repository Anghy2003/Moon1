import 'package:flutter/material.dart';
import 'package:moon_aplication/shared/app_theme.dart';

class BotonEnviar extends StatefulWidget {
  final VoidCallback onSend;

  const BotonEnviar({super.key, required this.onSend});

  @override
  State<BotonEnviar> createState() => _BotonEnviarState();
}

class _BotonEnviarState extends State<BotonEnviar> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
      lowerBound: 0.9,
      upperBound: 1.0,
    );
  }

  void _animateAndSend() {
    _controller.forward().then((_) {
      _controller.reverse();
      widget.onSend();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _controller,
      child: ElevatedButton(
        onPressed: _animateAndSend,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryColor,
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(14),
        ),
        child: const Icon(Icons.send, color: Colors.white),
      ),
    );
  }
}