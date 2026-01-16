import 'package:flutter/material.dart';

import 'home_screen.dart';

class TicTacToeApp extends StatefulWidget {
  const TicTacToeApp({super.key});

  @override
  State<TicTacToeApp> createState() => _TicTacToeAppState();
}

class _TicTacToeAppState extends State<TicTacToeApp> {
  bool _isDark = true;

  void _toggleTheme() => setState(() => _isDark = !_isDark);

  @override
  Widget build(BuildContext context) {
    final darkTheme = ThemeData.dark().copyWith(
      scaffoldBackgroundColor: const Color(0xFF0B0F1A),
      brightness: Brightness.dark,
      textTheme: ThemeData.dark().textTheme.apply(
            bodyColor: Colors.white,
            displayColor: Colors.white,
          ),
    );

    final lightTheme = ThemeData.light().copyWith(
      scaffoldBackgroundColor: const Color(0xFFF6F7FB),
      brightness: Brightness.light,
      textTheme: ThemeData.light().textTheme.apply(
            bodyColor: Colors.black87,
            displayColor: Colors.black87,
          ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'X and O',
      theme: _isDark ? darkTheme : lightTheme,
      home: HomeScreen(isDark: _isDark, onToggleTheme: _toggleTheme),
    );
  }
}
