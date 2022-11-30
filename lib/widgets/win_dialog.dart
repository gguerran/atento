import 'package:flutter/material.dart';

class WinDialog extends StatelessWidget {
  final String message;
  final List<Widget>? actions;
  const WinDialog({Key? key, required this.message, this.actions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      backgroundColor: Colors.white,
      actionsAlignment: MainAxisAlignment.center,
      actionsPadding: const EdgeInsets.all(12),
      actions: actions,
      contentPadding: EdgeInsets.zero,
      content: Container(
        height: 80,
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Text(
            message,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 36,
            ),
          ),
        ),
      ),
    );
  }
}
