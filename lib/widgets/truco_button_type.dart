import 'package:flutter/material.dart';

class TrucoTypeButtom extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget image;
  final bool isSelected;

  const TrucoTypeButtom({
    super.key,
    required this.onPressed,
    required this.image,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? const Color(0xFF4380DC) : Colors.white,
      ),
      onPressed: isSelected ? null : onPressed,
      child: image,
    );
  }
}
