import 'package:flutter/material.dart';

class BlueButtom extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;

  const BlueButtom({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF92A3FD),
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 15,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
