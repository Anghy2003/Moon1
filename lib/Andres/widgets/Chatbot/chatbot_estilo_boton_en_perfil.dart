import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:moon_aplication/Andres/screens/chatbot_screen.dart';
import 'package:moon_aplication/shared/app_theme.dart';

class ChatbotEstiloBotonPerfil extends StatefulWidget {
  const ChatbotEstiloBotonPerfil({super.key});

  @override
  State<ChatbotEstiloBotonPerfil> createState() => _ChatbotEstiloBotonPerfilState();
}

class _ChatbotEstiloBotonPerfilState extends State<ChatbotEstiloBotonPerfil> {
  bool _isLoading = false;

  void _openChatbot() {
    setState(() {
      _isLoading = true;
    });

    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ChatBotScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final double scaleFactor = AppTheme.scaleFactor(context);

    return Align(
      alignment: Alignment.center,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 24 * scaleFactor,
            vertical: 12 * scaleFactor,
          ),
        ),
        onPressed: _isLoading ? null : _openChatbot,
        child: SizedBox(
          width: 120, 
          height: 30, 
          child: Center(
            child: _isLoading
                ? const SpinKitSpinningLines(color: Colors.white, size: 30) 
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ClipOval(
                        child: const Icon(Icons.smart_toy, color: Colors.white, size: 24),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        "Soporte IA",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}