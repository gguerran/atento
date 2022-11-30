import 'package:flutter/material.dart';

class WhiteButtom extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;

  const WhiteButtom({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 10,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
          side: const BorderSide(color: Color(0xFF4380DC), width: 3),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(
            color: Color(0xFF1D1617),
            fontSize: 20,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
