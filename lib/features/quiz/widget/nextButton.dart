import 'package:flutter/material.dart';
import 'package:hology_fe/shared/theme.dart';

class nextButtonQuiz extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  final VoidCallback? onPressed;

  const nextButtonQuiz({
    required this.text,
    required this.width,
    required this.height,
    this.onPressed,
    super.key
    });

  @override
  Widget build(BuildContext context) {
   return SizedBox(
    
        width: width,
        height: height,
        child: TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            backgroundColor: greenColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(56),
            ),
          ),
          child: Text(
            text,
            style: whiteTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semibold,
            ),
          ),
        ),
      );
  }
}