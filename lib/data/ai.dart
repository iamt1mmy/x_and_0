import 'dart:math';

import 'game_logic.dart';

import '../models/enums.dart';
import 'package:x_and_0/strings/strings.dart';

int? getAIMove(List<String> board, AIDifficulty difficulty, Random rand) {
  final empties = [for (int i = 0; i < 9; i++) if (board[i] == '') i];
  if (empties.isEmpty) return null;

  if (difficulty == AIDifficulty.easy) {
    return empties[rand.nextInt(empties.length)];
  }

  if (difficulty == AIDifficulty.medium) {
    // Try win
    for (var i in empties) {
      final nb = List<String>.from(board);
      nb[i] = Strings.oSymbol;
      if (winningComboForBoard(nb, Strings.oSymbol) != null) return i;
    }
    // Try block
    for (var i in empties) {
      final nb = List<String>.from(board);
      nb[i] = Strings.xSymbol;
      if (winningComboForBoard(nb, Strings.xSymbol) != null) return i;
    }
    return empties[rand.nextInt(empties.length)];
  }

  // Hard: Minimax
  return _minimaxDecision(board, rand);
}

int? _minimaxDecision(List<String> board, Random rand) {
  final empties = [for (int i = 0; i < 9; i++) if (board[i] == '') i];
  if (empties.isEmpty) return null;
  if (empties.length == 9) return 4;

  int bestScore = -1000000;
  int? bestMove;
  for (var move in empties) {
    final nb = List<String>.from(board);
    nb[move] = Strings.oSymbol;
    final score = _minimax(nb, 0, false);
    if (score > bestScore) {
      bestScore = score;
      bestMove = move;
    }
  }
  return bestMove ?? empties[rand.nextInt(empties.length)];
}

int _minimax(List<String> board, int depth, bool isMaximizing) {
  final winner = checkWinner(board);
  if (winner == Strings.oSymbol) return 10 - depth;
  if (winner == Strings.xSymbol) return -10 + depth;
  if (!board.contains('')) return 0;

  if (isMaximizing) {
    int best = -100000;
    for (int i = 0; i < 9; i++) {
        if (board[i] == '') {
        board[i] = Strings.oSymbol;
        final val = _minimax(board, depth + 1, false);
        board[i] = '';
        best = max(best, val);
      }
    }
    return best;
  } else {
    int best = 100000;
    for (int i = 0; i < 9; i++) {
        if (board[i] == '') {
        board[i] = Strings.xSymbol;
        final val = _minimax(board, depth + 1, true);
        board[i] = '';
        best = min(best, val);
      }
    }
    return best;
  }
}
