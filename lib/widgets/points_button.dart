import 'package:flutter/material.dart';

class MorePointsButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final int points;
  const MorePointsButton(
      {Key? key, required this.onPressed, required this.points})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        padding: const EdgeInsets.all(16),
        minimumSize: const Size(120, 80),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        "+$points",
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w900,
          fontSize: 50,
        ),
      ),
    );
  }
}

class LessPointsButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final int points;
  const LessPointsButton(
      {Key? key, required this.onPressed, required this.points})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        padding: const EdgeInsets.all(16),
        minimumSize: const Size(120, 80),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        "-$points",
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w900,
          fontSize: 50,
        ),
      ),
    );
  }
}
