import 'package:flutter/material.dart';
import 'package:hology_fe/shared/theme.dart';

void successMessage({String? message, BuildContext? context}) {
  ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
      content: Text(
        message!,
        style: whiteTextStyle,
      ),
      backgroundColor: greenColor));
}

void errorMessage({String? message, BuildContext? context}) {
  ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
      content: Text(
        message!,
        style: whiteTextStyle,
      ),
      backgroundColor: redBackgroundColor));
}