import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../models/enums.dart';
import '../data/ai.dart';
import '../data/game_logic.dart';
import 'package:x_and_0/strings/strings.dart';
import 'settings_screen.dart';
import '../widgets/home_header.dart';
import '../widgets/board_widget.dart';
import '../widgets/score_row_widget.dart';
import '../widgets/actions_widget.dart';
import '../widgets/celebration_overlay.dart';

class HomeScreen extends StatefulWidget {
  final bool isDark;
  final VoidCallback onToggleTheme;

  const HomeScreen({
    super.key,
    required this.isDark,
    required this.onToggleTheme,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  List<String> _board = List.filled(9, '');
  String _currentPlayer = Strings.xSymbol;
  Map<String, int> _score = {Strings.xSymbol: 0, Strings.oSymbol: 0, Strings.draws: 0};
  GameMode _mode = GameMode.local;
  AIDifficulty _difficulty = AIDifficulty.hard;

  bool _isAnimating = false;
  List<int> _winningCombo = [];

  late AnimationController _particleController;
  final Random _rand = Random();

  @override
  void initState() {
    super.initState();
    _particleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
  }

  @override
  void dispose() {
    _particleController.dispose();
    super.dispose();
  }

  void _newGame({bool keepScore = true}) {
    setState(() {
      _board = List.filled(9, '');
      _currentPlayer = Strings.xSymbol;
      _winningCombo = [];
      _isAnimating = false;
      if (!keepScore) _score = {Strings.xSymbol: 0, Strings.oSymbol: 0, Strings.draws: 0};
    });
  }

  void _makeMove(int index) async {
    if (_board[index] != '' || _winningCombo.isNotEmpty || _isAnimating) return;

    setState(() => _board[index] = _currentPlayer);

    final winner = checkWinner(_board);
    if (winner != null) {
      _onWin(winner);
      return;
    }

    if (!_board.contains('')) {
      setState(() => _score[Strings.draws] = _score[Strings.draws]! + 1);
      _triggerDrawAnimation();
      return;
    }

    _togglePlayer();

    if (_mode == GameMode.vsAI && _currentPlayer == Strings.oSymbol) {
      await Future.delayed(const Duration(milliseconds: 350));
      final aiMove = getAIMove(_board, _difficulty, _rand);
      if (aiMove != null) _makeMove(aiMove);
    }
  }

  void _togglePlayer() {
    setState(() {
      _currentPlayer = _currentPlayer == Strings.xSymbol ? Strings.oSymbol : Strings.xSymbol;
    });
  }

  void _onWin(String winner) {
    final combo = winningComboForBoard(_board, winner);
    if (combo != null) {
      setState(() {
        _winningCombo = combo;
        _score[winner] = _score[winner]! + 1;
        _isAnimating = true;
      });
      _particleController.forward(from: 0.0);
      Timer(const Duration(seconds: 2), () {
        setState(() => _isAnimating = false);
      });
    }
  }

  void _triggerDrawAnimation() {
    setState(() {
      _isAnimating = true;
    });
    _particleController.forward(from: 0.0);
    Timer(const Duration(seconds: 1), () {
      setState(() => _isAnimating = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF06070A), Color(0xFF0E1530)],
                ),
              ),
            ),
            LayoutBuilder(
              builder: (context, constraints) {
                const reserved = 220.0;
                final maxAvailable = constraints.maxHeight - reserved;
                final boardSize = maxAvailable > 100
                    ? min(constraints.maxWidth * 0.92, maxAvailable)
                    : min(
                        constraints.maxWidth * 0.92,
                        constraints.maxHeight * 0.5,
                      );

                return Column(
                  children: [
                    const SizedBox(height: 18),
                    HomeHeader(
                      title: Strings.appTitle,
                      subtitle: Strings.appSubtitle,
                      onSettingsPressed: () async {
                        final res = await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => SettingsScreen(
                              initialMode: _mode,
                              initialDifficulty: _difficulty,
                            ),
                          ),
                        );
                        if (res is Map) {
                          setState(() {
                            _mode = res['mode'] as GameMode? ?? _mode;
                            _difficulty =
                                res['difficulty'] as AIDifficulty? ??
                                _difficulty;
                            _newGame(keepScore: true);
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 12),
                    ScoreRow(score: _score),
                    const SizedBox(height: 12),
                    Expanded(
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: BackdropFilter(
                            filter: ui.ImageFilter.blur(sigmaX: 14, sigmaY: 14),
                            child: Container(
                              width: boardSize,
                              height: boardSize,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.03),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.06),
                                ),
                              ),
                              child: BoardWidget(
                                board: _board,
                                winningCombo: _winningCombo,
                                size: boardSize - 32,
                                onTap: _makeMove,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    ActionsWidget(
                      onResetBoard: () => _newGame(keepScore: true),
                      onResetScores: () => _newGame(keepScore: false),
                    ),
                    const SizedBox(height: 12),
                  ],
                );
              },
            ),
            if (_isAnimating)
              CelebrationOverlay(
                controller: _particleController,
                rand: _rand,
                winner: checkWinner(_board),
                isDraw: checkWinner(_board) == null && !_board.contains(''),
              ),
          ],
        ),
      ),
    );
  }
}
