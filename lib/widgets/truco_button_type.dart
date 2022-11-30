import 'package:flutter/material.dart';

class TrucoTypeButtom extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget image;

  const TrucoTypeButtom({
    Key? key,
    required this.onPressed,
    required this.image,
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
      child: image,
    );
  }
}
