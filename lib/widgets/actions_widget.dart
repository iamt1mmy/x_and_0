import 'package:flutter/material.dart';
import 'package:x_and_0/strings/strings.dart';

class ActionsWidget extends StatelessWidget {
  final VoidCallback onResetBoard;
  final VoidCallback onResetScores;

  const ActionsWidget({super.key, required this.onResetBoard, required this.onResetScores});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan.withOpacity(0.14), foregroundColor: Colors.cyanAccent),
          onPressed: onResetBoard,
          child: const Text(Strings.resetBoard),
        ),
        const SizedBox(width: 12),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.pink.withOpacity(0.14), foregroundColor: Colors.pinkAccent),
          onPressed: onResetScores,
          child: const Text(Strings.resetScores),
        ),
      ],
    );
  }
}
