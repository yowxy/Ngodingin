import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final double width;
  final double height;
  final Widget? suffixIcon;

  const CustomTextForm({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.width,
    required this.height,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
