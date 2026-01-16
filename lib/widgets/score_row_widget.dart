import 'package:flutter/material.dart';

class ScoreRow extends StatelessWidget {
  final Map<String, int> score;

  const ScoreRow({super.key, required this.score});

  Widget _scoreCard(String label, int value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.02), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.white10)),
      child: Column(children: [Text(label, style: TextStyle(color: color.withOpacity(0.9), fontWeight: FontWeight.w600)), const SizedBox(height: 6), Text('$value', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        _scoreCard('X', score['X'] ?? 0, Colors.cyanAccent),
        _scoreCard('Draws', score['Draws'] ?? 0, Colors.white70),
        _scoreCard('O', score['O'] ?? 0, Colors.pinkAccent),
      ]),
    );
  }
}
