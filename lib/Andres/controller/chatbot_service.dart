import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:moon_aplication/Andres/widgets/Chatbot/get_key.dart';
import 'package:moon_aplication/Andres/widgets/Chatbot/indicaciones_bot.dart';

class ChatbotService {
  final String endpoint =
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent";

  Future<String> sendMessage(String userMessage) async {
    final String prompt = '''
${IndicacionesBot.indicaciones}

Usuario: $userMessage
''';

    final Map<String, dynamic> requestBody = {
      "contents": [
        {
          "parts": [
            {"text": prompt},
          ],
        },
      ],
    };

    try {
      final response = await http.post(
        Uri.parse("$endpoint?key=${GetKey.geminiApi}"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        String botResponse =
            data["candidates"]?[0]["content"]?["parts"]?[0]["text"]?.trim() ??
            "No se generó respuesta.";
        botResponse = botResponse.replaceAll("**", "");
        botResponse = botResponse.replaceAllMapped(
          RegExp(r"\+593(\d{9})"),
          (match) => "[${match.group(0)}](https://wa.me/593${match.group(1)})",
        );
        return botResponse;
      } else {
        throw Exception("Error ${response.statusCode}: ${response.body}");
      }
    } catch (e) {
      print("Error en ChatbotService: $e");
      return "Reintenta con otro mensaje.";
    }
  }
}
