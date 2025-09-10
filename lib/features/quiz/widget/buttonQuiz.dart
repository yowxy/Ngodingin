import 'package:flutter/material.dart';
import 'package:hology_fe/shared/theme.dart';

class ButtonQuiz extends StatefulWidget {
  final String text;
  final double width;
  final double height;

  const ButtonQuiz({
    required this.text,
    required this.width,
    required this.height,
    super.key,
  });

  @override
  State<ButtonQuiz> createState() => _ButtonQuizState();
}

class _ButtonQuizState extends State<ButtonQuiz> {
  bool _isClicked = false;

  void _handleTap() {
    setState(() {
      _isClicked = !_isClicked; // toggle warna
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap, 
      child: Container(
        width: widget.width,
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          color: _isClicked ? Colors.green : Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.green[100],
            child: Text(
              'A',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              widget.text,
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      )

      ),
    );
  }
}
