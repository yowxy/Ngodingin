import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hology_fe/features/home/widgets/header.dart';
import 'package:hology_fe/shared/theme.dart';
import 'package:hology_fe/utils/gemini_service.dart';

class Chatbot extends StatefulWidget {
  const Chatbot({super.key});

  @override
  State<Chatbot> createState() => _ChatbotState();
}

class _ChatbotState extends State<Chatbot> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [
    {
      'role': 'ai',
      'text': 'Hai, saya asisten AI kamu yang ahli di bidang IT. Silakan tanyakan apapun seputar teknologi, pemrograman, atau komputer!'
    }
  ];
  bool _isLoading = false;
  final GeminiService _geminiService = GeminiService('AIzaSyDzabYNgBaUrPnwhfJCzFod6NB4aYXG1pw'); // Replace with your Gemini API key

  void _sendMessage() async {
    final prompt = _controller.text.trim();
    if (prompt.isEmpty) return;
    setState(() {
      _messages.add({'role': 'user', 'text': prompt});
      _isLoading = true;
      _controller.clear();
      // Add typing bubble
      _messages.add({'role': 'typing', 'text': 'typing...'});
    });
    // IT context priming
    final contextPrompt = 'Kamu adalah asisten AI yang ahli di bidang IT. Jawablah pertanyaan seputar teknologi, pemrograman, dan komputer. Jika pertanyaan di luar IT, arahkan ke topik IT.';
    final fullPrompt = contextPrompt + '\nPertanyaan user: ' + prompt;
    final response = await _geminiService.sendPrompt(fullPrompt);
    setState(() {
      // Remove typing bubble
      _messages.removeWhere((msg) => msg['role'] == 'typing');
      _messages.add({'role': 'ai', 'text': response});
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(),
            Expanded(
              child: Container(
                color: whitegreenColor,
                width: double.infinity,
                height: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: _messages.length,
                          itemBuilder: (context, index) {
                            final msg = _messages[index];
                            if (msg['role'] == 'user') {
                              return _myMessage(msg['text'] ?? '');
                            } else if (msg['role'] == 'ai') {
                              return _aiMessage(msg['text'] ?? '');
                            } else if (msg['role'] == 'typing') {
                              return _typingBubble();
                            } else {
                              return SizedBox.shrink();
                            }
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(99),
                        ),
                        child: TextField(
                          controller: _controller,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            hintText: "Tanyakan apapun disni...",
                            hintStyle: TextStyle(
                              fontSize: 14,
                              color: lightGrey,
                            ),
                            suffixIcon: Container(
                              width: 40,
                              height: 40,
                              margin: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: greenColor,
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                padding: EdgeInsets.only(right: 1, top: 2),
                                onPressed: _isLoading ? null : _sendMessage,
                                icon: Center(
                                  child: SvgPicture.asset(
                                    "assets/icons/send.svg",
                                    height: 18,
                                    width: 18,
                                  ),
                                ),
                              ),
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 15,
                            ),
                          ),
                          onSubmitted: (_) => _isLoading ? null : _sendMessage(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
Widget _typingBubble() {
  return Row(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Flexible(
        child: Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.only(right: 50, bottom: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
              SizedBox(width: 10),
              Text(
                'Typing...',
                style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
}

Widget _aiMessage(String text) {
  // Replace **bold** with TextSpan bold
  final spans = <InlineSpan>[];
  final regex = RegExp(r'\*\*(.*?)\*\*');
  int lastIndex = 0;
  for (final match in regex.allMatches(text)) {
    if (match.start > lastIndex) {
      spans.add(TextSpan(text: text.substring(lastIndex, match.start)));
    }
    spans.add(TextSpan(
      text: match.group(1),
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
    ));
    lastIndex = match.end;
  }
  if (lastIndex < text.length) {
    spans.add(TextSpan(text: text.substring(lastIndex)));
  }
  return Row(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Flexible(
        child: Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.only(right: 50, bottom: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
          ),
          child: RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 14, color: Colors.black),
              children: spans,
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _myMessage(String text) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Flexible(
        child: Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.only(left: 50, bottom: 20),
          decoration: BoxDecoration(
            color: greenColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(5),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: IntrinsicWidth(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Flexible(
                  fit: FlexFit.loose,
                  child: Text(
                    text,
                    style: const TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}
