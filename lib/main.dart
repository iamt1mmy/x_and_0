import 'package:flutter/material.dart';

import 'screens/app.dart';

void main() {
  runApp(const TicTacToeApp());
}

// Backwards-compatible wrapper for tests that expect `MyApp`.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TicTacToeApp();
  }
}
