import 'package:flutter/material.dart';

import 'cell_widget.dart';

class BoardWidget extends StatelessWidget {
  final List<String> board;
  final List<int> winningCombo;
  final double size;
  final void Function(int) onTap;

  const BoardWidget({super.key, required this.board, required this.winningCombo, required this.size, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final cellSize = size / 3;
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemCount: 9,
      itemBuilder: (context, index) {
        final value = board[index];
        final highlighted = winningCombo.contains(index);
        return GestureDetector(
          onTap: () => onTap(index),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: highlighted ? (value == 'X' ? Colors.cyan.withOpacity(0.12) : Colors.pink.withOpacity(0.12)) : Colors.white.withOpacity(0.01),
              borderRadius: BorderRadius.circular(12),
              boxShadow: highlighted
                  ? [BoxShadow(color: (value == 'X' ? Colors.cyanAccent : Colors.pinkAccent).withOpacity(0.18), blurRadius: 18, spreadRadius: 2)]
                  : [],
            ),
            child: Center(child: CellWidget(symbol: value, size: cellSize * 0.6, neon: value == 'X' ? Colors.cyanAccent : Colors.pinkAccent)),
          ),
        );
      },
    );
  }
}
