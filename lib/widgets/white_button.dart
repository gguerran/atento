import 'package:flutter/material.dart';

class WhiteButtom extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;

  const WhiteButtom({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
      onPressed: onPressed,
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Color(0xFF1D1617),
            ),
      ),
    );
  }
}
