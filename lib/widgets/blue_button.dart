import 'package:flutter/material.dart';

class BlueButtom extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;

  const BlueButtom({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text, style: Theme.of(context).textTheme.labelSmall),
    );
  }
}
