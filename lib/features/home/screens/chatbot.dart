import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hology_fe/features/home/widgets/header.dart';
import 'package:hology_fe/shared/theme.dart';

class Chatbot extends StatefulWidget {
  const Chatbot({super.key});

  @override
  State<Chatbot> createState() => _ChatbotState();
}

class _ChatbotState extends State<Chatbot> {
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(height: 20),
                              _aiMessage(),
                              _myMessage(),
                              _aiMessage(),
                              _myMessage(),
                              _aiMessage(),
                              _myMessage(),
                              _aiMessage(),
                              _myMessage(),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(99),
                        ),
                        child: TextField(
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
                                onPressed: () {},
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
}

Widget _aiMessage() {
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
          child: Text(
            "Haii, aku AI asisten belajar kamu. Apakah ada yang bisa aku bantu hari ini?",
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ),
    ],
  );
}

Widget _myMessage() {
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
                    "Tolong jelaskan kegunaan useState() dan useEffect()",
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
