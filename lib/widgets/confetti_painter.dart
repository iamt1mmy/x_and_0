import 'dart:math';
import 'package:flutter/material.dart';

class ConfettiPainter extends CustomPainter {
  final double progress;
  final Random rand;
  final Color color;

  ConfettiPainter(this.progress, this.rand, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    final count = 24;
    for (int i = 0; i < count; i++) {
      final t = (i / count) * 2 * pi + progress * 6.28;
      final r = (size.width * 0.1) + progress * size.width * (0.6 + rand.nextDouble() * 0.4);
      final x = size.width / 2 + cos(t) * r;
      final y = size.height / 2 + sin(t) * r;
      paint.color = color.withOpacity(max(0.0, 1.0 - progress + rand.nextDouble() * 0.3));
      final s = 4.0 + rand.nextDouble() * 6.0 * (1.0 - progress);
      canvas.drawRect(Rect.fromCenter(center: Offset(x, y), width: s, height: s * 0.6), paint);
    }
  }

  @override
  bool shouldRepaint(covariant ConfettiPainter oldDelegate) => oldDelegate.progress != progress;
}
