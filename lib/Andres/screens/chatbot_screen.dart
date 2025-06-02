import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';  
import 'package:url_launcher/url_launcher.dart';  
import 'package:moon_aplication/Andres/controller/chatbot_service.dart';
import 'package:moon_aplication/Andres/widgets/gradiente_color_fondo.dart';
import 'package:moon_aplication/shared/app_theme.dart'; 
import 'package:moon_aplication/Diego/widgets/crazy_logo.dart';
import 'package:moon_aplication/Andres/widgets/Chatbot/ingreso_mensaje.dart'; 

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, String>> messages = [];
  bool _isLoading = false;
  final ChatbotService _chatbotService = ChatbotService();

  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.9,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    if (messages.isEmpty) {
      messages.add({
        "sender": "bot",
        "message":
            "¡Hola! Soy Brisa, el chatbot oficial de MOON 🤖. ¿Cómo puedo ayudarte hoy?"
      });
    }
  }

  void _sendMessage() async {
    if (_messageController.text.isEmpty) return;
    
    _animationController.forward().then((_) => _animationController.reverse());

    final userMessage = _messageController.text;

    setState(() {
      messages.add({"sender": "user", "message": userMessage});
      _isLoading = true;
    });
    _messageController.clear();

    String botResponse = await _chatbotService.sendMessage(userMessage);

    setState(() {
      messages.add({"sender": "bot", "message": botResponse});
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _animationController.dispose(); 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); 
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Asistente Brisa 🌬️"),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        extendBodyBehindAppBar: true,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
              gradient: GradienteColorFondo.backgroundGradient),
          child: Stack(
            children: [
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,  
                  child: CrazyLogo(),
                ),
              ),
              Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: messages.length + (_isLoading ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (_isLoading && index == messages.length) {
                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                SizedBox(
                                  width: 20,
                                  height: 20,
                                  child:
                                      CircularProgressIndicator(strokeWidth: 2),
                                ),
                                SizedBox(width: 10),
                                Text("Brisa está escribiendo..."),
                              ],
                            ),
                          );
                        }
                        final message = messages[index];
                        final bool isUser = message["sender"] == "user";
                        return Align(
                          alignment: isUser
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 6, horizontal: 10),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: isUser
                                  ? AppTheme.primaryColor
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromARGB(40, 0, 0, 0),
                                  blurRadius: 6,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: _buildMessageText(
                                message["message"]!, isUser),
                          ),
                        );
                      },
                    ),
                  ), 
                  IngresoMensaje(
                    messageController: _messageController,
                    onSend: _sendMessage,
                    scaleAnimation: _scaleAnimation,
                    animationController: _animationController,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('No se pudo abrir el enlace: $url');
    }
  }

  Widget _buildMessageText(String text, bool isUser) {
    return Linkify(
      onOpen: (link) async {
        await _launchURL(link.url);
      },
      text: text,
      style: TextStyle(color: isUser ? Colors.white : Colors.black),
      linkStyle: const TextStyle(
          color: Colors.blue, decoration: TextDecoration.underline),
    );
  }
}