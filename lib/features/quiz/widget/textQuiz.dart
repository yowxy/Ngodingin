import 'package:flutter/material.dart';
import 'package:hology_fe/shared/theme.dart';

// ignore: camel_case_types
class textQuiz extends StatelessWidget {
  final String text;
    final double width;
    final double height;

  const textQuiz({
    required this.text,
    required this.height,
    required this.width,
    super.key
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
        margin: EdgeInsets.only(top: 20),
       padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20), // jangan kebesaran
        decoration: BoxDecoration(
          color: greenColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child:
        Text(
          text,
          style: whiteTextStyle.copyWith(
            fontWeight: semibold,
            fontSize: 20,
          ),
            overflow: TextOverflow.ellipsis,
        ),
    );
  }
}