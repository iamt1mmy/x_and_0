import 'package:flutter/material.dart';
import 'dart:math';

import 'confetti_painter.dart';

class CelebrationOverlay extends StatelessWidget {
  final AnimationController controller;
  final Random rand;
  final String? winner;
  final bool isDraw;

  const CelebrationOverlay({super.key, required this.controller, required this.rand, required this.winner, required this.isDraw});

  @override
  Widget build(BuildContext context) {
    final text = isDraw ? "It's a draw" : '${winner} wins!';
    final color = isDraw ? Colors.white : (winner == 'X' ? Colors.cyanAccent : Colors.pinkAccent);
    return Positioned.fill(
      child: IgnorePointer(
        ignoring: false,
        child: Container(
          color: Colors.black.withOpacity(0.35),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedBuilder(
                  animation: controller,
                  builder: (context, _) => CustomPaint(size: const Size(300, 180), painter: ConfettiPainter(controller.value, rand, color)),
                ),
                const SizedBox(height: 8),
                Container(padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12), decoration: BoxDecoration(color: Colors.white.withOpacity(0.04), borderRadius: BorderRadius.circular(12)), child: Text(text, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
