import 'package:flutter/material.dart';

class CustomButtonRefrences extends StatefulWidget {
  final String title;
  final double width;
  final double height;
  final VoidCallback? onPressed;

  const CustomButtonRefrences({
    super.key,
    required this.title,
    required this.width,
    required this.height,
    this.onPressed,
  });

  @override
  State<CustomButtonRefrences> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButtonRefrences> {
  bool _isClicked = false;

  void _handleTap() {
    setState(() {
      _isClicked = !_isClicked; // toggle warna
    });
    widget.onPressed?.call();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        width: widget.width,
        height: widget.height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: _isClicked ? Colors.green : Colors.white,
          border: Border.all(
            color: Colors.green,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(50), // biar pill shape
        ),
        child: Text(
          widget.title,
          style: TextStyle(
            color: _isClicked ? Colors.white : Colors.green,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
