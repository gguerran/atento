import 'package:flutter/material.dart';

class LessPointsButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final int points;
  const LessPointsButton({
    super.key,
    required this.onPressed,
    required this.points,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: IconButton.styleFrom(
        padding: const EdgeInsets.all(16),
        minimumSize: const Size(120, 80),
      ),
      onPressed: onPressed,
      icon: Text("-$points", style: Theme.of(context).textTheme.labelLarge),
    );
  }
}
