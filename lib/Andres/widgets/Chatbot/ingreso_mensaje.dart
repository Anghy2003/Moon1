import 'package:flutter/material.dart';
import 'package:moon_aplication/shared/app_theme.dart';

class IngresoMensaje extends StatelessWidget {
  final TextEditingController messageController;
  final VoidCallback onSend;
  final Animation<double> scaleAnimation;
  final AnimationController animationController;

  const IngresoMensaje({
    super.key,
    required this.messageController,
    required this.onSend,
    required this.scaleAnimation,
    required this.animationController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: messageController,
              decoration: InputDecoration(
                hintText: "Escribe tu mensaje...",
                fillColor: Colors.white,
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide:
                      BorderSide(color: AppTheme.primaryColor, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide:
                      BorderSide(color: AppTheme.primaryColor, width: 2),
                ),
              ),
              onSubmitted: (_) => onSend(),
            ),
          ),
          const SizedBox(width: 10),
          ScaleTransition(
            scale: scaleAnimation,
            child: ElevatedButton(
              onPressed: () {
                animationController
                    .forward()
                    .then((_) => animationController.reverse());
                onSend();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(14),
              ),
              child: const Icon(Icons.send, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}