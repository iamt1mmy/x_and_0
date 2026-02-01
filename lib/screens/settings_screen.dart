import 'package:flutter/material.dart';
import 'package:x_and_0/strings/strings.dart';

import '../models/enums.dart';

class SettingsScreen extends StatefulWidget {
  final GameMode initialMode;
  final AIDifficulty initialDifficulty;

  const SettingsScreen({super.key, required this.initialMode, required this.initialDifficulty});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late GameMode _mode;
  late AIDifficulty _difficulty;

  @override
  void initState() {
    super.initState();
    _mode = widget.initialMode;
    _difficulty = widget.initialDifficulty;
  }

  void _save() {
    Navigator.of(context).pop({'mode': _mode, 'difficulty': _difficulty});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(Strings.settings)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(Strings.gameMode, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            RadioListTile<GameMode>(
              title: const Text(Strings.twoPlayers),
              value: GameMode.local,
              groupValue: _mode,
              onChanged: (v) => setState(() => _mode = v!),
            ),
            RadioListTile<GameMode>(
              title: const Text(Strings.vsAI),
              value: GameMode.vsAI,
              groupValue: _mode,
              onChanged: (v) => setState(() => _mode = v!),
            ),
            const SizedBox(height: 16),
            const Text(Strings.aiDifficulty, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            DropdownButton<AIDifficulty>(
              value: _difficulty,
              items: AIDifficulty.values.map((d) {
                final label = d == AIDifficulty.easy ? 'Easy' : d == AIDifficulty.medium ? 'Medium' : 'Hard';
                return DropdownMenuItem(value: d, child: Text(label));
              }).toList(),
              onChanged: _mode == GameMode.vsAI ? (v) => setState(() => _difficulty = v!) : null,
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text(Strings.cancel)),
                const SizedBox(width: 8),
                ElevatedButton(onPressed: _save, child: const Text(Strings.save)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
